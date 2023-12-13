//主逻辑，生成随机数，在start信号到来时，开始计时，同时点亮LED，
//在stop信号到来时，停止计时，同时熄灭LED
//然后检查是否犯规，如果犯规，显示F，否则显示计时结果
module MainLogic(
    clk_50M,clear,start,stop,CounterFlag,CounterOut,codeout,LED
);
//输入：
//clk_50M：50MHz时钟，clear：清零，start：开始，stop：停止
input clk_50M,clear,start,stop;
//输出：
//CounterFlag：用于控制计数器的开始、停止、清零
//00->清零，01->停止，10->开始
output reg [1:0]CounterFlag;
//CounterOut：计数器输出，要求计算到999
output reg [9:0]CounterOut;
//codeout：七段数码管输出，LED：LED指示灯
output reg[6:0] codeout;
//LED：LED指示灯
output reg LED;

//内部信号：
//RandomNum：随机数，用于产生随机时间，2s到6s之间
//在50MHz时钟下，2s到6s之间的时间为100000000到300000000
reg [31:0]RandomNum;

//clear_temp:保存clear信号的上一次状态，用于检测clear信号的上升沿
//start_temp:保存start信号的上一次状态，用于检测start信号的上升沿
//stop_temp:保存stop信号的上一次状态，用于检测stop信号的上升沿
reg clear_temp,start_temp,stop_temp;

//counter，内置计数器，用于计算随机时间，在随机时间结束后，开始计时，同时点亮LED
 reg [31:0]counter;

initial begin
    clear_temp <= 1'b0;
    start_temp <= 1'b0;
    stop_temp <= 1'b0;
    CounterFlag <= 2'b00;
    CounterOut <= 10'b0;
    codeout <= 7'b0000000;
    LED <= 1'b0;
    counter <= 32'b0;
    RandomNum <= 32'b0;
end

always @(posedge clk_50M) begin
    //检测clear信号的上升沿
    if(clear_temp == 1'b0 && clear == 1'b1) begin
        CounterFlag <= 2'b00;
        CounterOut <= 10'b0;
        codeout <= 7'b0000000;
        LED <= 1'b0;
        counter <= 32'b0;
        RandomNum <= 32'b0;
    end

    //检测start信号的上升沿
    if(start_temp == 1'b0 && start == 1'b1) begin
        //产生随机数
        RandomNum <= $random;
        //随机数范围为0到2^32-1，将其限制在100000000到300000000之间
        RandomNum <= RandomNum % 200000000 + 100000000;
    end

    //检测stop信号的上升沿
    if(stop_temp == 1'b0 && stop == 1'b1) begin
        //停止计时，同时熄灭LED
        CounterFlag <= 2'b01;
        LED <= 1'b0;
        //检查是否犯规，如果犯规，显示F，否则显示计时结果
        if (counter < RandomNum) begin
            codeout <= 7'b1101101;
        end

        RandomNum <= 32'b0;//清零随机数
        counter <= 32'b0;//清零计数器
        //不要求清零CounterOut，因为CounterOut需要作为数码管的输入一直保持
    end

    //检查是否到达随机时间
    if (RandomNum != 0 && counter == RandomNum) begin
        //开始计时，同时点亮LED
        CounterFlag <= 2'b10;
        LED <= 1'b1;
    end
    else if (RandomNum != 0 && counter != RandomNum) begin
        counter <= counter + 1;//更新内置计数器
    end
    
    //更新clear_temp，start_temp，stop_temp
    clear_temp <= clear;
    start_temp <= start;
    stop_temp <= stop;
end

endmodule
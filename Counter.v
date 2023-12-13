//计数器，每1ms加1，计数到999时停止计数
//由MainLogic通过传递CounterFlag控制开始、停止、清零
module Counter(
    clk_50M,CounterFlag,CounterOut
);
//输入：
//clk_50M：50MHz时钟
//CounterFlag：用于控制计数器的开始、停止、清零
//00->清零，01->停止，10->开始
input clk_50M;
input [1:0]CounterFlag;
//输出：
//CounterOut：计数器输出，要求计算到999
output reg [9:0]CounterOut;

//内部信号：
//counter：内置计数器，在50MHz时钟下，每1ms计数1000次
reg [31:0]counter;

initial begin
    //初始化
    counter <= 32'b0;
    CounterOut <= 10'b0;
end

always @(posedge clk_50M) begin
    //根据CounterFlag控制计数器的开始、停止、清零
    case(CounterFlag)
        2'b00:begin
            //清零
            counter <= 32'b0;
            CounterOut <= 10'b0;
        end
        2'b01:begin
            //停止
            counter <= counter;
            CounterOut <= CounterOut;
        end
        2'b10:begin
            //开始
            if (counter != 32'd50000) begin
                counter <= counter + 1;
            end
            else begin
                counter <= 32'b0;
                if (CounterOut != 10'd999) begin
                    CounterOut <= CounterOut + 1;
                end
                else begin
                    CounterOut <= 10'd999;
                end
            end
        end
        default:begin
            //异常情况，停止计数
            counter <= counter;
            CounterOut <= CounterOut;
        end
    endcase
end
endmodule
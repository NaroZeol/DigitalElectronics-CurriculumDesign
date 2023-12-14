module FinalDesign (
    clk_50M,clear,start,stop,DIG,codeout,LED,LED_InRuning
);

//输入：
//clk_50M：50MHz时钟，clear：清零，start：开始，stop：停止
input clk_50M,clear,start,stop;

//输出：
//DIG：数码管位选
output wire[7:0] DIG;
//codeout：七段数码管输出
output wire[6:0] codeout;
//LED：LED指示灯
output wire LED;
//LED_InRuning：用于标识运行中
output wire LED_InRuning;

//内部信号：
//CounterOut_wire：连接计数器输出，要求计算到999
//CounterFlag_wire：用于控制计数器的开始、停止、清零
//00->清零，01->停止，10->开始
//ErrorFlag_wire：用于控制数码管显示犯规指示
wire [9:0]CounterOut_wire;
wire [1:0]CounterFlag_wire;
wire ErrorFlag_wire;

//主逻辑，生成随机数，在start信号到来时，开始计时，同时点亮LED，
//在stop信号到来时，停止计时，同时熄灭LED
//然后检查是否犯规，如果犯规，显示E，否则显示计时结果
MainLogic ML(
    .clk_50M(clk_50M),
    .clear(clear),
    .start(start),
    .stop(stop),
    .CounterFlag(CounterFlag_wire),//根据不同输入信号产生不同的CounterFlag
    .ErrorFlag(ErrorFlag_wire),//控制数码管显示犯规指示    
    .LED(LED),//控制LED指示灯
    .LED_InRuning(LED_InRuning)
);

//计数器，每1ms加1，计数到999时停止计数
//由MainLogic通过传递CounterFlag控制开始、停止、清零
Counter C(
    .clk_50M(clk_50M),
    .CounterFlag(CounterFlag_wire),
    .CounterOut(CounterOut_wire)
);

//动态扫描数码管，显示计数器的值，以及犯规指示(以F表示)
//仅与计时器通信，不与其他模块通信
DynamicScanTubes DST(
    .clk_50M(clk_50M),
    .DataIn(CounterOut_wire),
    .ErrorFlag(ErrorFlag_wire),
    .DIG(DIG),
    .codeout(codeout)
);

endmodule
// （1）电路有三个输入按键：clear，start 和 stop，使用一个 LED 作为视觉刺激指示灯，
// 在七段数码管上显示相应的信息。
// （2）当按下 clear 键时，电路回到初始状态，七段数码管给出一个初始显示，同时 LED
// 指示灯熄灭。
// （3）当按下 start 键，七段数码管熄灭，产生一段 2s 到 6s（包括 2s 和 6s）之间的随机
// 时间之后，LED 指示灯点亮，计数器开始加计数。计数器每 1ms 加 1，它的值以 XXX 的
// 格式显示在数码管上。
// （4）被测试者看到 LED 指示灯点亮后，立即按下 stop 键，此时计数器暂停计数，数
// 码管显示的就是被测试者的反应时间。大多数人的反应时间在 0.1-0.3s 之间。
// （5）如果不按下 stop 键，计时器达到 999 之后停止计数。
// （6）如果 LED 指示灯点亮前，按下 stop 键，被视为犯规，数码管上应给出犯规指示。
// （7）连续进行多次测试后，可查阅所有测试结果中的最短时间、最长时间和平均时间。
// （8）两个人比赛，显示两人的反应时间及获胜者。
module completion_timer (
    clk_50M,clear,start,stop,codeout,LED
);

//输入：
//clk_50M：50MHz时钟，clear：清零，start：开始，stop：停止
input clk_50M,clear,start,stop;

//输出：
//codeout：七段数码管输出，LED：LED指示灯
output reg[6:0] codeout;
output reg LED;

//内部信号：
//CounterOut：计数器输出，要求计算到999
//CounterFlag：用于控制计数器的开始、停止、清零
//00->清零，01->停止，10->开始
reg [9:0]CounterOut;
reg [1:0]CounterFlag;

//主逻辑，生成随机数，在start信号到来时，开始计时，同时点亮LED，
//在stop信号到来时，停止计时，同时熄灭LED
//然后检查是否犯规，如果犯规，显示F，否则显示计时结果
MainLogic ML(
    .clk_50M(clk_50M),
    .clear(clear),
    .start(start),
    .stop(stop),
    .CounterFlag(CounterFlag),//根据不同输入信号产生不同的CounterFlag
    .CounterOut(CounterOut),//接受计数器输出用于判断是否犯规
    .codeout(codeout),//控制数码管显示犯规指示    
    .LED(LED)//控制LED指示灯
);

//计数器，每1ms加1，计数到999时停止计数
//由MainLogic通过传递CounterFlag控制开始、停止、清零
Counter C(
    .clk_50M(clk_50M),
    .CounterFlag(CounterFlag),
    .CounterOut(CounterOut)
);

//动态扫描数码管，显示计数器的值，以及犯规指示(以F表示)
//仅与计时器通信，不与其他模块通信
DynamicScanTubes DST(
    .clk_50M(clk_50M),
    .DataIn(CounterOut),
    .codeout(codeout)
);

endmodule
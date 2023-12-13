module DynamicScanTubes(clk_50M, DataIn, DIG, codeout);
    //输入信号
    input clk_50M;
    input [9:0] DataIn;//计数器的值
    
    //输出信号
    output [7:0] DIG;
    output [6:0] codeout;

    //内部信号
	wire [1:0] SEL;
	wire [3:0] Y;
	wire clk_1k;
	
	DivFreq e(clk_50M, clk_1k);//分频器	
    ModFourCounter a(clk_1k, en, SEL);//模4计数器
    DataTransformer b(SEL, DataIn, Y);//4-1数据选择器(选择计数器输入的某一位)
    Decoder c(Y, codeout);///七段线译码器
    Two2FourDecoder d(SEL, DIG);//2-4译码器，选择要亮起的数码管
endmodule
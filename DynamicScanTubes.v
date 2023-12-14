module DynamicScanTubes(clk_50M, DataIn, ErrorFlag, DIG, codeout);
    //输入信号
    input clk_50M;
    input ErrorFlag;//犯规指示
    input [9:0] DataIn;//计数器的值
    
    //输出信号
    output reg[7:0] DIG;
    output reg[6:0] codeout;

    //内部信号
	reg [1:0] SEL;
	reg [9:0] Y;
	reg new_clk;
	reg [15:0] counter;//16位计数器

    initial begin
        counter <= 0;//计数器清零
        new_clk <= 0;//时钟初始化
		  SEL <= 2'b00;
		  Y <= 10'b0;
		  DIG <= 8'b0000_0000;
    end

    //时钟分频
    always @(posedge clk_50M) begin
        if (counter == 1500) begin
            counter <= 0;//计数器清零
            new_clk <= ~new_clk;//时钟跳变
        end else begin
            counter <= counter + 1;//计数器加一
        end
    end

    //模四计数器
    always @(posedge new_clk)
    begin
        if (SEL == 2'd2)
            SEL <= 2'd0;
        else
            SEL <= SEL + 1;
    end

    //数码管显示
    always @(SEL)
    begin
        case (SEL)
            2'd0: Y <= DataIn % 10;//输入数据的倒数第一位
            2'd1: Y <= (DataIn / 10) % 10;//输入数据的倒数第二位 
            2'd2: Y <= DataIn / 100;//输入数据的倒数第三位
            default: Y <= 4'b0000; 
        endcase
    end

    //数码管译码
    always @(*)
    begin
        if (ErrorFlag == 1)
            codeout = 7'b1111001;//E
        else
            case(Y)
            4'd0 : codeout = 7'b0111111;//gfedcba
            4'd1 : codeout = 7'b0000110;
            4'd2 : codeout = 7'b1011011;
            4'd3 : codeout = 7'b1001111;
            4'd4 : codeout = 7'b1100110;
            4'd5 : codeout = 7'b1101101;
            4'd6 : codeout = 7'b1111101;
            4'd7 : codeout = 7'b0000111;
            4'd8 : codeout = 7'b1111111;
            4'd9 : codeout = 7'b1101111;
            default: codeout = 7'b0000000;
            endcase
    end
    
    //数码管显示
    always @(SEL)
    begin 
        case (SEL)
            2'd0: DIG <= 8'b0000_0001;//第一个数码管亮起
            2'd1: DIG <= 8'b0000_0010;//第二个数码管亮起
            2'd2: DIG <= 8'b0000_0100;//第三个数码管亮起
            default: DIG <= 8'b0000_0000;
        endcase
    end
	 
endmodule

//4-1数据选择器，从输入的三位十进制数中选择某一位
module DataTransformer(SEL,Data, Y);
    input [1:0] SEL;//模4计数器的值
    input [9:0]Data;//输入数据
    output reg [9:0] Y;//输入数据的某位数的二进制表示

    initial begin
        Y <= 10'b0;
    end

    always @(SEL)
    begin
        case (SEL)
            2'd0: Y <= Data % 10;//输入数据的倒数第一位
            2'd1: Y <= (Data / 10) % 10;//输入数据的倒数第二位 
            2'd2: Y <= Data / 100;//输入数据的倒数第三位
            default: Y <= 4'b0000; 
        endcase
    end
endmodule
//2-4译码器，选择要亮起的数码管
module Two2FourDecoder(SEL, DIG);
    input [1:0] SEL;//模4计数器的值
    output reg[7:0] DIG;//要亮起的数码管

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
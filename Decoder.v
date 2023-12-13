//七段线译码器
module Decoder(Y, ErrorFlag, codeout);
    input [9:0] Y;
    input ErrorFlag;
    output reg[6:0] codeout;
    
    always @(*)
    begin
        if (ErrorFlag == 1)
            codeout = 7'b1111001;//F
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
endmodule
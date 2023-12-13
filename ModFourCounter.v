//模4计数器
module ModFourCounter(clk_1k, SEL);
    input clk_1k;
    output reg [1:0] SEL;
    
    initial begin
        SEL <= 2'b00;
    end

    always @(posedge clk_1k)
    begin
        if (SEL == 2'd2)
            SEL <= 2'd0;
        else
            SEL <= SEL + 1;
    end
endmodule

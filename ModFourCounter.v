//模4计数器
module ModFourCounter(new_clk, SEL);
    input new_clk;
    output reg [1:0] SEL;
    
    initial begin
        SEL <= 2'b00;
    end

    always @(posedge new_clk)
    begin
        if (SEL == 2'd2)
            SEL <= 2'd0;
        else
            SEL <= SEL + 1;
    end
endmodule

//分频器： 50Mhz->1000Hz
module DivFreq(clk_50M, new_clk);
	 
	input clk_50M;
    output reg new_clk;
	reg [15:0] counter;//16位计数器

    initial begin
        counter <= 0;//计数器清零
        new_clk <= 0;//时钟初始化
    end

    always @(posedge clk_50M) begin
        if (counter == 1500) begin
            counter <= 0;//计数器清零
            new_clk <= ~new_clk;//时钟跳变
        end else begin
            counter <= counter + 1;//计数器加一
        end
    end
endmodule
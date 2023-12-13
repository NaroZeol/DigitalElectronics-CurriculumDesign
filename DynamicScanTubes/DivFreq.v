//分频器： 50Mhz->1000Hz
module DivFreq(clk_50M, clk_1k);
	 
	input clk_50M;
    output reg clk_1k;
	reg [15:0] counter;//16位计数器

    initial begin
        counter <= 0;//计数器清零
        clk_1k <= 0;//时钟初始化
    end

    always @(posedge clk_50M) begin
        if (counter == 50000 - 1) begin
            counter <= 0;//计数器清零
            clk_1k <= ~clk_1k;//时钟跳变
        end else begin
            counter <= counter + 1;//计数器加一
        end
    end
endmodule
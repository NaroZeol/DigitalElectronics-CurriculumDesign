module FinalDesign_tb;

reg clk_50M;
reg clear;
reg start;
reg stop;
wire [7:0] DIG;
wire [6:0] codeout;
wire LED;

// Instantiate the design under test
FinalDesign DUT (
    .clk_50M(clk_50M),
    .clear(clear),
    .start(start),
    .stop(stop),
    .DIG(DIG),
    .codeout(codeout),
    .LED(LED)
);

// Clock generation, 20ns period, 50MHz frequency
always #10 clk_50M = ~clk_50M;

// Testbench stimulus
initial begin
    // Initialize inputs
    clk_50M = 0;
    clear = 1;
    start = 0;
    stop = 0;

    // Wait for a few clock cycles
    #100;

    // Release clear signal
    clear = 0;

    // Wait for a few clock cycles
    #100;

    // Set start signal
    start = 1;

    #500000000;//Waiting for 0 ~ 1 second(0~1000000000ns) 

    // Set stop signal
    stop = 1;

    #100000000;//Waiting for 0 ~ 1 second(0~1000000000ns)
end

endmodule
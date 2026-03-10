module cpu_tb;

logic clk;
logic reset;

cpu_top DUT(
    .clk(clk),
    .reset(reset)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    reset = 1;
    #20
    reset = 0;

    #500
    $finish;
end

endmodule

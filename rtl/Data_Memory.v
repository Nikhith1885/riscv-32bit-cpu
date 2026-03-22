
module Data_Memory(
    input clk,
    input MemWrite,
    input MemRead,
    input [31:0] addr,
    input [31:0] write_data,
    output reg [31:0] read_data
);

reg [31:0] mem [0:255];
integer i;

// Initialize memory
initial begin
    for(i = 0; i < 256; i = i + 1)
        mem[i] = 32'b0;
end

// Write operation (synchronous)
always @(posedge clk) begin
    if (MemWrite)
        mem[addr[9:2]] <= write_data;
end

// Read operation (combinational)
always @(*) begin
    if (MemRead)
        read_data = mem[addr[9:2]];
    else
        read_data = 32'b0;
end

endmodule

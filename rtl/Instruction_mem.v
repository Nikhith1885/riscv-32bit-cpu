`timescale 1ns / 1ps
module Instruction_mem(
input [31:0] addr,
output [31:0] instruction
);

reg [31:0] mem [0:255];
integer i;

initial begin

for(i=0;i<256;i=i+1)
mem[i] = 32'b0;

mem[0] = 32'h00500093; // addi x1,x0,5
mem[1] = 32'h00A00113; // addi x2,x0,10
mem[2] = 32'h002081B3; // add x3,x1,x2
mem[3] = 32'h00302023; // sw x3,0(x0)
mem[4] = 32'h00002203; // lw x4,0(x0)

end

assign instruction = mem[addr[9:2]];

endmodule

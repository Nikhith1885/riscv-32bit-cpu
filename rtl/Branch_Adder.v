`timescale 1ns / 1ps
module Branch_Adder(
input [31:0] pc,
input [31:0] imm,
output [31:0] branch_addr
);

assign branch_addr = pc + imm;

endmodule

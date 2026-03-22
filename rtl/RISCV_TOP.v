`timescale 1ns / 1ps
module RISCV_TOP(
    input clk,
    input rst,
    output [31:0] pc_out,
    output [31:0] alu_out
);

wire [31:0] pc, pc4, instruction;
wire [31:0] rd1, rd2, imm;
wire [31:0] alu_src, alu_result;
wire [31:0] mem_data, write_back;
wire [31:0] branch_addr, pc_next;

wire Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
wire [1:0] ALUOp;
wire [3:0] ALUctrl;
wire zero;
wire branch_taken;

program_counter PC(clk, rst, pc_next, pc);
pc_adder PCADD(pc, pc4);
Instruction_mem IM(pc, instruction);
Control_Unit CU(instruction[6:0], Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);
Register_file RF(clk, RegWrite, instruction[19:15], instruction[24:20], instruction[11:7], write_back, rd1, rd2);
Imm_Gen IG(instruction, imm);
MUX2to1 MUX1(rd2, imm, ALUSrc, alu_src);
ALUControl ALUCTRL(ALUOp, instruction[31:25], instruction[14:12], ALUctrl);
ALU ALU1(rd1, alu_src, ALUctrl, alu_result, zero);
Data_Memory DM(clk, MemWrite, MemRead, alu_result, rd2, mem_data);
MUX2to1_DataMemory WB(alu_result, mem_data, MemtoReg, write_back);
Branch_Adder BA(pc4, imm, branch_addr);

assign branch_taken = Branch & zero;
pc_mux PCMUX(pc4, branch_addr, branch_taken, pc_next);

// ✅ Outputs (prevent optimization removal)
assign pc_out = pc;
assign alu_out = alu_result;

endmodule

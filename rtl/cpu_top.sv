module cpu_top(
    input logic clk,
    input logic reset
);

logic [31:0] pc;
logic [31:0] pc_next;
logic [31:0] instruction;

logic [6:0] opcode;
logic [4:0] rs1, rs2, rd;

logic [31:0] reg_data1;
logic [31:0] reg_data2;

logic [31:0] alu_result;

logic RegWrite, MemRead, MemWrite;
logic [31:0] mem_data;
logic [31:0] write_back;

pc PC(
    .clk(clk),
    .reset(reset),
    .pc_next(pc_next),
    .pc(pc)
);

instruction_memory IM(
    .addr(pc),
    .instruction(instruction)
);

instruction_decoder ID(
    .instruction(instruction),
    .opcode(opcode),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd)
);

control_unit CU(
    .opcode(opcode),
    .RegWrite(RegWrite),
    .MemRead(MemRead),
    .MemWrite(MemWrite)
);

register_file RF(
    .clk(clk),
    .regWrite(RegWrite),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .write_data(write_back),
    .read_data1(reg_data1),
    .read_data2(reg_data2)
);

alu ALU(
    .a(reg_data1),
    .b(reg_data2),
    .alu_ctrl(4'b0000),
    .result(alu_result)
);

data_memory DM(
    .clk(clk),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .addr(alu_result),
    .write_data(reg_data2),
    .read_data(mem_data)
);

assign write_back = mem_data;

assign pc_next = pc + 4;

endmodule

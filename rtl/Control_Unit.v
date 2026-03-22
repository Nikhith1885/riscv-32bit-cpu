`timescale 1ns / 1ps
module Control_Unit(
    input [6:0] opcode,
    output reg Branch,
    output reg MemRead,
    output reg MemtoReg,
    output reg [1:0] ALUOp,
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite
);

always @(*) begin

    // ✅ Default values (prevents latches)
    ALUSrc   = 0;
    MemtoReg = 0;
    RegWrite = 0;
    MemRead  = 0;
    MemWrite = 0;
    Branch   = 0;
    ALUOp    = 2'b00;

    case(opcode)

        // R-type
        7'b0110011: begin
            ALUSrc   = 0;
            RegWrite = 1;
            ALUOp    = 2'b10;
        end

        // I-type (addi)
        7'b0010011: begin
            ALUSrc   = 1;
            RegWrite = 1;
            ALUOp    = 2'b00;
        end

        // Load
        7'b0000011: begin
            ALUSrc   = 1;
            MemtoReg = 1;
            RegWrite = 1;
            MemRead  = 1;
        end

        // Store
        7'b0100011: begin
            ALUSrc   = 1;
            MemWrite = 1;
        end

        // Branch
        7'b1100011: begin
            Branch = 1;
            ALUOp  = 2'b01;
        end

    endcase
end

endmodule

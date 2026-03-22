`timescale 1ns / 1ps
module ALUControl(
    input [1:0] ALUOp,
    input [6:0] funct7,
    input [2:0] funct3,
    output reg [3:0] ALU_ctrl
);

always @(*) begin
    case(ALUOp)

        2'b00: ALU_ctrl = 4'b0010; // ADD
        2'b01: ALU_ctrl = 4'b0110; // SUB

        2'b10: begin
            case({funct7, funct3})
                10'b0000000000: ALU_ctrl = 4'b0010; // ADD
                10'b0100000000: ALU_ctrl = 4'b0110; // SUB
                10'b0000000111: ALU_ctrl = 4'b0000; // AND
                10'b0000000110: ALU_ctrl = 4'b0001; // OR
                default:        ALU_ctrl = 4'b0010;
            endcase
        end

        default: ALU_ctrl = 4'b0010;

    endcase
end

endmodule

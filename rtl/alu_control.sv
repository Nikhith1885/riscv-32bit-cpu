module alu_control(
    input  logic [1:0] ALUOp,
    input  logic [2:0] funct3,
    input  logic [6:0] funct7,
    output logic [3:0] alu_ctrl
);

always_comb begin

case(ALUOp)

2'b00: alu_ctrl = 4'b0000; // add

2'b01: alu_ctrl = 4'b0001; // sub

2'b10: begin
    case({funct7,funct3})

    10'b0000000000: alu_ctrl = 4'b0000; // add
    10'b0100000000: alu_ctrl = 4'b0001; // sub
    10'b0000000111: alu_ctrl = 4'b0010; // and
    10'b0000000110: alu_ctrl = 4'b0011; // or

    default: alu_ctrl = 4'b0000;

    endcase
end

default: alu_ctrl = 4'b0000;

endcase

end

endmodule

module alu(

    input  logic [31:0] a,          // operand 1
    input  logic [31:0] b,          // operand 2
    input  logic [3:0]  alu_ctrl,   // ALU control signal

    output logic [31:0] result,     // ALU result
    output logic zero               // zero flag for branch
);

always_comb begin

    case(alu_ctrl)

        4'b0000: result = a + b;        // ADD
        4'b0001: result = a - b;        // SUB
        4'b0010: result = a & b;        // AND
        4'b0011: result = a | b;        // OR
        4'b0100: result = a ^ b;        // XOR
        4'b0101: result = a << b[4:0];  // SLL
        4'b0110: result = a >> b[4:0];  // SRL
        4'b0111: result = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0; // SLT

        default: result = 32'b0;

    endcase

end

// Zero flag used for BEQ instruction
assign zero = (result == 32'b0);

endmodule

module immediate_generator(
    input  logic [31:0] instruction,
    output logic [31:0] imm
);

always_comb begin
    case(instruction[6:0])

        7'b0000011: // LW
            imm = {{20{instruction[31]}}, instruction[31:20]};

        7'b0100011: // SW
            imm = {{20{instruction[31]}},
                   instruction[31:25],
                   instruction[11:7]};

        default:
            imm = 32'b0;

    endcase
end

endmodule

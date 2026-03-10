module register_file(

    input  logic        clk,
    input  logic        RegWrite,
    
    input  logic [4:0]  rs1,
    input  logic [4:0]  rs2,
    input  logic [4:0]  rd,

    input  logic [31:0] write_data,

    output logic [31:0] read_data1,
    output logic [31:0] read_data2

);

    // 32 registers (x0 - x31)
    logic [31:0] registers [31:0];

    // Read operations (combinational)
    assign read_data1 = registers[rs1];
    assign read_data2 = registers[rs2];

    // Write operation (synchronous)
    always_ff @(posedge clk) begin
        if (RegWrite && rd != 5'b00000) begin
            registers[rd] <= write_data;
        end
    end

    // x0 is always zero in RISC-V
    always_comb begin
        registers[0] = 32'b0;
    end

endmodule

`timescale 1ns / 1ps
module Register_file(
    input clk,
    input RegWrite,
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input [31:0] write_data,
    output [31:0] read_data1,
    output [31:0] read_data2
);

reg [31:0] registers [0:31];
integer i;

// Initialize registers
always @(posedge clk)
begin
 if(RegWrite && rd != 0)
  registers[rd] <= write_data;
end

// Read logic (RISC-V compliant: x0 = 0)
assign read_data1 = (rs1 == 0) ? 32'b0 : registers[rs1];
assign read_data2 = (rs2 == 0) ? 32'b0 : registers[rs2];

// Write logic
always @(posedge clk) begin
    if (RegWrite && rd != 0)
        registers[rd] <= write_data;
end

endmodule

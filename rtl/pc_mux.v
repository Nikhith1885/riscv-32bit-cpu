
module pc_mux(
input [31:0] pc4,
input [31:0] branch,
input sel,
output [31:0] pc_next
);

assign pc_next = sel ? branch : pc4;

endmodule


module tb_riscv_top;

reg clk;
reg rst;

RISCV_TOP dut(clk,rst);

always #5 clk = ~clk;

initial begin

clk = 0;
rst = 1;

#20
rst = 0;

#1000
$stop;

end
initial begin
$monitor("PC = %h  INSTR = %h", dut.pc, dut.instruction);
$display("x1 = %d", uut.rf.registers[1]);
$display("x2 = %d", uut.rf.registers[2]);
$display("x3 = %d", uut.rf.registers[3]);
$display("x4 = %d", uut.rf.registers[4]);
end

endmodule

module instruction_memory (
    input  logic [31:0] addr,        // address from PC
    output logic [31:0] instruction  // fetched instruction
);

    // Memory array (256 instructions)
    logic [31:0] memory [0:255];

    // Load instructions from file
    initial begin
        $readmemh("program.mem", memory);
    end

    // Word aligned addressing
    assign instruction = memory[addr[9:2]];

endmodule

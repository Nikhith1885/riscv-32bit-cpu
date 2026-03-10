module data_memory(

    input  logic        clk,
    input  logic        MemRead,
    input  logic        MemWrite,

    input  logic [31:0] addr,
    input  logic [31:0] write_data,

    output logic [31:0] read_data

);

    // Data memory (256 words)
    logic [31:0] memory [0:255];

    // Write operation
    always_ff @(posedge clk) begin
        if (MemWrite)
            memory[addr[9:2]] <= write_data;
    end

    // Read operation
    always_comb begin
        if (MemRead)
            read_data = memory[addr[9:2]];
        else
            read_data = 32'b0;
    end

endmodule

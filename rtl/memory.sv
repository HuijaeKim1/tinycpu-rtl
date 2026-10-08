module memory(
    input logic clk,
    input logic mem_write,
    input logic [7:0] address,
    input logic [7:0] write_data,
    output logic [7:0] read_data
);

    logic [7:0] memory [0:255];      // Memory array

    // write into the memory at rising clock edge
    always_ff @(posedge clk) begin
        if (mem_write == 1) begin       // If "we can write"
            memory[address] <= write_data;  // Write the data into the memory
        end
    end

    // Read the value at a memory address
    always_comb begin
        read_data = memory[address];
    end


endmodule
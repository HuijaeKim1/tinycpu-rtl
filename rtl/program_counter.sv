module program_counter(
    input logic clk,
    input logic jump,
    input logic reset,
    input logic [7:0] jump_address,
    output logic [7:0] pc
);

    always_ff @(posedge clk) begin

        // Reset has highest priority
        if (reset) begin
            pc <= 0;
        end

        // Jump to the specified address
        else if (jump) begin
            pc <= jump_address;
        end

        else begin
            pc <= pc + 1;
        end

    end

endmodule
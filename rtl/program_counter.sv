module program_counter(
    input logic clk,
    input logic jump,
    input logic reset,
    input logic pc_enable,
    input logic [7:0] jump_address,
    output logic [7:0] pc
);

    always_ff @(posedge clk) begin

        // Reset has highest priority
        if (reset) begin
            pc <= 0;
        end

        // Only update PC when enabled
        else if (pc_enable) begin

            if (jump) begin
                pc <= jump_address;
            end

            else begin
                pc <= pc + 1;
            end

        end

    end

endmodule
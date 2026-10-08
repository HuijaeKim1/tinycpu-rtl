module control_unit(
    input logic [2:0] opcode,
    output logic [1:0] alu_op,
    output logic reg_write,
    output logic mem_write,
    output logic jump
);

    // Combinational control logic
    always_comb begin

        // Default values
        alu_op = 2'b00;
        reg_write = 0;
        mem_write = 0;
        jump = 0;

        case (opcode)

            // HALT
            3'b000: begin
                // No control signals enabled
            end

            // ADD
            3'b001: begin
                alu_op = 2'b00;
                reg_write = 1;
            end

            // SUB
            3'b010: begin
                alu_op = 2'b01;
                reg_write = 1;
            end

            // AND
            3'b011: begin
                alu_op = 2'b10;
                reg_write = 1;
            end

            // OR
            3'b100: begin
                alu_op = 2'b11;
                reg_write = 1;
            end

            // LOAD
            3'b101: begin
                reg_write = 1;
            end

            // STORE
            3'b110: begin
                mem_write = 1;
            end

            // JUMP
            3'b111: begin
                jump = 1;
            end

            // Default case
            default: begin
                alu_op = 2'b00;
                reg_write = 0;
                mem_write = 0;
                jump = 0;
            end

        endcase

    end

endmodule
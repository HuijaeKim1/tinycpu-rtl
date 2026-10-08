
module control_unit_tb;

    logic [2:0] opcode;
    logic [1:0] alu_op;
    logic reg_write;
    logic mem_write;
    logic jump;

    // Device Under Test
    control_unit dut(
        .opcode(opcode),
        .alu_op(alu_op),
        .reg_write(reg_write),
        .mem_write(mem_write),
        .jump(jump)
    );

    initial begin

        // Test #1: ADD
        opcode = 3'b001;
        #1;

        if (alu_op == 2'b00 &&
            reg_write == 1 &&
            mem_write == 0 &&
            jump == 0) begin
            $display("ADD: PASS");
        end
        else begin
            $display("ADD: FAIL");
        end

        // Test #2: SUB
        opcode = 3'b010;
        #1;

        if (alu_op == 2'b01 &&
            reg_write == 1 &&
            mem_write == 0 &&
            jump == 0) begin
            $display("SUB: PASS");
        end
        else begin
            $display("SUB: FAIL");
        end

        // Test #3: AND
        opcode = 3'b011;
        #1;

        if (alu_op == 2'b10 &&
            reg_write == 1 &&
            mem_write == 0 &&
            jump == 0) begin
            $display("AND: PASS");
        end
        else begin
            $display("AND: FAIL");
        end

        // Test #4: OR
        opcode = 3'b100;
        #1;

        if (alu_op == 2'b11 &&
            reg_write == 1 &&
            mem_write == 0 &&
            jump == 0) begin
            $display("OR: PASS");
        end
        else begin
            $display("OR: FAIL");
        end

        // Test #5: LOAD
        opcode = 3'b101;
        #1;

        if (reg_write == 1 &&
            mem_write == 0 &&
            jump == 0) begin
            $display("LOAD: PASS");
        end
        else begin
            $display("LOAD: FAIL");
        end

        // Test #6: STORE
        opcode = 3'b110;
        #1;

        if (reg_write == 0 &&
            mem_write == 1 &&
            jump == 0) begin
            $display("STORE: PASS");
        end
        else begin
            $display("STORE: FAIL");
        end

        // Test #7: JUMP
        opcode = 3'b111;
        #1;

        if (reg_write == 0 &&
            mem_write == 0 &&
            jump == 1) begin
            $display("JUMP: PASS");
        end
        else begin
            $display("JUMP: FAIL");
        end

        // Test #8: HALT
        opcode = 3'b000;
        #1;

        if (reg_write == 0 &&
            mem_write == 0 &&
            jump == 0) begin
            $display("HALT: PASS");
        end
        else begin
            $display("HALT: FAIL");
        end

        $finish;

    end

endmodule

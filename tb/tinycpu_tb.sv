
`timescale 1ns/1ps

module tinycpu_tb;

    logic clk;
    logic reset;

    // Instantiate the CPU
    tinycpu dut (
        .clk(clk),
        .reset(reset)
    );

    // Clock generator: 10 ns period
    initial clk = 0;
    always #5 clk = ~clk;

    // Encode an instruction:
    // [opcode (3)][regA (2)][regB (2)][unused (1)]
    function automatic [7:0] encode(
        input logic [2:0] op,
        input logic [1:0] ra,
        input logic [1:0] rb
    );
        encode = {op, ra, rb, 1'b0};
    endfunction

    initial begin

        // ----------------------------------------
        // Initialize CPU
        // ----------------------------------------
        reset = 1;

        // Initialize instruction memory to HALT
        for (int i = 0; i < 256; i++) begin
            dut.instruction_memory[i] = 8'b00000000;
        end

        // ----------------------------------------
        // Load test program
        // ----------------------------------------

        // Address 0: ADD R0, R1
        dut.instruction_memory[0] = encode(3'b001, 2'd0, 2'd1);

        // Address 1: SUB R0, R1
        dut.instruction_memory[1] = encode(3'b010, 2'd0, 2'd1);

        // Address 2: AND R0, R1
        dut.instruction_memory[2] = encode(3'b011, 2'd0, 2'd1);

        // Address 3: OR R0, R1
        dut.instruction_memory[3] = encode(3'b100, 2'd0, 2'd1);

        // Address 4: STORE R0, [R3]
        dut.instruction_memory[4] = encode(3'b110, 2'd0, 2'd3);

        // Address 5: LOAD R2, [R3]
        dut.instruction_memory[5] = encode(3'b101, 2'd2, 2'd3);

        // Address 6: JUMP R3
        dut.instruction_memory[6] = encode(3'b111, 2'd3, 2'd0);

        // Address 7: HALT (should be skipped)
        dut.instruction_memory[7] = encode(3'b000, 2'd0, 2'd0);

        // Address 20: HALT (jump destination)
        dut.instruction_memory[20] = encode(3'b000, 2'd0, 2'd0);

        // ----------------------------------------
        // Release reset and initialize registers
        // ----------------------------------------

        // Wait for a rising edge to reset the PC
        // and register file.
        @(posedge clk);
        #1;

        // Initialize register values for testing.
        // Direct register access is for simulation only.
        dut.rf_inst.registers[0] = 8'd12;
        dut.rf_inst.registers[1] = 8'd10;
        dut.rf_inst.registers[2] = 8'd0;
        dut.rf_inst.registers[3] = 8'd20;

        // Release reset before the next rising edge
        @(negedge clk);
        reset = 0;

        // ----------------------------------------
        // TEST 1: ADD R0, R1
        // ----------------------------------------
        @(posedge clk);
        #1;

        if (dut.rf_inst.registers[0] == 8'd22)
            $display("ADD: PASS");
        else
            $display("ADD: FAIL (got %d)", dut.rf_inst.registers[0]);

        // ----------------------------------------
        // TEST 2: SUB R0, R1
        // ----------------------------------------
        @(posedge clk);
        #1;

        if (dut.rf_inst.registers[0] == 8'd12)
            $display("SUB: PASS");
        else
            $display("SUB: FAIL (got %d)", dut.rf_inst.registers[0]);

        // ----------------------------------------
        // TEST 3: AND R0, R1
        // 12 & 10 = 8
        // ----------------------------------------
        @(posedge clk);
        #1;

        if (dut.rf_inst.registers[0] == 8'd8)
            $display("AND: PASS");
        else
            $display("AND: FAIL (got %d)", dut.rf_inst.registers[0]);

        // ----------------------------------------
        // TEST 4: OR R0, R1
        // 8 | 10 = 10
        // ----------------------------------------
        @(posedge clk);
        #1;

        if (dut.rf_inst.registers[0] == 8'd10)
            $display("OR: PASS");
        else
            $display("OR: FAIL (got %d)", dut.rf_inst.registers[0]);

        // ----------------------------------------
        // TEST 5: STORE R0, [R3]
        // memory[20] = 10
        // ----------------------------------------
        @(posedge clk);
        #1;

        if (dut.data_mem_inst.memory[20] == 8'd10)
            $display("STORE: PASS");
        else
            $display("STORE: FAIL (got %d)",
                     dut.data_mem_inst.memory[20]);

        // ----------------------------------------
        // TEST 6: LOAD R2, [R3]
        // R2 = memory[20] = 10
        // ----------------------------------------
        @(posedge clk);
        #1;

        if (dut.rf_inst.registers[2] == 8'd10)
            $display("LOAD: PASS");
        else
            $display("LOAD: FAIL (got %d)",
                     dut.rf_inst.registers[2]);

        // ----------------------------------------
        // TEST 7: JUMP R3
        // PC should become 20
        // ----------------------------------------
        @(posedge clk);
        #1;

        if (dut.pc == 8'd20)
            $display("JUMP: PASS");
        else
            $display("JUMP: FAIL (PC = %d)", dut.pc);

        // ----------------------------------------
        // TEST 8: HALT
        // PC should remain 20
        // ----------------------------------------
        @(posedge clk);
        #1;

        if (dut.pc == 8'd20)
            $display("HALT: PASS");
        else
            $display("HALT: FAIL (PC = %d)", dut.pc);

        // Verify PC still holds after another clock
        @(posedge clk);
        #1;

        if (dut.pc == 8'd20)
            $display("HALT HOLD: PASS");
        else
            $display("HALT HOLD: FAIL (PC = %d)", dut.pc);

        $display("CPU integration test complete.");
        $finish;

    end

endmodule

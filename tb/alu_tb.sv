module alu_tb;

    logic [7:0] a;
    logic [7:0] b;
    logic [1:0] alu_op;
    logic [7:0] result;

    //Connects testbench signals to ALU ports
    alu dut (
        .a(a),
        .b(b),
        .alu_op(alu_op),
        .result(result)
    );

    // Initial block runs once the simulation begins
    initial begin

        // Test ADD
        a = 12;
        b = 10;
        alu_op = 2'b00;

        #1;

        if (result == 22)
            $display("ADD: PASS");
        else
            $display("ADD: FAIL, expected 22, got %d", result);


        // Test SUB
        a = 20;
        b = 7;
        alu_op = 2'b01;

        #1;

        if (result == 13)
            $display("SUB: PASS");
        else
            $display("SUB: FAIL, expected 13, got %d", result);


        // Test AND
        a = 12;
        b = 10;
        alu_op = 2'b10;

        #1;

        if (result == 8)
            $display("AND: PASS");
        else
            $display("AND: FAIL, expected 8, got %d", result);


        // Test OR
        a = 14;
        b = 8;
        alu_op = 2'b11;

        #1;

        if (result == 14)
            $display("OR: PASS");
        else
            $display("OR: FAIL, expected 14, got %d", result);

        // Test 8-bit overflow
        a = 255;
        b = 1;
        alu_op = 2'b00;

        #1;

        if (result == 0)
            $display("OVERFLOW: PASS");
        else
            $display("OVERFLOW: FAIL, expected 0, got %d", result);

    end

endmodule
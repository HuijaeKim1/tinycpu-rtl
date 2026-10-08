module decoder_tb;

    logic [7:0] instruction;
    logic [2:0] opcode;
    logic [1:0] regA;
    logic [1:0] regB;

    // Connect the testbench signals to decoder ports
    decoder dut(
        .instruction(instruction),
        .opcode(opcode),
        .regA(regA),
        .regB(regB)
    );

    initial begin

        // Test #1: Opcode extraction
        instruction = 8'b00110010;
        #1;

        if (opcode == 3'b001) begin
            $display("OPCODE: PASS");
        end

        else begin
            $display("OPCODE: FAIL");
        end

        // Test #2: RegA extraction
        if (regA == 2'b10) begin
            $display("REGA: PASS");
        end

        else begin
            $display("REGA: FAIL");
        end

        // Test #3: Reg B extraction
        if (regB == 2'b01) begin
            $display("REGB: PASS");
        end

        else begin
            $display("REGB: FAIL");
        end
    
    $finish;

    end


endmodule
module program_counter_tb;
    logic clk;
    logic jump;
    logic reset;
    logic [7:0] jump_address;
    logic [7:0] pc;

    program_counter dut(
        .clk(clk),
        .jump(jump),
        .reset(reset),
        .jump_address(jump_address),
        .pc(pc)
    );

    // Clock generator
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        reset = 1;
        jump = 0;
        jump_address = 8'd0;

        @(posedge clk);
        #1;

        if (pc == 0) begin
            $display("RESET: PASS");
        end

        else begin
            $display("RESET: FAIL");
        end


        // Test #2: Increment test
        @(negedge clk);

        reset = 0;
        jump = 0;

        @(posedge clk);
        #1;

        if (pc == 1) begin
            $display("INCREMENT: PASS");
        end

        else begin
            $display("INCREMENT: FAIL");
        end


        // Test #3: jump
        @(negedge clk);

        jump = 1;
        jump_address = 8'd100;

        @(posedge clk);
        #1;

        if (pc == 8'd100) begin
            $display("JUMP: PASS");
        end

        else begin
            $display("JUMP: FAIL");
        end

        // Test #4: Priority
        @(negedge clk);

        reset = 1;
        jump = 1;
        jump_address = 8'd100;

        @(posedge clk);
        #1;

        if (pc == 0) begin
            $display("PRIORITY: PASS");
        end

        else begin
            $display("PRIORITY: FAIL");
        end

    $finish;    
        
    end

endmodule
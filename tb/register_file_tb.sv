module register_file_tb;

    logic clk;
    logic reset;
    logic write_en;
    logic [1:0] write_reg;
    logic [7:0] write_data;
    logic [1:0] read_reg1;
    logic [1:0] read_reg2;
    logic [7:0] read_data1;
    logic [7:0] read_data2;


    // Connect testbench signals to register file ports
    register_file dut (
        .clk(clk),
        .reset(reset),
        .write_en(write_en),
        .write_reg(write_reg),
        .write_data(write_data),
        .read_reg1(read_reg1),
        .read_reg2(read_reg2),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );


    // Clock generator
    initial clk = 0;
    always #5 clk = ~clk;


    // Test sequence
    initial begin

        
        // Test 1: Reset
        
        reset      = 1;
        write_en   = 0;
        write_reg  = 2'b00;
        write_data = 8'd0;
        read_reg1  = 2'b00;
        read_reg2  = 2'b00;

        #5;  // First rising edge: reset registers
        #1;  // Move past rising edge

        // Select R0 for reading
        read_reg1 = 2'b00;

        // Check that R0 was reset to 0
        if (read_data1 == 8'd0) begin
            $display("RESET: PASS");
        end
        else begin
            $display("RESET: FAIL");
        end


        
        // Test 2: Write 42 into R2

        reset      = 0;
        write_en   = 1;
        write_reg  = 2'b10;
        write_data = 8'd42;

        @(posedge clk);  // Next rising edge
        #1;  // Move past rising edge

        // Select R2 for reading
        read_reg1 = 2'b10;

        // Check that R2 contains 42
        if (read_data1 == 8'd42) begin
            $display("WRITE R2: PASS");
        end
        else begin
            $display("WRITE R2: FAIL");
        end


        // Test 3: Disable writing

        write_en   = 0;
        write_reg  = 2'b10;
        write_data = 8'd99;

        #9;  // Next rising edge
        #1;  // Move past rising edge

        // R2 should still contain 42 because write_en was 0
        read_reg1 = 2'b10;

        if (read_data1 == 8'd42) begin
            $display("WRITE DISABLE: PASS");
        end
        else begin
            $display("WRITE DISABLE: FAIL");
        end


        // Test 4: Write 25 into R1


        write_en   = 1;
        write_reg  = 2'b01;
        write_data = 8'd25;

        #9;  // Next rising edge
        #1;  // Move past rising edge


      
        // Test 5: Two read ports
       

        // Read R1 and R2 simultaneously
        read_reg1 = 2'b01;
        read_reg2 = 2'b10;

        // R1 should contain 25
        // R2 should still contain 42
        if (read_data1 == 8'd25 && read_data2 == 8'd42) begin
            $display("DUAL READ: PASS");
        end
        else begin
            $display("DUAL READ: FAIL");
        end


        // End simulation
        $finish;

    end

endmodule
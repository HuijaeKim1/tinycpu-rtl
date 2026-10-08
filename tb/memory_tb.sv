
`timescale 1ns/1ps

module memory_tb;

    // Testbench signals
    logic clk;
    logic mem_write;
    logic [7:0] address;
    logic [7:0] write_data;
    logic [7:0] read_data;

    // Instantiate memory module
    memory dut (
        .clk(clk),
        .mem_write(mem_write),
        .address(address),
        .write_data(write_data),
        .read_data(read_data)
    );

    // Clock generator: 10 ns period
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin

        // Initialize inputs
        mem_write = 0;
        address = 0;
        write_data = 0;

        // TEST 1: Write 42 to address 10
        @(negedge clk);
        mem_write = 1;
        address = 8'd10;
        write_data = 8'd42;

        @(posedge clk);
        #1;

        if (read_data == 8'd42)
            $display("WRITE: PASS");
        else
            $display("WRITE: FAIL (got %d)", read_data);


        // TEST 2: Read address 10
        @(negedge clk);
        mem_write = 0;
        address = 8'd10;
        #1;

        if (read_data == 8'd42)
            $display("READ: PASS");
        else
            $display("READ: FAIL (got %d)", read_data);


        // TEST 3: Write disabled
        @(negedge clk);
        mem_write = 0;
        address = 8'd10;
        write_data = 8'd99;

        @(posedge clk);
        #1;

        if (read_data == 8'd42)
            $display("WRITE DISABLE: PASS");
        else
            $display("WRITE DISABLE: FAIL (got %d)", read_data);


        // TEST 4: Write 75 to address 20
        @(negedge clk);
        mem_write = 1;
        address = 8'd20;
        write_data = 8'd75;

        @(posedge clk);
        #1;

        if (read_data == 8'd75)
            $display("MULTIPLE ADDRESSES: PASS");
        else
            $display("MULTIPLE ADDRESSES: FAIL (got %d)", read_data);


        // TEST 5: Verify address 10 was preserved
        @(negedge clk);
        mem_write = 0;
        address = 8'd10;
        #1;

        if (read_data == 8'd42)
            $display("DATA PRESERVATION: PASS");
        else
            $display("DATA PRESERVATION: FAIL (got %d)", read_data);


        $finish;
    end

endmodule

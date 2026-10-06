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


    initial clk = 0;        // Clock generator
    always #5 clk = ~clk;   // Clock flips every 5 simulation time units


    // Test sequence
    initial begin

        // Initial values
        reset      = 1;
        write_en   = 0;
        write_reg  = 2'b00;
        write_data = 8'd0;
        read_reg1  = 2'b00;
        read_reg2  = 2'b00;

        
        #5;

        #1;

        // Select R0 for reading
        read_reg1 = 2'b00;

    end

endmodule
module register_file(
    input logic clk,
    input logic write_en,
    input logic [1:0] write_reg,
    input logic [7:0] write_data,
    input logic [1:0] read_reg1,
    input logic [1:0] read_reg2,

    output logic [7:0] read_data1,
    output logic [7:0] read_data2

);

logic [7:0] registers [0:3];

// sequential write logic
// This block only runs at rising clock edge
always_ff @(posedge_clk) begin  
    if (write_en) begin
        registers[write_reg] <= write_data;
    end
end

// read logic
always_comb begin
    read_data1 = registers[read_reg1];
    read_data2 = registers[read_reg2];
end

endmodule
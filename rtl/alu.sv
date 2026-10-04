module alu (
    input logic [7:0] a,
    input logic [7:0] b,
    input logic [1:0] alu_op, 
    output logic [7:0] result
);

    // behavior of alu

always_comb begin
    case(alu_op)
        2'b00: result = a + b; 

        2'b01: result = a - b;

        2'b10: result = a & b;

        2'b11: result = a | b;
    endcase
end

endmodule
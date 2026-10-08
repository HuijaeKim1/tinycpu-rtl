module decoder (
    input logic [7:0] instruction,
    output logic [2:0] opcode,
    output logic [1:0] regA,
    output logic [1:0] regB

);
    
    assign opcode = instruction[7:5];
    assign regA = instruction[4:3];
    assign regB = instruction[2:1];

endmodule
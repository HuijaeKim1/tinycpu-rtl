module tinycpu(
    input logic clk,
    input logic reset
);

    // Internal signals
    logic [7:0] pc;
    logic jump;
    logic [7:0] jump_address;
    logic pc_enable;

    // Program Counter
    program_counter pc_inst (
    .clk(clk),
    .reset(reset),
    .jump(jump),
    .jump_address(jump_address),
    .pc(pc),
    .pc_enable(pc_enable)
    );

    logic [7:0] instruction_memory [0:255];
    logic [7:0] instruction;

    assign instruction = instruction_memory[pc];    // fetch the instruction at current pc

    // Decoder
    logic [2:0] opcode;
    logic [1:0] regA;
    logic [1:0] regB;

    decoder decoder_inst (
        .instruction(instruction),
        .opcode(opcode),
        .regA(regA),
        .regB(regB)
    );

    // Control unit
    logic [1:0] alu_op;
    logic reg_write;
    logic mem_write;

    control_unit cu_inst(
        .opcode(opcode),
        .alu_op(alu_op),
        .reg_write(reg_write),
        .mem_write(mem_write),
        .jump(jump)
    );

    // Register file
    logic [7:0] read_data1;
    logic [7:0] read_data2;
    logic [7:0] write_data;

    register_file rf_inst(
        .clk(clk),
        .reset(reset),
        .write_en(reg_write),
        .write_reg(regA),
        .write_data(write_data),
        .read_reg1(regA),
        .read_reg2(regB),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // alu
    logic [7:0] alu_result;

    alu alu_inst(
        .a(read_data1),
        .b(read_data2),
        .alu_op(alu_op),
        .result(alu_result)
    );

    // Data memory
     logic [7:0] memory_read_data;

    memory data_mem_inst (
        .clk(clk),
        .mem_write(mem_write),
        .address(read_data2),
        .write_data(read_data1),
        .read_data(memory_read_data)
    );

    // MUX
    assign write_data = (opcode == 3'b101) ? memory_read_data : alu_result;

    // Jump
    assign jump_address = read_data1;   // read_data1 contains the value stored in regA

    // HALT
    assign pc_enable = (opcode != 3'b000);


endmodule
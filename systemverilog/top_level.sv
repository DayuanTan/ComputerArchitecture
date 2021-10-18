`timescale 1ns / 1ps
module top_level(
	input logic clk,
    input logic rst,
    output logic done
);

    wire branch, br_taken;
    wire [7:0]next_pc;
    wire [7:0]cur_pc;
    wire [8:0]inst;
    wire [3:0]r1_addr;
    wire [3:0]r2_addr;
    wire [7:0] write_data;
    wire [7:0] r1_data;
    wire [7:0] r2_data;
    wire read_reg;
    wire RegWrite;
    wire read_r1;
    wire read_r2;
    wire [7:0]sign_extend_r1;
    wire [7:0]sign_extend_r2;
    wire [4:0]ALUop;
    wire zero;
    wire [7:0]alu_result;
    wire MemWrite;
    wire [1:0] Mem2Reg;
    wire PC_input_mux_src;
    wire MemRead;
    wire Demux;
    wire ALU_1st_src;
    wire [7:0]pc_start_addr;
    wire [7:0]data_mem_output;
    wire PC_mux_src;
    wire br_or_jump;
    wire [7:0] lut_data;
    wire update_op1;
    assign pc_start_addr=9'b0;

    next_PC_logic PC(
    .rst(rst),
    .clk(clk),
    .cur_pc(cur_pc),
    .start_addr(pc_start_addr),
    .taken(PC_mux_src),
    .target(PC_input_mux_src ? r2_data : sign_extend_r2),
    .done(done),

    .next_pc(next_pc)
    );
    assign cur_pc=next_pc;

    // Inst_ROM IR(
    // .cur_pc(cur_pc),

    // .inst(inst)
    // );

//    dist_mem_gen_0 Inst_Mem(
//        .a(cur_pc),
//        .d(9'b0),
//        .clk(clk),
//        .we(1'b0),
        
//        .spo(inst)
//    );

    InstROM IR(
    .InstAddress(cur_pc),
    .InstOut(inst)
    );
    
    assign done=inst==9'b000000000;

    control_unit cu(
    .opcode(inst[8:4]),

    .PC_input_mux_src(PC_input_mux_src),
    .Demux(Demux),
    .RegWrite(RegWrite),
    .ALU_1st_src(ALU_1st_src),
    .ALUop(ALUop),
    .MemWrite(MemWrite),
    .MemRead(MemRead),
    .Mem2Reg(Mem2Reg),
    .br_or_jump(br_or_jump),
    .OPTR_inst(update_op1)
    );

    demux dmux(
    .data(inst[3:0]),
    .Demux(Demux),

    .r1_addr(r1_addr),
    .r2_addr(r2_addr)
    );

    reg_file rf(
    .clk(clk),
    .rst(rst),
    .r1_addr(r1_addr),
    .r2_addr(r2_addr),
    .write_reg_addr(r2_addr),
    .write_data(write_data),
    .we(RegWrite),

    .r1_data(r1_data),
    .r2_data(r2_data)
    );
    
    sign_extend se1(
    .data(r1_addr),
    .extended_data(sign_extend_r1)
    );
    
    sign_extend se2(
    .data(r2_addr),
    .extended_data(sign_extend_r2)
    );
    
    reg [7:0] alu_op1;
    always @(posedge clk) begin
        if (update_op1)
            alu_op1 <= ALU_1st_src ? r1_data : sign_extend_r1;
    end

    ALU alu(
    .op1(alu_op1),
    .op2(r2_data),
    .alu_option(ALUop),

    .zero(zero),
    .result(alu_result)
    );
    
    assign PC_mux_src=(zero & br_or_jump);

    DataMem DM(
    .Clk(clk),
    .Reset(rst),
    .WriteEn(MemWrite),
    .DataAddress(alu_result),   // 8-bit-wide pointer to 256-deep memory
    .DataIn(r2_data),        // 8-bit-wide data path, also
    .DataOut(data_mem_output));
    
    LUT lut(
    .index(alu_result),
    .target(lut_data)
    );
    
    assign write_data = (Mem2Reg==0) ? alu_result : (Mem2Reg==1 ? data_mem_output : (Mem2Reg==2 ? lut_data : 8'b0));

endmodule
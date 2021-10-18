`timescale 1ns / 1ps
module control_unit(
    input [4:0]opcode,

    output logic PC_input_mux_src,
    output logic Demux,
    output logic RegWrite,
    output logic ALU_1st_src,
    output reg [4:0] ALUop,
    output logic MemWrite,
    output logic MemRead,
    output reg [1:0] Mem2Reg,
    output logic br_or_jump,
    output logic OPTR_inst
);

    always @(*) begin
        // BNZ,BZ,J
        if (opcode==5'b10000 | opcode==5'b10001 | opcode==5'b10100) 
            PC_input_mux_src<=1; 
        else PC_input_mux_src<=0; 
    end

    always @(*) begin
        // OPTR, OPTR_imm
        if (opcode==5'b00001 | opcode==5'b11000) Demux<=1;
        else Demux<=0;
    end

    always @(*) begin
        // OPTR, OPTR_imm, STORE, BNZ, BNZI, BZ, BZI, BLEZI, J, JL
        if (opcode==5'b00001 | opcode==5'b11000 | opcode==5'b01011 | opcode==5'b10000 | opcode==5'b10110 | opcode==5'b10001 | opcode==5'b10111 | opcode==5'b10010 | opcode==5'b10100 | opcode==5'b10101)
            RegWrite<=0;
        else RegWrite<=1;
    end

    always @(*) begin
        // OPTR_imm
        if (opcode==5'b11000)
            ALU_1st_src<=0;
        // OPTR
        else if (opcode==5'b00001)
            ALU_1st_src<=1;
        else ALU_1st_src<=ALU_1st_src;
    end

    always @(*) begin
        // STOREB
        if (opcode==5'b01011)
            MemWrite<=1;
        else MemWrite<=0;
    end

    always @(*) begin
        // LOADB
        if (opcode==5'b01010)
            MemRead<=1;
        else MemRead<=0;
    end

    always @(*) begin
        // LOADB
        if (opcode==5'b01010)
            Mem2Reg<=1;
        else if (opcode==5'b01100)
            Mem2Reg<=2;
        else Mem2Reg<=0;
    end

    always @(*) begin
        case (opcode)
            // ADD, ADDI
            5'b00011:ALUop<=2'd0;
            5'b01110:ALUop<=2'd0;
            // SUB, SUBI
            5'b00100:ALUop<=2'd1;
            5'b01111:ALUop<=2'd1;
            // DIV
            5'b00101:ALUop<=2'd2;
            // AND
            5'b00110:ALUop<=2'd3;
            // OR
            5'b00111:ALUop<=5'd4;
            // XOR
            5'b01000:ALUop<=5'd5;
            // XORBIT
            5'b01001:ALUop<=5'd6;
            // LOADB, STOREB, LUT, MOV, MOVI
            5'b01010:ALUop<=5'd7;
            5'b01011:ALUop<=5'd7;
            5'b01100:ALUop<=5'd7;
            5'b00010:ALUop<=5'd7;
            5'b01101:ALUop<=5'd7;
            // BNZ, BNZI
            5'b10000:ALUop<=5'd8;
            5'b10110:ALUop<=5'd8;
            // BZ, BZI
            5'b10001:ALUop<=5'd9;
            5'b10111:ALUop<=5'd9;
            // BLEZI
            5'b10010:ALUop<=5'd10;
            // SL
            5'b10011:ALUop<=5'd11;
            // J, JL
            5'b10100:ALUop<=5'd12;
            5'b10101:ALUop<=5'd12;
            default:ALUop<=5'd13;
        endcase
    end
    
    always @(*)begin
        // BNZ, BNZI, BZ, BZI, BLEZI, J, JI
        if (opcode==5'b10000 | opcode==5'b10110 | opcode==5'b10001 | opcode==5'b10111 | opcode==5'b10010 | opcode==5'b10100 | opcode==5'b10101)
            br_or_jump=1;
        else br_or_jump=0;
    end
    
    always @(*)begin
        if (opcode==5'b11000 | opcode==5'b00001) OPTR_inst=1;
        else OPTR_inst=0;
    end

endmodule
`timescale 1ns / 1ps
module ALU (
    input logic rst,
    input [7:0] op1,
    input [7:0] op2,
    input [4:0] alu_option,

    output logic zero,
    output reg [7:0] result
);

    always @(*) begin
        if(rst) result<=8'b11111111;
        else begin
            case (alu_option)
                0:result<=op1+op2;
                1:result<=op2-op1;
                2:result<=op1/op2;
                3:result<=op1&op2;
                4:result<=op1|op2;
                5:result<=op1^op2;
                6:result<=^op1;
                7:result<=op1;
                8:result<=op1!=0 ? 0:7'b1111111;
                9:result<=op1==0 ? 0:7'b1111111;
                10:result<=$signed(op1)<=0 ? 0:7'b1111111;
                11:result<=op2<<op1;
                12:result<=0;
                default:result<=7'b1111111;
            endcase
        end
    end
    
    assign zero=result==0 ? 1 : 0;

//    always @(*) begin
//        if(rst) zero<=0;
//        else begin
//            case (alu_option)
//                8:zero <= op1!=0 ? 1 : 0;
//                9:zero <= op1==0 ? 1 : 0;
//                10:zero <= (op1<=0) ? 1 : 0;
//                12:zero <= 1;
//                default: zero <= 0;
//            endcase
//        end
//    end
    
endmodule
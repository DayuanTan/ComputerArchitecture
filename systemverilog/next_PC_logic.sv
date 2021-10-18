`timescale 1ns / 1ps
module next_PC_logic(
    input logic rst,
    input logic clk,
    input [7:0]cur_pc,
    input [7:0]start_addr,
    input logic taken,
    input [7:0]target,
    input logic done,

    output reg [7:0]next_pc
);

    always @(posedge clk or posedge rst) begin
        if (rst) next_pc<=start_addr;
        else begin
            if (done) next_pc<=cur_pc;
            else begin
                if(taken) next_pc<=cur_pc+target;
                else next_pc<=cur_pc+1;
            end
        end
    end

endmodule
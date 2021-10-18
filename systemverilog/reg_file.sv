`timescale 1ns / 1ps
module reg_file (
    input logic clk,
    input logic rst,
    input [3:0] r1_addr,
    input [3:0] r2_addr,
    input [3:0] write_reg_addr,
    input [7:0] write_data,
    input logic we,

    output [7:0] r1_data,
    output [7:0] r2_data
);

    reg [7:0] RF [16];

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            RF[0]=8'b0;RF[1]=8'b0;RF[2]=8'b0;RF[3]=8'b0;
            RF[4]=8'b0;RF[5]=8'b0;RF[6]=8'b0;RF[7]=8'b0;
            RF[8]=8'b0;RF[9]=8'b0;RF[10]=8'b0;RF[11]=8'b0;
            RF[12]=8'b0;RF[13]=8'b0;RF[14]=8'b0;RF[15]=8'b0;
        end 
        else begin
        
           if (we) RF[write_reg_addr] <= write_data;
            
        end
    end

    assign r1_data = RF[r1_addr];
            
    assign r2_data = RF[r2_addr];

    
endmodule
`timescale 1ns / 1ps
module  demux (
    input [3:0] data,
    input logic Demux,

    output [3:0] r1_addr,
    output [3:0] r2_addr
);


    assign r1_addr = Demux ? data : 4'b0;
    assign r2_addr = Demux ? 4'b0 : data;
    
endmodule
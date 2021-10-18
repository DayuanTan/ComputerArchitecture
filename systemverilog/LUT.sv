`timescale 1ns / 1ps
module LUT(
	input logic[7:0] index,
	output logic[7:0] target
);

	logic[3:0] address;
	assign address = index[3:0];
	always_comb begin
		case(address)
			4'd0: begin 
				target = 8'h60;
			end
			
			4'd1: begin 
				target = 8'h48;
			end
			
			4'd2: begin 
				target = 8'h78;
			end
			
			4'd3: begin 
				target = 8'h72;
			end
			
			4'd4: begin 
				target = 8'h6A;
			end
			
			4'd5: begin 
				target = 8'h69; 
			end
			
			4'd6: begin 
				target = 8'h5C;
			end
			
			4'd7: begin 
				target = 8'h7E;
			end
			4'd8: begin
			    target=8'h7B;
			end
			default: begin
				target = 8'h0;
			end
		endcase
	end
endmodule: LUT
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:10:06 10/20/2019 
// Design Name: 
// Module Name:    alu 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module alu(
    input [31:0] in1,
    input [31:0] in2,
    input [3:0] alucon,
    output reg [31:0] out,
    output zero
    );
	assign zero = (out == 0);
	always @(*) begin
		case (alucon)
			0 : out <= in1 + in2; //ADD
			8 : out <= in1 - in2; //SUB
			1 : out <= in1 << in2[4:0]; //SLL
			2 : out <= {{31{1'b0}}, ($signed(in1) < $signed(in2))}; //SLT
			3 : out <= {{31{1'b0}}, (in1 < in2)}; //SLTU
			4 : out <= in1 ^ in2; //XOR
			5 : out <= in1 >> in2[4:0]; //SRL
			13 : out <= $signed(in1) >>> in2[4:0]; //SRA
			6 : out <= in1 | in2; //OR
			7 : out <= in1 & in2; //AND
			default: out <= 32'h00000000;
		endcase
		end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:43:13 10/20/2019 
// Design Name: 
// Module Name:    alucontrol 
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
module alucontrol(
    input [1:0] aluop,
    input [6:0] funct7,
    input [2:0] funct3,
    output reg [3:0] alucon
    );

always @(*)
begin
	case (aluop)
		2'b10: begin //ALU
				alucon[0]<=funct3[0];
				 alucon[1]<=funct3[1];
				 alucon[2]<=funct3[2];
				 alucon[3]<=funct7[5];end
		2'b00: alucon<=4'b0000; //LW, SW, JALR 
		2'b01: begin // branch
		case(funct3)
		3'b000: alucon<=4'b1000;
		3'b001: alucon<=4'b1000;
		3'b100: alucon<=4'b0010;
		3'b101: alucon<=4'b0010;
		3'b110: alucon<=4'b0011;
		3'b111: alucon<=4'b0011;
		endcase
		end
		default: alucon <= 10;
	endcase
end
endmodule

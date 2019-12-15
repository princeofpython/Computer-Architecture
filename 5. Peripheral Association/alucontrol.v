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
    output [3:0] alucon
    );


assign alucon = (aluop==2'b10) ? {funct7[5], funct3}: //ALU
					 (aluop==2'b00) ?  4'b0000: //LW, SW, JALR 
					 (aluop==2'b01 && funct3==3'b000) ? 4'b1000:  //BRANCH
					 (aluop==2'b01 && funct3==3'b001) ? 4'b1000:
					 (aluop==2'b01 && funct3==3'b100) ? 4'b0010:
					 (aluop==2'b01 && funct3==3'b101) ? 4'b0010:
					 (aluop==2'b01 && funct3==3'b110) ? 4'b0011:
					 (aluop==2'b01 && funct3==3'b111) ? 4'b0011: 10; //default
	
endmodule

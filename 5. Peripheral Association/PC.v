`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:57:42 10/23/2019 
// Design Name: 
// Module Name:    PC 
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
module PC(
    input [31:0] PC,
    input [31:0] immgen,
    input [2:0] branch,
    input zero,
	 input [31:0] aluoutdata,
	 output [31:0] PC_plus4,
    output [31:0] PC_next
    );
	 


assign PC_plus4 = PC + 32'd4;

wire [31:0] PC_branch;
assign PC_branch = PC + immgen;

assign PC_next = (branch == 3'b001 && (~zero) ) ? PC_branch : //BNE, BLT, BLTU
                 (branch == 3'b001 && zero ) ? PC_plus4 :
					  (branch == 3'b010 && zero ) ? PC_branch : // BEQ, BGE, BGEU
                 (branch == 3'b010 && (~zero) ) ? PC_plus4 : 
					  (branch == 3'b011) ?  PC_branch :  // JAL
					  (branch == 3'b100) ? (aluoutdata & 32'hFFFFFFFE) :PC_plus4; //JALR
endmodule

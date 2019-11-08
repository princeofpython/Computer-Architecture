`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:11:57 11/03/2019 
// Design Name: 
// Module Name:    EX_MEM 
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
module EX_MEM(
	 input clk,
    input memtoreg_in,
    input regwrite_in,
    input [3:0] memwrite_in,
    //input [31:0] PC_branch_in,
    input [31:0] ALUout_in,
    input [31:0] rv2_in,
    output reg [31:0] rv2_out,
    output reg [31:0] ALUout_out,
    //output reg[31:0] PC_branch_out,
    output reg [3:0] memwrite_out,
    output reg regwrite_out,
    output reg memtoreg_out,
    input [31:0] immgen_in,
    output reg [31:0] immgen_out,
    input [1:0] regin_in,
    output reg [1:0] regin_out,
    input [31:0] PC_plus4_in,
    output reg [31:0] PC_plus4_out,
	 input [31:0] idata_in,
	 output reg [31:0] idata_out
    );
	 
	 initial begin
	regin_out = 0;
	memtoreg_out = 0;
	memwrite_out = 0;
	PC_plus4_out = 0;
	ALUout_out = 0;
	rv2_out = 0;
	immgen_out = 0;
	regwrite_out = 0;
	idata_out = 0;
	end

always @(posedge clk)begin
	regin_out <= regin_in;
	memtoreg_out <= memtoreg_in;
	memwrite_out <= memwrite_in;
	//PC_branch_out <= PC_branch_in;
	PC_plus4_out <= PC_plus4_in;
	ALUout_out <= ALUout_in;
	rv2_out <= rv2_in;
	immgen_out <= immgen_in;
	regwrite_out <= regwrite_in;
	idata_out <= idata_in;
	
	end
endmodule

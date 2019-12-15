`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:34:53 11/02/2019 
// Design Name: 
// Module Name:    ID_EX 
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
module ID_EX(
	 input clk,
    input [1:0] regin_in,
    input [2:0] branch_in,
    input memtoreg_in,
    input [1:0] ALUop_in,
    input [1:0] ALUsrc_in,
    input regwrite_in,
    input [3:0] memwrite_in,
    input [31:0] rv1_in,
    input [31:0] rv2_in,
	 input opinvalid_in,
	 input IACK_in,
	 output reg IACK_out,
	 output reg opinvalid_out,
    output reg[31:0] rv1_out,
    output reg[31:0] rv2_out,
    input [31:0] immgen_in,
	 output reg[31:0] immgen_out,
    output reg[1:0] regin_out,
    output reg[2:0] branch_out,
    output reg memtoreg_out,
    output reg[1:0] ALUop_out,
    output reg[1:0] ALUsrc_out,
    output reg regwrite_out,
    output reg[3:0] memwrite_out,
	 //input [2:0] imm_in,
	 //output [2:0] imm_out,
	 input [31:0] PC_in,
	 output reg[31:0] PC_out,
	 input [31:0] idata_in,
	 output reg[31:0] idata_out
    );
	 initial begin
	 regin_out =0;
	branch_out = 0;
	memtoreg_out = 0;
	ALUop_out = 0;
	ALUsrc_out = 0;
	regwrite_out = 0;
	memwrite_out = 0;
	rv1_out = 0;
	rv2_out = 0;
	immgen_out = 0;
	PC_out = 0;
	idata_out = 0;
	opinvalid_out = 0;
	IACK_out = 0;
	 end
always @(posedge clk) begin
	regin_out <= regin_in;
	branch_out <= branch_in;
	memtoreg_out <= memtoreg_in;
	ALUop_out <= ALUop_in;
	ALUsrc_out <= ALUsrc_in;
	regwrite_out <= regwrite_in;
	memwrite_out <= memwrite_in;
	rv1_out <= rv1_in;
	rv2_out <= rv2_in;
	immgen_out <= immgen_in;
	PC_out <= PC_in;
	idata_out <= idata_in;
	opinvalid_out <= opinvalid_in;
	IACK_out <= IACK_in;
	
end
endmodule

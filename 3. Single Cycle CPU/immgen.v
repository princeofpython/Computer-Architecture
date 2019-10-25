`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:30:42 10/24/2019 
// Design Name: 
// Module Name:    immgen 
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
module immgen(
    input [2:0] imm,
    input [31:0] idata,
    output [31:0] immgen
    );
	
	assign immgen = (imm == 3'b000) ? {{20{idata[31]}},idata[31:20]}: //LW JALR ALUI
						 (imm == 3'b001) ? {{20{idata[31]}},idata[31:25],idata[11:7]}: //SW
						 (imm == 3'b010) ? {idata[31:12],{12{1'b0}}}: //LUI AUIPC
						 (imm == 3'b011) ? {{12{idata[31]}}, idata[19:12], idata[20], idata[30:21], 1'b0}: //JAL
						 (imm == 3'b100) ? {{20{idata[31]}},idata[7],idata[30:25],idata[11:8],1'b0}: //BEQ
						 (imm == 3'b101) ? {{20{1'b0}},idata[31:20]} : {{20{idata[31]}},idata[31:20]}; //LU
						 

endmodule

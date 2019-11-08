`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:34:20 11/03/2019 
// Design Name: 
// Module Name:    MEM_WB 
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
module MEM_WB(
	 input clk,
    input memtoreg_in,
    input regwrite_in,
    input [31:0] ALUout_in,
    input [31:0] drdata_in,
    input [31:0] immgen_in,
    input [31:0] PC_plus4_in,
    input [1:0] regin_in,
	 input [31:0] idata_in,
	 input [31:0] daddr_in,
	 output reg [31:0] daddr_out,
	 output reg [31:0] idata_out,
    output reg [1:0] regin_out,
    output reg [31:0] PC_plus4_out,
    output reg [31:0] immgen_out,
    output reg [31:0] ALUout_out,
    output reg [31:0] drdata_out,
    output reg memtoreg_out,
    output reg regwrite_out
    );
	 
	 initial begin
	 ALUout_out = 0;
	 memtoreg_out = 0;
	 regwrite_out = 0;
	 regin_out = 0;
	 immgen_out = 0;
	 drdata_out = 0;
	 PC_plus4_out = 0;
	 idata_out = 0;
	 daddr_out = 0; 
	 end
	 
always@(posedge clk)begin
	 ALUout_out <= ALUout_in;
	 memtoreg_out <= memtoreg_in;
	 regwrite_out <= regwrite_in;
	 regin_out <= regin_in;
	 immgen_out <= immgen_in;
	 drdata_out <= drdata_in;
	 PC_plus4_out <= PC_plus4_in;
	 idata_out <= idata_in;
	 daddr_out <= daddr_in; 
end
endmodule

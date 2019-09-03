`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:15:58 09/04/2019 
// Design Name: 
// Module Name:    dmem 
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
module dmem(
    input we, clk,
	 input [31:0] daddr,
    input [31:0] indata,
    output reg [31:0] outdata
	 
    );
reg [7:0] DMEM[2**12-1:0];
always @ (posedge clk)begin
	if (we) begin
	DMEM[daddr[11:0]] <= indata[7:0];
	end
	outdata[7:0] <= DMEM[daddr[11:0]];
	end
endmodule

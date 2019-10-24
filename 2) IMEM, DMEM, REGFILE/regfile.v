`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:51:59 09/04/2019 
// Design Name: 
// Module Name:    regfile 
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
module regfile(
    input [4:0] rs1,
    input [4:0] rs2,
    input [4:0] rd,
    input [31:0] indata,
    input we,
    input clk,
    output reg [31:0] rv1,
    output reg [31:0] rv2
    );

reg [31:0] RF[31:0];
initial begin
	$readmemh("RegFile.mem",RF);
	end
always @ (posedge clk) begin
if(we)
	begin
		RF[rd] <= indata;
	end 
	rv1 <= (rs1 !=0) ? RF[rs1] : 0;
	rv2 <= (rs2 !=0) ? RF[rs2] : 0;
end
endmodule

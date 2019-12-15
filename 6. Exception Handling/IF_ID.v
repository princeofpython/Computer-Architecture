`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:15:17 11/02/2019 
// Design Name: 
// Module Name:    IF_ID 
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
module IF_ID(
	 input clk,
	 input staller,
    input [31:0] PC_in,
    input [31:0] idata_in,
	 input IACK_in,
	 output reg IACK_out,
    output reg [31:0] PC_out,
    output reg [31:0] idata_out
    );
	 initial begin
PC_out = 0;
idata_out = 0;
IACK_out = 0;
end

always @(posedge clk) begin
if(~staller)begin
PC_out <= PC_in;
idata_out <= idata_in;
IACK_out <= IACK_in;
end
end
endmodule

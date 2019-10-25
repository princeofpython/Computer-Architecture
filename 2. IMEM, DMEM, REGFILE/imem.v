`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:18:15 09/04/2019 
// Design Name: 
// Module Name:    imem 
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
module imem(
	 input clk,
    input [31:0] iaddr,
    output reg [31:0] idata
    );
reg [31:0] IMEM[1023:0];
initial begin
	$readmemh("IMEM.mem",IMEM);
end
	always@(posedge clk)
	begin
		idata[31:0] <= IMEM[iaddr[9:0]];
	end

endmodule

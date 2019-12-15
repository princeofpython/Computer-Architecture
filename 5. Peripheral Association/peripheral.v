`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:06:46 11/11/2019 
// Design Name: 
// Module Name:    peripheral 
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
module peripheral(
    input clk,
    input CE,
    input PWE,
    input [1:0] addr,
    input [31:0] wdata,
    output [31:0] rdata
    );

reg [31:0] pmem[0:3];

integer i;

initial begin
for(i=0 ; i<4 ; i=i+1)
pmem[i]=0;
end

assign rdata = pmem[addr];

integer j;

always@(posedge clk) begin
if (CE && PWE) begin
	pmem[addr] <= wdata;
	if (addr==1) begin
		pmem[2] <= pmem[2]+wdata;
		pmem[3] <= pmem[3]+1; 
	end
end
if (addr == 0 && PWE && CE)begin
	for(j=0 ; j<4 ; j=j+1)	
		pmem[j]<=0;
end
end

endmodule

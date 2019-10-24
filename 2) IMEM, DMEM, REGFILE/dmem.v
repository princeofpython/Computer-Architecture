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
    input  clk,
	 input [3:0] we,
	 input [31:0] daddr,
    input [31:0] indata,
    output reg [31:0] outdata
	 
    );
reg [7:0] DMEM_1[1023:0];
initial begin
$readmemh("DMEM_1.mem",DMEM_1);
end
always @ (posedge clk)begin
	if (we[0]) begin
	DMEM_1[daddr[11:2]] <= indata[7:0];
	end
	outdata[7:0] <= DMEM_1[daddr[11:2]];
	end
	
reg [7:0] DMEM_2[1023:0];
initial begin
$readmemh("DMEM_2.mem",DMEM_2);
end
always @ (posedge clk)begin
	if (we[1]) begin
	DMEM_2[daddr[11:2]] <= indata[15:8];
	end
	outdata[15:8] <= DMEM_2[daddr[11:2]];
	end
	
reg [7:0] DMEM_3[1023:0];
initial begin
$readmemh("DMEM_3.mem",DMEM_3);
end
always @ (posedge clk)begin
	if (we[2]) begin
	DMEM_3[daddr[11:2]] <= indata[23:16];
	end
	outdata[23:16] <= DMEM_3[daddr[11:2]];
	end
	
reg [7:0] DMEM_4[1023:0];
initial begin
$readmemh("DMEM_4.mem",DMEM_4);
end
always @ (posedge clk)begin
	if (we[3]) begin
	DMEM_4[daddr[11:2]] <= indata[31:24];
	end
	outdata[31:24] <= DMEM_4[daddr[11:2]];
	end
endmodule

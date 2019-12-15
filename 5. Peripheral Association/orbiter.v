`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:42:51 11/27/2019 
// Design Name: 
// Module Name:    orbiter 
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
module orbiter(
    input [31:0] drdata,
    input [31:0] prdata,
    input [31:0] daddr,
    output CE,
    output PWE,
	 output [1:0] addr,
    input [3:0] we,
    output [31:0] rdata
    );
	
	assign CE = daddr[9];
	assign PWE = (we!= 4'b0000);
	assign addr = daddr[3:2];

	assign rdata = CE ? prdata : drdata;
endmodule

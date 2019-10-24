`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:08:57 10/25/2019 
// Design Name: 
// Module Name:    top_imem 
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
module top_imem(
    input clk
    );
	 wire manclk;
	wire [31:0] iaddr;
	 wire [31:0] idata;
	 
	  wire [35:0] VIO_CONTROL;

imem instanceA(
		.clk(manclk),
		.iaddr(iaddr),
		.idata(idata)
		 ) ;

icon0 instanceB (
    .CONTROL0(VIO_CONTROL) // INOUT BUS [35:0]
);

vio0 instanceC (
    .CONTROL(VIO_CONTROL), // INOUT BUS [35:0]
    .CLK(clk), // IN
    .ASYNC_OUT({iaddr,manclk}), // OUT BUS [32:0]
    .ASYNC_IN({idata}) // IN BUS [31:0]
);
endmodule

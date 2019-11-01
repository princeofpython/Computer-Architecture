`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:49:08 09/20/2019 
// Design Name: 
// Module Name:    top 
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

`timescale 1ns / 1ps
//Implementation Testbench for A0

module top(
    input clk
    ); //Only input from the outside is clock
	 
	 wire [3:0] we;
	 wire [31:0] daddr;
    wire [31:0] indata;
    wire [31:0] outdata;
	 wire manclk;
	 //Input-output ports controlled by VIO and ILA
	 
	 wire [35:0] VIO_CONTROL;
	 //Control wires used by ICON to control VIO and ILA
	 
dmem instanceA (
		.we(we), 
		.clk(manclk), 
		.daddr(daddr), 
		.indata(indata), 
		.outdata(outdata)
	);
//Calling the multiplier instance


//Calls for ICON, VIO and ILA blocks
icon0 instanceB (
    .CONTROL0(VIO_CONTROL) // INOUT BUS [35:0]
);

vio0 instanceC (
    .CONTROL(VIO_CONTROL), // INOUT BUS [35:0]
    .CLK(clk), // IN
    .ASYNC_OUT({we, daddr, indata, manclk}), // OUT BUS [68:0]
    .ASYNC_IN(outdata) // IN BUS [31:0]
);


endmodule
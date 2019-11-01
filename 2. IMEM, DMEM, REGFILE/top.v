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
	

	wire [31:0] iaddr;
	wire [31:0] idata;
	 

imem instanceB(
		.clk(manclk),
		.iaddr(iaddr),
		.idata(idata)
		 ) ;
		 
wire [31:0] regindata;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [4:0] rd;
    wire [31:0] rv1;
    wire [31:0] rv2;
    wire regwe;

	 
	 
regfile instanceC(
		.indata(regindata),
		.rs1(rs1),
		.rs2(rs2),
		.rd(rd),
		.rv1(rv1),
		.rv2(rv2),
		.we(regwe),
		.clk(manclk)
		 ) ;
//Calling the multiplier instance


//Calls for ICON, VIO and ILA blocks
icon0 instanceD (
    .CONTROL0(VIO_CONTROL) // INOUT BUS [35:0]
);

vio0 instanceE (
    .CONTROL(VIO_CONTROL), // INOUT BUS [35:0] // IN
    .ASYNC_OUT({regindata,rs1,rs2,rd,regwe,iaddr, we, daddr, indata, manclk}), // OUT BUS [148:0]
    .ASYNC_IN({rv1,rv2,idata,outdata}) // IN BUS [127:0]
);


endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    04:12:30 10/25/2019 
// Design Name: 
// Module Name:    top_regfile 
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
module top_regfile(
    input clk
    );
	 
	 wire [31:0] indata;
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [4:0] rd;
    wire [31:0] rv1;
    wire [31:0] rv2;
    wire we;
	 wire manclk;
	 
	 wire [35:0] VIO_CONTROL;
	 
	 
regfile instanceA(
		.indata(indata),
		.rs1(rs1),
		.rs2(rs2),
		.rd(rd),
		.rv1(rv1),
		.rv2(rv2),
		.we(we),
		.clk(manclk)
		 ) ;

icon0 instanceC (
    .CONTROL0(VIO_CONTROL) // INOUT BUS [35:0]
);

vio0 instanceD (
    .CONTROL(VIO_CONTROL), // INOUT BUS [35:0]
    .ASYNC_OUT({indata,rs1,rs2,rd,we,manclk}), // OUT BUS [48:0]
    .ASYNC_IN({rv1,rv2}) // IN BUS [63:0]
);
endmodule

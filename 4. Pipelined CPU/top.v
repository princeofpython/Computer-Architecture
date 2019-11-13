`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:23:17 10/30/2019 
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

module top(
    input clk
    );
	 wire manclk, reset;
    wire [31:0] iaddr, idata;
    wire [31:0] daddr, drdata, dwdata;
    wire [3:0] we;
    wire [31:0] x31, PC;
	 wire [35:0] VIO_CONTROL;
	 
	 CPU dut (
        .clk(manclk),
        .reset(reset),
        .iaddr(iaddr),
        .idata(idata),
        .daddr(daddr),
        .drdata(drdata),
        .dwdata(dwdata),
        .we(we),
        .x31(x31),
        .PC(PC)
    );
	 
	 dmem dmem(
		.clk(manclk),
		.daddr(daddr),
		.dwdata(dwdata),
		.drdata(drdata),
		.we(we)
		);
	 
	 imem imem(
		.iaddr(iaddr), 
		.idata(idata)
	);
	
icon0 instanceB (
    .CONTROL0(VIO_CONTROL) // INOUT BUS [35:0]
);

vio0 instanceC (
    .CONTROL(VIO_CONTROL), // INOUT BUS [35:0]
    .ASYNC_OUT({reset, manclk}), // OUT BUS [65:0]
    .ASYNC_IN({PC,x31,we,dwdata,daddr,iaddr}) // IN BUS [163:0]
);
endmodule

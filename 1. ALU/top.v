`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    09:51:42 08/20/2019
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
module top(
    input clk
    );

	 wire [31:0] in1,in2,instr;
	 wire [5:0] op;
	 wire [31:0] out;
	 //Input-output ports controlled by VIO and ILA

	 wire [35:0] ILA_CONTROL, VIO_CONTROL;
	 //Control wires used by ICON to control VIO and ILA

ALU32 instanceA(
		.in1(in1),
		.in2(in2),
		.op(op),
		.out(out)
		 ) ;

DummyDecoder instanceB (
		// Feed the instruction as input
		.instr(instr),
		// Create and return opcode from instruction
		.op(op)

	);


//Calls for ICON, VIO and ILA blocks
icon0 instanceC (
    .CONTROL0(ILA_CONTROL), // INOUT BUS [35:0]
    .CONTROL1(VIO_CONTROL) // INOUT BUS [35:0]
);

vio1 instanceD (
    .CONTROL(VIO_CONTROL), // INOUT BUS [35:0]

    .ASYNC_OUT({in1,in2,instr}), // OUT BUS [16:0]
    .ASYNC_IN({out}) // IN BUS [16:0]
);

ila0 instanceE (
    .CONTROL(ILA_CONTROL), // INOUT BUS [35:0]
	  .CLK(clk),
    .TRIG0(out) // IN BUS [15:0]
);


endmodule

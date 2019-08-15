// Description     : ALU test bench
// Author          : Nitin Chandrachoodan <nitin@ee.iitm.ac.in>

// Problem statement:
// Write verilog code for an ALU
//   Must be synthesizable
//   Purely combinational
// Inputs:
//   - instr[31:0] -- the actual instruction that would be read by the processor
//   - in1[31:0]   -- either a reg value or immediate: here you assume it has 
//   - in2[31:0]      been decoded
//   - op[5:0]     -- this is an "op" code - you need to generate a suitable opcode based on the 
//                    instruction.  Note: this is NOT part of the ALU, so write a separate
//                    DummyDecoder module just to generate this.  Later you will implement
//                    the actual decoder to do it.
// Outputs:
//   - out[31:0]   -- computed output based on instr and in1, in2

`timescale 1ns/1ns
`include "parameters.v"

module alu_tb () ;
	// Instruction will be read from file
	reg [`width-1:0] instrmem[0:`NUMTESTS-1];
	// Input register values and expected output, one per test
	reg [`width-1:0] inreg1[0:`NUMTESTS-1];
	reg [`width-1:0] inreg2[0:`NUMTESTS-1];
	reg [`width-1:0] expreg[0:`NUMTESTS-1];

	// Opcode to be sent to ALU
	wire [`OPWIDTH-1:0] op;
	
	// ALU is a combinational block, so clk, reset not required: used only in testbench
	reg 		    clk, reset;
	reg [`width-1:0] instr;
	reg [`width-1:0] in1, in2;
	reg [`width-1:0] exp;
	wire [`width-1:0] out;
	integer i;

	// Bookkeeping
	integer total, err;

	// Device under test - always use named mapping of signals to ports
	ALU32 dut(
		.in1(in1),
		.in2(in2),
		.op(op),
		.out(out)
	);

	// Dummy decoder - note that this is not a complete decoder: you need to write
	// a simple decoder for testing the ALU, but the actual RISC-V decoder will be more complex.
	// It takes in the full 32-bit instruction and returns an "op-code"
	// Since there are 19 unique ALU ops, we are going to use a 6-bit opcode here: more than enough.
	// You are free to create your own "op" list - it will not be seen outside your design.
	DummyDecoder dec0 (
		// Feed the instruction as input
		.instr(instr),
		// Create and return opcode from instruction
		.op(op)
	);

	// Set up 10ns clock
	always #5 clk = !clk;

	task apply_and_check;
		input integer i;
		begin
			instr = instrmem[i];
			in1 = inreg1[i];
			in2 = inreg2[i];
			exp = expreg[i];
			// Clock tick not necessary, but keeps the tests cleanly separated
			@(posedge clk);

			if (out == exp) begin
				$display($time, " Passed op=%d, in1=%08x in2=%08x out=%08x", op, in1, in2, out);
			end else begin
				$display($time, " Fail op=%d, in1=%08x in2=%08x out=%08x exp=%08x", op, in1, in2, out, exp);
				err = err + 1;
			end
			total = total + 1;
		end
	endtask // apply_and_check

	initial begin
		// Initialize the clock 
		clk = 1;
		// Counters to track progress
		total = 0;
		err = 0;
		// Read in instructions, in1, in2 sequence
		$readmemh("instr.txt", instrmem);
		$readmemh("inreg1.txt", inreg1);
		$readmemh("inreg2.txt", inreg2);
		$readmemh("expreg.txt", expreg);

		for (i=0; i<`NUMTESTS; i=i+1) begin
			apply_and_check(i);
		end

		if (err > 0) begin
			$display("FAIL %d out of %d", err, total);
		end else begin
			$display("PASS %d tests", total);
		end
		$finish;
	end

endmodule // seq_mult_tb

`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:15:37 09/04/2019
// Design Name:   dmem
// Module Name:   /home/adithya/Documents/EE2003/Assignment 2/assn2/dmem_tb.v
// Project Name:  assn2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: dmem
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module dmem_tb;

	// Inputs
	reg [3:0]we;
	reg clk;
	reg [31:0] daddr;
	reg [31:0] indata;

	// Outputs
	wire [31:0] outdata;

	// Instantiate the Unit Under Test (UUT)
	dmem uut (
		.we(we), 
		.clk(clk), 
		.daddr(daddr), 
		.indata(indata), 
		.outdata(outdata)
	);
	always #10 clk = !clk;
	initial begin
		clk=1;
		// Initialize Inputs
		we = 4'b0001;
		daddr = 500;
		indata = 250;

		// Wait 100 ns for global reset to finish
		#100;
       we = 4'b0001;
		daddr = 500;
		indata = 100;
		// Add stimulus here
		#100
		we = 4'b0101;
		daddr = 1000;
		indata = 21'b111110000000000100101;
		#100
		we = 4'b0011;
		daddr = 1000;
		indata = 512;		
		#100
		we = 4'b0000;
		daddr = 1000;
		indata = 100;		
	end
      
endmodule


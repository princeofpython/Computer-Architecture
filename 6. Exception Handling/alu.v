`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:10:06 10/20/2019 
// Design Name: 
// Module Name:    alu 
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
module alu(
    input [31:0] in1,
    input [31:0] in2,
    input [3:0] alucon,
    output [31:0] out,
    output zero
    );
	assign zero = (out == 0);
	 
	assign out = (alucon== 0) ?  in1 + in2: //ADD
					(alucon == 8) ?  in1 - in2: //SUB
					(alucon == 1) ?  in1 << in2[4:0]: //SLL
					(alucon == 2) ?  {{31{1'b0}}, ($signed(in1) < $signed(in2))}: //SLT
					(alucon == 3) ?  {{31{1'b0}}, (in1 < in2)}: //SLTU
					(alucon == 4) ?  in1 ^ in2: //XOR
					(alucon == 5) ?  in1 >> in2[4:0]: //SRL
					(alucon == 13) ?  $signed(in1) >>> in2[4:0]: //SRA
					(alucon == 6) ?  in1 | in2: //OR
					(alucon == 7) ?  in1 & in2 : 32'h00000000; //AND
			 
endmodule

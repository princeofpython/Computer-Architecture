`include "parameters.v"

module DummyDecoder (
    instr,
    op
);
	input [`width-1:0] instr;
   output reg [`OPWIDTH:0] op;

	always @(instr) begin
        // Use a case statement or some other logic to generate suitable op code
         // - replace this with some proper logic
		case ({ instr[14:12], instr[5]})
			4'b0000 : op <= 0;
			4'b0100 : op <= 1;
			4'b0110 : op <= 2;
			4'b1000 : op <= 3;
			4'b1100 : op <= 4;
			4'b1110 : op <= 5;
			4'b0010 : op <= 6;
			4'b1010 :begin
			case(instr[30])
			0 : op <= 7;
			1 : op <= 8;
			endcase
			end
			4'b0001 : begin
			case(instr[30])
			0 : op <= 9;
			1 : op <= 10;
			endcase
			end
			4'b0011 : op <= 11;
			4'b0101 : op <= 12;
			4'b0111 : op <= 13;
			4'b1001 : op <= 14;
			4'b1011 : begin
			case(instr[30])
			0 : op <= 15;
			1 : op <= 16;
			endcase
			end
			4'b1101 : op <= 17;
			4'b1111 : op <= 18;
		endcase
	end

endmodule

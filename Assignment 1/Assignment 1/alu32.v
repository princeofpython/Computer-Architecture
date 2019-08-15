`include "parameters.v"

module ALU32 (
    in1, in2, op, out
);
    input [`width-1:0] in1, in2;
    input [`OPWIDTH-1:0] op;
    output reg [`width-1:0] out;
    always @(in1 or in2 or op) begin

        case(op)
			0 : out <= in1 + in2;
			1 : out <= {{31{1'b0}}, ($signed(in1) < $signed(in2))} ;
			2 : out <= {{31{1'b0}}, (in1 < in2)};
			3 : out <= in1 ^ in2;
			4 : out <= in1 | in2;
			5 : out <= in1 & in2;
			6 : out <= in1 << in2[4:0];
			7 : out <= in1 >> in2[4:0];
			8 : out <= $signed(in1) >>> in2[4:0];
			9 : out <= in1 + in2;
			10 : out <= in1 - in2;
			11 : out <= in1 << in2[4:0];
			12 : out <= {{31{1'b0}}, ($signed(in1) < $signed(in2))};
			13 : out <= {{31{1'b0}}, (in1 < in2)};
			14 : out <= in1 ^ in2;
			15 : out <= in1 >> in2[4:0];
			16 : out <= $signed(in1) >>> in2[4:0];
			17 : out <= in1 | in2;
			18 : out <= in1 & in2;
			endcase
    end

endmodule
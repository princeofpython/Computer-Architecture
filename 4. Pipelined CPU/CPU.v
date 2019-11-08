`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:44:46 10/15/2019 
// Design Name: 
// Module Name:    CPU 
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
module CPU(
    input reset,
    input clk,
    output [31:0] iaddr,  // address to instruction memory
    input [31:0] idata,   // data from instruction memory
    output [31:0] daddr,  // address to data memory
    input [31:0] drdata,  // data read from data memory
    output [31:0] dwdata, // data to be written to data memory
    output [3:0] we,      // write enable signal for each byte of 32-b word
    // Additional outputs for debugging
    output [31:0] x31,
    output reg [31:0] PC
);

wire [31:0] idatawire;
wire [31:0] PC_branch;
wire [31:0] PC_plus4;
wire PCsrc;
wire staller;

assign idatawire = idata;
assign PC_plus4 = PC + 32'd4;

always @(posedge reset or posedge clk) begin
		if (reset)
			PC <= 32'h00000000;
		else
			if (~(staller))
				PC <= PCsrc ? PC_branch :PC_plus4;
	end

assign iaddr = PC;

wire [31:0] PC_ID;
wire [31:0] idata_ID;

IF_ID ifid(
		.clk(clk),
		.staller((staller || PCsrc)),
		.PC_in(PC),
		.idata_in(idatawire),
		.PC_out(PC_ID),
		.idata_out(idata_ID)
		);

wire [1:0] alusrc;
wire memtoreg;
wire  regwrite;
wire [3:0] memwrite;
wire [2:0] branch;
wire [1:0] aluop;
wire [1:0] regin;
wire [2:0] imm;

wire [1:0] ALUsrc_EX;
wire memtoreg_EX;
wire  regwrite_EX;
wire [3:0] memwrite_EX;
wire [2:0] branch_EX;
wire [1:0] ALUop_EX;
wire [1:0] regin_EX;
wire [2:0] imm_EX;
//Control Unit

control CONTROL(
		.idata(idata_ID),
		.alusrc(alusrc),
		.memtoreg(memtoreg),
		.regwrite(regwrite),
		.memwrite(memwrite),
		.branch(branch),
		.aluop(aluop),
		.regin(regin),
		.imm(imm)
		);
		
wire [31:0]memtoregdata;
wire [31:0] indataforreg;
wire [31:0] regindata;
wire [31:0]datawire1;
wire [31:0]datawire2;
wire [31:0]datawire1_EX;
wire [31:0]datawire2_EX;
wire regwrite_WB;
wire [31:0] idata_WB;

// Register File

regfile REGFILE(
		.rs1(idata_ID[19:15]),
		.rs2(idata_ID[24:20]),
		.rd(idata_WB[11:7]),
		.indata(regindata),
		.we(regwrite_WB),
		.clk(clk),
		.rv1(datawire1),
		.rv2(datawire2),
		.x31(x31)
	);
wire [31:0] immgen;
wire [31:0] immgen_EX;
wire [31:0] PC_EX;
wire [31:0] idata_EX;

wire memread_EX;
assign memread_EX = (idata_EX[6:0]==7'b0000011);

staller HDU(
		.memread_EX(memread_EX),
		.idata_EX(idata_EX),
		.idata_ID(idata_ID),
		.staller(staller)
		);

immgen IMMGEN(
		.imm(imm),
		.idata(idata_ID),
		.immgen(immgen)
		);
reg PCsrc2;

ID_EX idex(
		.clk(clk),
		.regin_in((staller || PCsrc || PCsrc2) ? 0 : regin),
		.branch_in((staller || PCsrc|| PCsrc2) ? 0 : branch),
		.memtoreg_in((staller || PCsrc|| PCsrc2) ? 0 : memtoreg),
		.ALUop_in((staller || PCsrc|| PCsrc2) ? 0 : aluop),
		.ALUsrc_in((staller || PCsrc|| PCsrc2) ? 0 : alusrc),
		.regwrite_in((staller || PCsrc|| PCsrc2) ? 0 : regwrite),
		.memwrite_in((staller || PCsrc|| PCsrc2) ? 0 : memwrite),
		.rv1_in((staller || PCsrc|| PCsrc2) ? 0 :datawire1),
		.rv2_in((staller || PCsrc|| PCsrc2) ? 0 :datawire2),
		.rv1_out(datawire1_EX),
		.rv2_out(datawire2_EX),
		.immgen_in(immgen),
		.immgen_out(immgen_EX),
		.regin_out(regin_EX),
		.branch_out(branch_EX),
		.memtoreg_out(memtoreg_EX),
		.ALUop_out(ALUop_EX),
		.ALUsrc_out(ALUsrc_EX),
		.regwrite_out(regwrite_EX),
		.memwrite_out(memwrite_EX),
		.PC_in(PC_ID),
		.PC_out(PC_EX),
		.idata_in(idata_ID),
		.idata_out(idata_EX)
		);



wire [3:0] alucon;
wire [31:0] idata_MEM;
wire  regwrite_MEM;

alucontrol ALUCONTROL(
		.aluop(ALUop_EX),
		.funct7(idata_EX[31:25]),
		.funct3(idata_EX[14:12]),
		.alucon(alucon)
);

wire zero;
wire [31:0] aluoutdata;
wire [31:0] PC_plus4_EX;

wire [1:0] forwardA, forwardB;
// Forwarding unit
forwarding_unit FU(
		.idata_EX(idata_EX),
		.idata_MEM(idata_MEM),
		.idata_WB(idata_WB),
		.regwrite_MEM(regwrite_MEM),
		.regwrite_WB(regwrite_WB),
		.forwardA(forwardA),
		.forwardB(forwardB)
		);
wire [31:0] rv1forEX, rv2forEX;
wire [31:0] aluoutdata_MEM;

assign rv1forEX = (forwardA == 2'b10) ? aluoutdata_MEM:
						(forwardA == 2'b01) ? regindata: datawire1_EX;

assign rv2forEX = (forwardB == 2'b10) ? aluoutdata_MEM:
						(forwardB == 2'b01) ? regindata: datawire2_EX;
						
// Arithmetic Logic Unit
alu ALU(
		.in1(ALUsrc_EX[1] ? PC_EX : rv1forEX),
		.in2(ALUsrc_EX[0] ? immgen_EX : rv2forEX),
		.alucon(alucon),
		.out(aluoutdata),
		.zero(zero)
		);
		
PC ProgCount(
		.PC(PC_EX),
		.immgen(immgen_EX),
		.branch(branch_EX),
		.zero(zero),
		.aluoutdata(aluoutdata),
		.PC_plus4(PC_plus4_EX),
		.PC_next(PC_branch),
		.PCsrc(PCsrc)
		);
		

initial PCsrc2 = 0;

always@(posedge clk)begin
PCsrc2<=PCsrc;
end

wire [31:0] PC_plus4_MEM;
wire [31:0] immgen_MEM;

wire memtoreg_MEM;

wire [3:0] memwrite_MEM;
wire [1:0] regin_MEM;
wire [31:0]datawire2_MEM;

EX_MEM exmem(
		.clk(clk),
		.memtoreg_in(memtoreg_EX),
		.regwrite_in(regwrite_EX),
		.memwrite_in(memwrite_EX),
		.ALUout_in(aluoutdata),
		.rv2_in(rv2forEX),
		.rv2_out(datawire2_MEM),
		.ALUout_out(aluoutdata_MEM),
		.memwrite_out(memwrite_MEM),
		.regwrite_out(regwrite_MEM),
		.memtoreg_out(memtoreg_MEM),
		.immgen_in(immgen_EX),
		.immgen_out(immgen_MEM),
		.regin_in(regin_EX),
		.regin_out(regin_MEM),
		.PC_plus4_in(PC_plus4_EX),
		.PC_plus4_out(PC_plus4_MEM),
		.idata_in(idata_EX),
		.idata_out(idata_MEM)
		);
// Handling SW, SH, SB

assign we = (memwrite_MEM == 4'b1111 && daddr[1:0]== 2'b00) ? 4'b1111:
				(memwrite_MEM == 4'b0011 && daddr[1:0]== 2'b00) ? 4'b0011:
				(memwrite_MEM == 4'b0011 && daddr[1:0]== 2'b10) ? 4'b1100:
				(memwrite_MEM == 4'b0001 && daddr[1:0]== 2'b00) ? 4'b0001:
				(memwrite_MEM == 4'b0001 && daddr[1:0]== 2'b01) ? 4'b0010:
				(memwrite_MEM == 4'b0001 && daddr[1:0]== 2'b10) ? 4'b0100:
				(memwrite_MEM == 4'b0001 && daddr[1:0]== 2'b11) ? 4'b1000: 4'b0000;


assign dwdata = (memwrite_MEM == 4'b0000) ? datawire2_MEM : (datawire2_MEM << daddr[1:0] * 8) ;
assign daddr = aluoutdata_MEM;

wire [31:0] aluoutdata_WB;
wire [31:0] PC_plus4_WB;
wire [31:0] immgen_WB;
wire [31:0] daddr_WB;
wire memtoreg_WB;
wire [1:0] regin_WB;
wire [31:0]drdata_WB;

MEM_WB memwb(
		.clk(clk),
		.memtoreg_in(memtoreg_MEM),
		.regwrite_in(regwrite_MEM),
		.ALUout_in(aluoutdata_MEM),
		.drdata_in(drdata),
		.immgen_in(immgen_MEM),
		.PC_plus4_in(PC_plus4_MEM),
		.regin_in(regin_MEM),
		.idata_in(idata_MEM),
		.daddr_in(daddr),
		.daddr_out(daddr_WB),
		.idata_out(idata_WB),
		.regin_out(regin_WB),
		.PC_plus4_out(PC_plus4_WB),
		.immgen_out(immgen_WB),
		.ALUout_out(aluoutdata_WB),
		.drdata_out(drdata_WB),
		.memtoreg_out(memtoreg_WB),
		.regwrite_out(regwrite_WB)
		);
// Handling LW, LH, LB

assign memtoregdata = memtoreg_WB ? drdata_WB : aluoutdata_WB;
assign indataforreg = (memtoreg_WB && (idata_WB[14:12] == 3'b001 || idata_WB[14:12] == 3'b101)) ? ((memtoregdata >> (daddr_WB[1:0] * 8)) & 32'h0000FFFF) :
							 (memtoreg_WB && (idata_WB[14:12] == 3'b000 || idata_WB[14:12] == 3'b100)) ? ((memtoregdata >> (daddr_WB[1:0] * 8)) & 32'h000000FF) : memtoregdata;
							 
assign regindata = (regin_WB == 2'b00) ? immgen_WB :
						 (regin_WB == 2'b01) ? indataforreg :
						 (regin_WB == 2'b10) ? PC_plus4_WB : indataforreg ;

// CAlculation of next iaddr


endmodule

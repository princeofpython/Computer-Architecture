module cpu_tb();
    reg clk, reset, IRQ;
    wire [31:0] iaddr, idata;
    wire [31:0] daddr, drdata, dwdata;
    wire [3:0] we;
    wire [31:0] x31, PC;
	 wire IACK;

    CPU dut (
        .clk(clk),
        .reset(reset),
		  .IRQ(IRQ),
        .iaddr(iaddr),
        .idata(idata),
        .daddr(daddr),
        .drdata(drdata),
        .dwdata(dwdata),
        .we(we),
        .x31(x31),
        .PC(PC),
		  .IACK(IACK)
    );
	 
	 dmem dmem(
		.clk(clk),
		.daddr(daddr),
		.dwdata(dwdata),
		.drdata(drdata),
		.we(we)
		);
	 
	 imem imem(
		.iaddr(iaddr), 
		.idata(idata)
	);
	
    always #5 clk = ~clk;
    initial begin
        clk = 0;
		  IRQ = 0;
        reset = 1;
        #100
        reset = 0;
		  //#405
		  //IRQ=1;
    end

endmodule

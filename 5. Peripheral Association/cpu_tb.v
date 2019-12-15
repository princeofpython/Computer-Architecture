module cpu_tb();
    reg clk, reset;
	 wire CE, PWE;
	 wire [1:0] addr;
    wire [31:0] iaddr, idata;
    wire [31:0] daddr, drdata, dwdata, prdata, rdata;
    wire [3:0] we;
    wire [31:0] x31, PC;

    CPU dut (
        .clk(clk),
        .reset(reset),
        .iaddr(iaddr),
        .idata(idata),
        .daddr(daddr),
        .drdata(rdata),
        .dwdata(dwdata),
        .we(we),
        .x31(x31),
        .PC(PC)
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
	
	orbiter orbiter(
		.drdata(drdata),
		.prdata(prdata),
		.daddr(daddr),
		.CE(CE),
		.PWE(PWE),
		.we(we),
		.rdata(rdata),
		.addr(addr)
		);
		
	peripheral peripheral(
		.clk(clk),
		.CE(CE),
		.PWE(PWE),
		.addr(addr),
		.wdata(dwdata),
		.rdata(prdata)
		);
	
    always #5 clk = ~clk;
    initial begin
        clk = 0;
        reset = 1;
        #100
        reset = 0;
    end

endmodule

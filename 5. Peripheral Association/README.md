# Assignment 5 - Accumulator Peripheral
Implement a memory mapped peripheral that can attach to your CPU.

Functionality: Your peripheral must be capable of adding numbers written to it. It will have multiple register addresses as described below. Values that are written into the BASE+4 register will be accumulated in an internal 32-bit register, and each time a value is written, an internal 32-bit count register will be incremented. BASE+8 can be used to read back the total accumulated sum, and BASE+12 will return the number of values written so far.

CE and WE signals are inputs: only when CE is 1 should the peripheral respond to read requests, and only when CE=WE=1 should it accept writes.

Memory map of the peripheral:

- BASE + 0: Write - reset: write any value here to reset internal sum and count to 0
- BASE + 4: Write - value: write a number here to add it to internal sum
- BASE + 8: Read - return the total accumulated sum so far (since last reset)
- BASE + 12: Read - return the number of values written so far (since last reset)  
Module interface:
````
module peripheral(
  input clk, reset,
  input ce,
  input we,
  input [1:0] addr,  // only 2-bit address needed to decode 4 registers
  input [31:0] wdata,
  output [31:0] rdata
);
````
Submission:

- Block diagram design of peripheral
- Description of state machine used inside peripheral
- Test code for CPU that will write and read and validate functionality  

Note: this should work with the CPU design you have already submitted. If you need to change that, you can submit a fresh CPU design, but all subject to posted deadlines.

Also, this should work both with the single-cycle and pipelined designs.

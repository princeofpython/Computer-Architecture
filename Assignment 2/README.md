Assignment 2 - Register File and Memory Access
==============================================

Goal
----

In order to implement the load / store instructions in the `RV32I` instruction set, you require certain types of storage elements.  The goal of this assignment is to implement these elements, and demonstrate working in hardware.

*Note*: The `LD` instruction leads to certain difficulties when you try to implement it as a single cycle instruction, since the BRAMs present in Xilinx FPGAs cannot be read asynchronously.  Therefore this assignment is only about implementing the blocks and testing them, not the instructions.

### IMEM
This is the instruction memory: it is to be implemented as a single port Block RAM (BRAM) on hardware.  It will take a single value `iaddr` of 32 bits width as input, and generate a single value `idata` of 32 bits width as output.  The total capacity of `IMEM` should be 1K memory locations (1K = 2^10 = 1024), so only the bottom 10 bits of `iaddr` should be used for the address.  You can ignore the upper 22 bits for now.  In practice there should be an exception raised if you try to read from outside available memory, but we will ignore this for now.

Note: Since this has to be implemented using a Xilinx BRAM, even READ operations are synchronous, so it will generate the output at the clock edge.

### DMEM
Data memory: very similar to IMEM, but possible to either read or write, based on a `we` signal for write enable.  The main difference here is that you should implement it as *byte*-addressable, meaning that there should be a capacity of 4K locations of 8 bits each.  

The minimum requirement for this module is that it will take the given address, ignore the lowest two bits, and read out the 32-bit word at the address indicated.  Since there are only 4K byte locations, this means you consider only the lowest 12 bits of the address.

A more complex variant of this should allow you to also do Load and Store operations on 1 byte at a time - for this, you need to be able to select 8 bits out of the 32 and put them into the LSB 8 bits of the result (for Load) or write the LSB 8 bits to the specified memory location (for Store).  This will require more careful design.

Ports:
* `daddr` : 32 bit address.  Ignore the upper 20 bits for now.
* `clk` : will be used for synchronizing reads from/writes to the memory
* `we` : write enable: only write into memory when this is active
* `indata` : 32 bit input - to be written into `DMEM[daddr]` on clock edge if `we` is high
* `outdata` : 32 bit output - value read from `DMEM[daddr]` appears on `outdata` after clock edge.

*Note*: it may be possible to implement this using a dual-port BRAM.  You need to ensure that your solution can synthesize properly.  Also, the main requirement is to able to read 32-bit values - for reading 8 bit values you need to explain clearly all your assumptions and how you are implementing it.

### RegFile
32 element register file, each element capable of storing a 32 bit value.  Element at location 0 is permanently set to the value 0, and writing to this value will be ignored.

Ports:
* `rs1` : 5 bit address for location of register 1 to be read
* `rs2` : 5 bit address for location of register 2 to be read
* `rd` : 5 bit address for location of register to be written
* `we` : write enable signal - `RF[rd]` should be changed only when this is high
* `clk` : to sync writes to the register
* `indata` : 32 bit input - to be written into `RF[rd]` on clock edge if `we` is high
* `rv1` : 32 bit output corresponding to `RF[rs1]`
* `rv2` : 32 bit output corresponding to `RF[rs2]`

Note: This block cannot in general be implemented using BRAM, since we need to be able to read two values and write one value all within the same clock cycle.  You can write it in Verilog using general arrays, but need to make sure it synthesizes properly.

Tasks
-----

1. Write Verilog code for each of the blocks described.  You can either use Verilog arrays or direct module instantiation, but you must confirm that the final result is synthesizable and can be implemented on an FPGA.
2. Create a suitable test bench and suitable test cases to check whether the modules are functioning properly.  You can create your own test bench, but should be able to justify why it is a good enough test bench.
3. Implement on hardware using VIO and ILA (as needed) to demonstrate final functionality.

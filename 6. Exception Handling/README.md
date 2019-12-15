## Exception and Interrupt Handling 
The problem statement we chosen is exception handling and interrupt handling in a pipelined risc-v CPU. Basically, it checks the instruction if there is any misaligned access error or if opcode is invalid. Also, it handles interrupts based on input `IRQ` (interrupt query signal) . For all things above, PC address just jumps to a hardcoded `iaddr`. Next instruction address is saved on to a hardcoded register.

### My Approach: 
-	Misaligned access error handling is done in the EX stage (based on funct3 and output of ALU) 
-	Invalid opcode is handled in ID stage, but we’ll wait for one more cycle, so it reaches EX stage. 
-	From here, as our branch execution is done in EX stage,  based on error or not, we’ll change `PC`. 
-	Also for handling interrupts, we’ll wait till EX stage to change PC. 
-	For every case above, since we also have to save the next instruction address, we’ll have to make regwrite high and change register input data to PC+4. 
-	I commented most of our code, explaining what I did and why.

### Improvements:
-	We can have exception handlers and interrupt handlers, to which we can jump when we get them and come back afterwards (PC+4 is already saved)
-	We can also handle Arithmetic Overflow error.
-	We can maintain a  status register (hardcoded to one of in-built 32 registers). The status register is also a 32-bit register. It too, only has certain fields that are used by the processor. Bits will define masks for the each type of interrupts/exceptions. If an interrupt/exception occurs when its mask bit is current set to 0, then the interrupt/exception will be ignored. 
-	For managing nested interrupts, we need to left shift or right shift the status register. 

### How to run code:
-	Open project file assn6.xise in ISE project navigator.
-	For checking simulations, use cpu_tb.v file.
-	I couldn’t try implementing but I'm confident because there is no much change to well-implemented assignment 4.

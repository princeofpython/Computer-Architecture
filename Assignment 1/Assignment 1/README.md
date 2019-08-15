# Assignment 1: ALU

Your task is to create a combinational ALU that implements all ALU operations required in the RISC-V RV32I base integer instruction set.  The list of instructions is available on page 130 of the file `riscv-spec.pdf` that has been uploaded on Moodle.  The encodings of instructions are as per that table.

## Inputs

The test bench reads in four text files:

* `inreg1.txt`: contents of the first input to the ALU for each test
* `inreg2.txt`: contents of the second input to the ALU for each test
* `instr.txt`: instruction for each test
* `expreg.txt`: expected output for each test

Observe that the inputs to the ALU are themselves provided to you: it is not required to read them from a register, or to generate the inputs from the immediate operand.  This is a simplification we are assuming for this problem, since this part will have to be solved later when you implement the instruction decoder and register file.

## Given

You are given a test bench, a parameters file, and two skeleton Verilog files: one for the ALU, and one for a Dummy Decoder module.  The reason for this module is that the ALU by itself should not need to receive the full 32-bit instruction to perform its job.  It needs only a smaller opcode.  The decoder normally handles the task of examining the instruction and creating the opcode.  In the present assignment, you need not implement a complete decoder, only concentrate on what is required for performing ALU operations.

Keep in mind that the opcode sequence and the process by which you convert from instruction to opcode are completely open to you: you can use your own encoding, and whether you use `case` statements or `if` statements or other encodings in Verilog are up to you.

## Output

The ALU is a combinational module and will generate a 32-bit output for each input combination.  The expected output values are read from the file, and the test bench will compare against the expected output to generated the list of passed/failed tests.

## Assignment

You need to complete the following steps:

1. Complete the code for `alu32.v` and `dummy-decoder.v` to pass all the tests provided.
2. Ensure that your code is synthesizable, by testing with ISE for synthesis.  Only the `ALU32` and `DummyDecoder` blocks need to be synthesizable.
3. Create a hardware test bench for the `ALU32` module, with VIO for inputs and opcode, and verify correct behaviour on hardware.  Note that you can skip the automated tests here, but if you can figure out a way to automate it, that will count as a bonus.
 
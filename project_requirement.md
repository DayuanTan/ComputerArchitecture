
# 1. Project Requirement:

(Credits to Prof. John Eldon)

- Design the instruction set and overall architecture for your own special-purpose reduced instruction set (RISC) processor.
- Design the hardware for your processor core.

## 1.1 9-Bit Instruction Set Architecture

Your processor shall have 9-bit instructions (machine code) and shall be optimized for three simple programs, described below. For this lab, you shall design the instruction set and instruction formats and code three programs to run on your instruction set. Given the tight limit on instruction bits, you need to consider the target programs and their needs carefully. The best design will come from an iterative process of designing an ISA, then coding the programs, redesigning the ISA, etc.

Your instruction set architecture shall feature fixed-length instructions 9 bits wide. 

Your instruction-set specification should describe:

- what operations it supports and what their respective opcodes are.  
-	how many instruction formats it supports and what they are (in detail -- how many bits for each field, and where they’re found in the instruction). Y
-	number of registers, and how many general-purpose or specialized. All internal data paths and storage will be 8 bits wide.
-	addressing modes supported (this applies to both memory instructions and branch instructions).  Lookup tables? Sign extension? Direct addressing?  

For this to fit in a 9-bit field, the memory demands of these programs will have to be small. For example, you will have to be clever to support a conventional main memory of 256 bytes (8-bit address pointer). You should consider how much data space you will need before you finalize your instruction format. Your instructions are stored in a separate memory, so that your data addresses need be only big enough to hold data. Your data memory is byte-wide, i.e., loads and stores read and write exactly 8 bits (one byte). Your instruction memory is 9 bits wide, to hold your 9-bit machine code, but it can be as deep as you need to hold all three programs. This in turn impacts the width of your program counter, since it is the address pointer for the instruction memory.

You shall write and run three programs on your ISA. You may assume that the first starts at address 0, and the other two are found in memory after the end of the first program (at some nonoverlapping address of your choosing). The specification of your branch instructions may depend on where your programs reside in memory, so you should make sure they still work if the starting address changes a little (e.g., if you have to rewrite one of the programs and it causes the others to also shift). This approach will allow you to put all three programs in the same instruction memory later on in the quarter.

Constraints: You shall assume a single-address data memory (Verilog design provided). You shall also assume a register file (or whatever internal storage you support) that can write to only one register per instruction. You may also have a single ALU condition/flag register (e.g., carry out, or shift out, sign result, zero bit, etc., like ARM's Z, N, C, and V status bits) that can be written at the same time as an 8-bit register, if you want. You may read more than one register per cycle. Please restrict register file depth to no more than 16 registers. Also, manual loop unrolling of your code is not allowed.

Suggestions: In optimizing for performance, distinguish between what must be done in series vs. what can be done in parallel. An instruction that does an add and a subtract (but neither depends on the output of the other) takes no longer than a simple add instruction. Similarly, a branch instruction where the branch condition or target depends on a memory operation will make things more difficult later on. NOTE: In a single-cycle operation, this may not be an issue, but it would be in a pipelined processor.

 


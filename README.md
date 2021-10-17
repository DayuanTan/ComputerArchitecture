# ComputerArchitecture
Design an instruction set and overall architecture (ISA) for a special-purpose reduced instruction set (RISC) processor. Design the hardware for the processor core. 

# Project

(Credits to Prof. John Eldon)

- Design the instruction set and overall architecture (ISA) for your own special-purpose reduced instruction set (RISC) processor. Including:
  - Instruction set
  - Instruction format
  - Register amount (general-purpose or specialized?)
  - Addressing modes supported 
  - Constraints:
    - All internal data paths and storage will be 8 bits wide 
    - Conventional main memory of 256 bytes (8-bit address pointer)
- Your desgin should be optimized for three simple programs.
  - Program 1: Encrypter. Encrypt the message provided by users using a 7 bits Linear feedback shift registers (LFSR). Check [my note about LFSR here](img/mynote_LFSR.png).
  - Program 2: Decrypter. By examining the first 15 bytes of the message, figure out the seend (initial value) of the LFSR and its feedback pattern. Then decrypt the encrypted message. 
  - Program 3: Error Detection. Make use of the parity bit to detect error existence. 

- Design the hardware for your processor core.
- Design the assembler. 
  - Translate the assemble program writing in my designed ISA to machine code according to my designed hardware.


# My overall steps:
1. Implement these 3 programs using common assembly language, like MIPS/ARM.
2. Count how many operations/instructions are needed.
3. Classify those operations/instructions: S type, R-R type, I-R type, Mem type, BI type and Independent type. 
4. Design instructions format, how to split 9 bits, ISA (instructions set architecture).
5. Rewrite 3 programs using our designed instructions in step 4, replace those instructions in step 1.
6. Design hardware, including datapath, control signals.


## Step 1: Implement these 3 programs using common assembly language, like MIPS/ARM.

[pseudocode_program1](doc/pseudocode_program1.txt)

[pseudocode_program2](doc/pseudocode_program2.txt)

[pseudocode_program3](doc/pseudocode_program3.txt)

## Step 2 & 3 & 4: Design our ISA.

### Look Up Table
|Index |Contents|
|-|-|
|0|110 0000|
|1|100 1000|
|2|111 1000|
|3|111 0010|
|4|110 1010|
|5|110 1001|
|6|101 1100|
|7|111 1110|
|8|111 1011|
||




### Registers (4 bits):

|Register name|Binary|Purpose|
|-|-|-|
|r0|0000|General purpose|
|r1|0001|General purpose|
|r2|0010|General purpose|
|r3|0011|General purpose|
|s0|0100||General purpose but usually for variables with long lifetime |
|s1|0101|General purpose but usually for variables with long lifetime |
|s2|0110|General purpose but usually for variables with long lifetime |
|s3|0111|General purpose but usually for variables with long lifetime |
|s4|1000||General purpose but usually for variables with long lifetime |
|s5|1001||General purpose but usually for variables with long lifetime |
|s6|1010|General purpose but usually for variables with long lifetime |
|s7|1011|General purpose but usually for variables with long lifetime |
|s8|1100|General purpose but usually for variables with long lifetime |
||





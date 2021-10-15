

# 2. Three programs

## 2.1 Program 1 (encrypter): 

A message will be implanted by the test bench into your data memory, in locations [0:48], one ASCII character each): 
                                     
                                     Example: Mr. Watson, come here. I want to see you.
(Spaces and punctuation marks count.) 

Start with this message, but you should be able to handle any 1- to 49-byte (54-byte) message that uses ASCII characters corresponding to 0x20 through 0x7f.

1. (The 8-bit ASCII table at the end of this writeup shows how the test bench converts this sequence of characters into numerical bytes. 
Example:   M = 77 decimal = 0x4d)  
                             My Verilog test bench will handle this conversion for you.

2. The number of required initial preamble/padding ASCII space characters will be stored in data memory at location [61]. Prepend a preamble of ASCII space characters (space = 32 decimal = 0x20). After encryption, you shall put these into data_memory starting at [64].

3. Write (your) assembly code for a 7-bit maximal length linear feedback shift register (LFSR) using the index of the tap sequence number stored in data memory location 62. For example, if the tap for the corresponding stored number is 7543, then: 
```
             x'[0]    = x[7]^x[5]^x[4]^x[3];
             x'[6:1] = x[5:0];
```
      
where ^ denotes XOR and x[6] is the most significant bit of x and x[0] is the least. x'[6:0] is the "next state," and x[6:0] is the "present state." 
      
      
See 8-tap LFSR schematic at the end of this writeup to help you visualize what is going on. The logic symbols are XORs. Hint: use bitwise AND (&) for masking, with a Parity flag output. 

There are 9 different LFSR feedback patterns that result in a maximal length sequence of all 127 nonzero states. Your encryptor should be programmable to any randomly selected LFSR feedback pattern. The testbench will load the index of the LFSR pattern into data memory location [62] and the starting LFSR state into data_memory location [63]. 

4. For a count equal to the value in memory[61], bitwise XOR ASCII space = 0x20 with each successive value of your LFSR and write the results into data_memory[64:64+(mem[61])][6:0], with the constraint that there will be no fewer than 10 preamble space characters and no more than 15. Thus, if data_memory[61]<10, insert 10 spaces. If data_memory[61]>15, insert only 15 spaces. ( Note: this part has been handled in the test bench for you. ) (Rationale: we need a known 10-character sequence to synchronize our Lab 2 decoder.)

5. Now read each value of the message out of memory, starting at location [0], XOR it with the next state of the LFSR,  (subtract 0x20 - don’t need to do this subtraction anymore), and write the result back into memory locations starting where step 4 left off and continuing to [127]. (This includes the prepended and appended spaces characters, so just pad the end of the message with encrypted space characters to fill the space.)

6. Finally (or as you go), set bit [7] of each value in data_mem[64:127] to the reduction XOR (parity) of that location's bits[6:0]. This is precisely the P[0] or P0 augmented parity bit we saw in CSE140L, for those who took that class with me. 

7. The test bench will write out the resulting message by looking up the stored values in the ASCII table.  

Your ISA needs to be able to accomplish the above, starting with some way to bring in data from data_memory[0:63], generate a 7-bit LFSR, bitwise XOR each preamble (ASCII space) and data byte with a different LFSR state, insert parity in each MSB, and store the result back into data_memory[64:127]. See in-class demonstration.


## 2.2 Program 2 (decrypter):

An encrypted message from Program 1 will now occupy data memory locations [64:127]. 

1. By examining the first 10 bytes of this message, figure out the seed (inital) value for the LFSR and its feedback pattern. You will probably need to perform a correlation to accomplish this. (You, of course, know your own seed, but assume you received someone else's encrypted message, with an unknown seed and pattern. How would you crack the code, given that there are 127 possible initial seeds and 9 maximal length feedback patterns?) 

2. Proceed as in Program 1, except that we'll be reading from memory locations [64:127] and writing back to [0:63]. (This decrypted message will start with 10 to 15 ASCII space charcters, followed by the message itself, and ending in ASCII space characters as needed to fill the space.)

3. If you have properly seeded your decrypter's LFSR and can use the same feedback pattern as in the encrypter, you should be able to recover the original message.  

Your ISA needs to be able to accomplish everything it can already do for Program 1, but in addition, it needs to be able to search through LFSR states and identify the initial state (almost trivial) and the correct feedback tap pattern (a bit trickier). This is the heart of the assignment.  

 
## 2.3 Program 3 (error detection and remove initial space characters)

1. This program shall detect the location of the first non-space character in the message, since there will be leading preamble padding bits of 0x20. (The message itself may also have started with additional space characters. We shall remove these, as well, up to a total of 15, because we have no way of distinguishing padding preambles from starting spaces within the message body.) It will copy this character into memory location[0], and successive non-zero characters into memory [1, ...]. At the end of the message, it shall pad the remaining memory address values up to [63] with ASCII spaces.  

2. The other difference from Program 2 is that a few of the encrypted message characters may have one bad (flipped) bit. (Remember bit [7], our global parity? This is for error detection.) As you load each inoming message character, check its lower 7 bits for consistency with its highest bit ([7]). Half of the 256 possible 8-bit values will be wrong, whereas the others will be correct. If you detect a corrupt character, insert an error flag, 0x80, into the corresponding output character stream. To support accurate decryption and space removal, you may assume that the test bench will not inject any bit errors among the first 15 characters/bytes. 

3. Note that your device shall run all three programs in succession, controlled by a 4-bit interface with the test bench:

clk: digital clock (generated in test bench, input to your device)

rst: master reset (generated in test bench, input to your device -- in particular, puts your program counter at starting instruction address, most likely 0)

req: request device to start next program (generated in test bench, input to your device)

ack: "program done" flag (output generated by your device, tells test bench "check my work and then ask for the next program")

Note in particular that your device needs to bring the acknowledge / ack signal high right after it completes each program.

To make your life easier, you may make as separate simulation run for each program, rather than worrying about how to continue from one program to the next. Three separate test benches are provided, with this in mind.

## 2.4 ASCII table

https://www.asciitable.com


## 2.5 LFSR

https://en.wikipedia.org/wiki/Linear-feedback_shift_register

8 bits LFSR: Figure 1 and Figure 2 of http://www.digitalxplore.org/up_proc/pdf/91-1406198475105-107.pdf

7 bits LFSR: https://www.researchgate.net/figure/An-example-of-a-7-bit-LFSR_fig5_292130031




# please change the  filename and output_filename
#filename="program1.txt"
#output_filename="program1.bin"
#filename="program2.txt"
#output_filename="program2.bin"
#filename="program3_1.txt"
#output_filename="program3_1.bin"
filename="program3_2.txt"
output_filename="program3_2.bin"
with open(filename, 'r') as f:
    file=f.readlines()

op2num={
    "OPTR": "00001",
    "OPTR_imm": "11000",
    "MOV":"00010",
    "ADD":"00011",
    "SUB":"00100",
    "DIV":"00101",
    "AND":"00110",
    "OR":"00111",
    "XOR":"01000",
    "XORBIT":"01001",
    "SL":"10011",
    "BNZ":"10000",
    "BZ":"10001",
    "MOVI":"01101",
    "ADDI":"01110",
    "SUBI":"01111",
    "LOADB":"01010",
    "STOREB":"01011",
    "BNZI":"10110",
    "BZI":"10111",
    "BLEZI":"10010",
    "LUT":"01100",
    "J":"10100",
    "JI":"10101"
}
reg2num={
        "r0":"0000",
        "r1":"0001",
        "r2":"0010",
        "r3":"0011",
        "s0":"0100",
        "s1":"0101",
        "s2":"0110",
        "s3":"0111",
        "s4":"1000",
        "s5":"1001",
        "s6":"1010",
        "s7":"1011",
        "s8":"1100"
    }

def data2num(data):
    if data in list(reg2num.keys()):
        return reg2num[data]
    else:
        num="{0:b}".format(int(data))
        num='0'*(4-len(num))+num
        return num

with open(output_filename, 'w') as f:
    # f.write("memory_initialization_radix=2;\nmemory_initialization_vector=\n")
    for i, line in enumerate(file):
        inst=line.split()
        if (inst[0] in ["OPTR","BNZ","BZ","J"]) and inst[1] not in list(reg2num.keys()):
            print(i,line)
        if (inst[0] in ["OPTR_imm", "BNZI", "BZI", "JI"]) and inst[1] in list(reg2num.keys()):
            print(i,line)
        inst_machine = op2num[inst[0]]+data2num(inst[1])
        f.write(inst_machine+"\n")
    # f.write(";")

    f.write("000000000\n"*(256-len(file)))

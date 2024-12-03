module Instruction_Memory(rst, PC, instr1, instr2);
    input rst;
    input [15:0] PC;
    output [15:0] instr1, instr2;
    parameter depth = 2**16;
    reg [7:0] mem [depth-1:0];
    wire misaligned_instr;
    wire [15:0] PC_plus_2 = PC + 16'h2;
    //initial $readmemh("C:/Xilinx/IITB_RISC/memory.txt",mem);
    assign instr1 = (rst)? 16'hb000: {mem[PC+1], mem[PC]};
    assign instr2 = (rst)? 16'hb000: {mem[PC_plus_2+1], mem[PC_plus_2]};
    assign misaligned_instr = PC[0];
endmodule
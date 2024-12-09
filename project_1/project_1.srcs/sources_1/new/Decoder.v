`timescale 1ns / 1ps
module decode(clk, rst, IA1, IA2, instr1, instr2, branch_predict1, 
              branch_predict2, valid1, valid2, IA1_out, IA2_out, op1, op2, RA1, RA2, RB1, RB2, RC1, RC2, comp1, comp2, 
              CZ1, CZ2, Imm1_1, Imm1_2, Imm2_1, Imm2_2, SEI1_1, SEI1_2, SEI2_1, SEI2_2,
              spec_tag1, spec_tag2, valid1_out, valid2_out, branch_predict1_out, 
              branch_predict2_out);
    input clk, rst;
    input [15:0] IA1, IA2;
    input [15:0] instr1, instr2;
    input valid1, valid2;
    output valid1_out, valid2_out;
    input branch_predict1, branch_predict2;
    output [3:0] op1, op2;
    output [2:0] RA1, RA2, RB1, RB2, RC1, RC2;
    output comp1, comp2;
    output [1:0] CZ1, CZ2;
    output [5:0] Imm1_1, Imm1_2;
    output [8:0] Imm2_1, Imm2_2;
    output [15:0] SEI1_1, SEI1_2;
    output [15:0] SEI2_1, SEI2_2;
    output branch_predict1_out, branch_predict2_out;
    output [15:0] IA1_out, IA2_out;
    output reg [1:0] spec_tag1, spec_tag2;
    
    reg [1:0] spec_tag, next_spec_tag;
    
    assign IA1_out = IA1;
    assign op1 = instr1[15:12];
    assign RA1 = instr1[11:9];
    assign RB1 = instr1[8:6];
    assign RC1 = instr1[5:3];
    assign comp1 = instr1[2];
    assign CZ1 = instr1[1:0];
    assign Imm1_1 = instr1[5:0];
    assign Imm2_1 = instr1[8:0];
    assign SEI1_1 = {{10{Imm1_1[5]}},Imm1_1};
    assign SEI2_1 = {{7{Imm2_1[8]}},Imm2_1};
    assign valid1_out = valid1;
    assign branch_predict1_out = branch_predict1;
    
    assign IA2_out = IA2;
    assign op2 = instr2[15:12];
    assign RA2 = instr2[11:9];
    assign RB2 = instr2[8:6];
    assign RC2 = instr2[5:3];
    assign comp2 = instr2[2];
    assign CZ2 = instr2[1:0];
    assign Imm1_2 = instr2[5:0];
    assign Imm2_2 = instr2[8:0];
    assign SEI1_2 = {{10{Imm1_2[5]}},Imm1_2};
    assign SEI2_2 = {{7{Imm2_2[8]}},Imm2_2};
    assign valid2_out = valid2;
    assign branch_predict2_out = branch_predict2;
    
    wire branch1 = (op1 == 4'b1000)|(op1 == 4'b1001)|(op1 == 4'b1010)|(op1 == 4'b1101)|(op1 == 4'b1100)|(op1 == 4'b1111);
    wire branch2 = (op1 == 4'b1000)|(op1 == 4'b1001)|(op1 == 4'b1010)|(op1 == 4'b1101)|(op1 == 4'b1100)|(op1 == 4'b1111);
    
    //spec_tag1 and spec_tag2
    always @ (*) begin
        case ({branch2, branch1})
            2'b00: begin
                spec_tag1 <= spec_tag;
                spec_tag2 <= spec_tag;
                next_spec_tag <= spec_tag;
            end
            2'b01: begin
                spec_tag1 <= spec_tag + 2'd1;
                spec_tag2 <= spec_tag + 2'd1;
                next_spec_tag <= spec_tag + 1'd1;
            end
            2'b10: begin
                spec_tag1 <= spec_tag;
                spec_tag2 <= spec_tag + 2'd1;
                next_spec_tag <= spec_tag + 2'd1;
            end
            2'b11: begin
                spec_tag1 <= spec_tag + 2'd1;
                spec_tag2 <= spec_tag + 2'd2;
                next_spec_tag <= spec_tag + 2'd2;
            end
            default: begin
                spec_tag1 <= spec_tag;
                spec_tag2 <= spec_tag;
                next_spec_tag <= spec_tag;
            end
        endcase
    end
    always @ (*) begin
        case ({branch2, branch1})
            2'b00: next_spec_tag <= spec_tag;
            2'b01, 2'b10: begin
                if (spec_tag == 2'b11) next_spec_tag <= 2'b01;
                else next_spec_tag <= spec_tag + 1'd1;
            end 
            2'b11: begin
                if (spec_tag == 2'b11) next_spec_tag <= 2'b10;
                else if (spec_tag == 2'b10) next_spec_tag <= 2'b01;
                else next_spec_tag <= spec_tag + 2'd2;
            end 
            default: next_spec_tag <= spec_tag;
        endcase
    end
    always @ (posedge clk) begin
        if (rst) spec_tag <= 2'b00;//00 = non-speculative
        else spec_tag <= next_spec_tag;
    end
    
endmodule
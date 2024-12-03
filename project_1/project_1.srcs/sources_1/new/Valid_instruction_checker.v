module Valid_instruction_checker(rst, instr1, branch_predict1, instr2, valid1, valid2);
    input rst;
    input [15:0] instr1, instr2;
    input branch_predict1;
    output valid1, valid2;
    assign valid1 = (rst)? 1'b0: 1'b1;
    assign valid2 = (rst)? 1'b0: (branch_predict1)? 1'b0: 1'b1;
endmodule

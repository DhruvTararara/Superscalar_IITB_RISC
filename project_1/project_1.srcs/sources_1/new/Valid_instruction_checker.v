`timescale 1ns / 1ps
module Valid_instruction_checker(rst, instr1, branch_predict1, instr2, valid1, valid2);
    input rst;
    input [15:0] instr1, instr2;
    input branch_predict1;
    output valid1, valid2;
    reg valid_op;
    assign valid1 = (rst | valid_op)? 1'b0: 1'b1;
    assign valid2 = (rst | valid_op)? 1'b0: (branch_predict1)? 1'b0: 1'b1;
    always @ (*) begin
        case (instr1[15:12])
            4'h0, 4'h1, 4'h2, 4'h3, 4'h4, 4'h5, 4'h8, 4'h9, 4'ha, 4'hc, 4'hd, 4'hf: valid_op <= 1'b0;
            default: valid_op <= 1'b1;
        endcase
    end
endmodule
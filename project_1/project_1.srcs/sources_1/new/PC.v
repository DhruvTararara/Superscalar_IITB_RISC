`timescale 1ns / 1ps
module PC(clk, rst, branch_predict1, branch_predict_PC1, branch_predict2, branch_predict_PC2, 
          branch_resolve, branch_resolve_PC, PC_Write, PC_in, PC_out);
    input clk, rst;
    input branch_predict1, branch_predict2, branch_resolve, PC_Write;
    input [15:0] branch_predict_PC1, branch_predict_PC2, branch_resolve_PC, PC_in;
    output reg [15:0] PC_out;
    parameter BOOT_ADDRESS = 16'h0000;
    always @ (posedge clk) begin
        if (rst) PC_out <= BOOT_ADDRESS;
        else begin
            if (PC_Write) begin
                if (branch_resolve) PC_out <= branch_resolve_PC;
                else if (branch_predict1) PC_out <= branch_predict_PC1;
                else if (branch_predict2) PC_out <= branch_predict_PC2;
                else PC_out <= PC_in + 16'h4;
            end
            else PC_out <= PC_out;
        end
    end
endmodule
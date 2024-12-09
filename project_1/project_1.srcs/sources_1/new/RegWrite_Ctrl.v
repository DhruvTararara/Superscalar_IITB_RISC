`timescale 1ns / 1ps
module RegWrite_Ctrl(
    input valid1, valid2,
    input [3:0] op1, op2,
    input stall,
    output reg RegWrite1, RegWrite2);
    always @ (*) begin
        if (!stall) begin
            if (valid1) begin
                case (op1)
                    4'b0000, 4'b0001, 4'b0010, 4'b0011, 4'b0100, 4'b1100, 4'b1101: RegWrite1 <= 1'b1;
                    4'b0101, 4'b1000, 4'b1001, 4'b1010, 4'b1111: RegWrite1 <= 1'b0;
                    default: RegWrite1 <= 1'b0;
                endcase
            end
            else RegWrite1 <= 1'b0;
            if (valid2) begin
                case (op2)
                    4'b0000, 4'b0001, 4'b0010, 4'b0011, 4'b0100, 4'b1100, 4'b1101: RegWrite2 <= 1'b1;
                    4'b0101, 4'b1000, 4'b1001, 4'b1010, 4'b1111: RegWrite2 <= 1'b0;
                    default: RegWrite2 <= 1'b0;
                endcase
            end
            else RegWrite2 <= 1'b0;
        end
        else begin
            RegWrite1 <= 1'b0;
            RegWrite2 <= 1'b0;
        end
    end
endmodule

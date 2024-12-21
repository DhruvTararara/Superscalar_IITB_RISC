`timescale 1ns / 1ps
module Register_Interdependence(
    input RW1, RW2,
    input [2:0] RA1, RA2, RB1, RB2, RC1, RC2, Rd1, Rd2,
    input [2:0] FU_bits1, FU_bits2,
    output reg [2:0] RAW, 
    output reg WAR, WAW);
    
    always @ (*) begin
        if (RW1) begin
            if (RA2 == Rd1) RAW[0] <= 1'b1;
            else RAW[0] <= 1'b0;
            if (RB2 == Rd1) RAW[1] <= 1'b1;
            else RAW[1] <= 1'b0;
            if (RC2 == Rd1 && FU_bits2 == 3'b010) RAW[2] <= 1'b1;
            else RAW[2] <= 1'b0;
        end
        else RAW <= 3'b000;
    end
    always @ (*) begin
        if (RW2 && ((Rd2 == RA1) || (Rd2 == RB1) || (Rd2 == RC1 && FU_bits2 == 3'b010))) WAR <= 1'b1;
        else WAR <= 1'b0;
    end
    always @ (*) begin
        if (RW1 && RW2 && (Rd1 == Rd2)) WAW <= 1'b1;
        else WAW <= 1'b0;
    end
endmodule

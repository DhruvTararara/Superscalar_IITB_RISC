module Register_Interdependence(
    input RW1, RW2,
    input RA1, RA2, RB1, RB2, RC1, RC2,
    input FU_bits1, FU_bits2,
    output reg [2:0] RAW, 
    output reg WAR, WAW);
    
    always @ (*) begin
        if (RW1) begin
            if (RA2 == RC1) RAW[0] <= 1'b1;
            else RAW[0] <= 1'b1;
            if (RB2 == RC1) RAW[1] <= 1'b1;
            else RAW[1] <= 1'b1;
            if (RC2 == RC1 && FU_bits2 == 2'b10) RAW[2] <= 1'b1;
            else RAW[2] <= 1'b1;
        end
        else RAW <= 3'b000;
    end
    always @ (*) begin
        if (RW2 && ((RC2 == RA1) || (RC2 == RB1))) WAR <= 1'b1;
        else WAR <= 1'b0;
    end
    always @ (*) begin
        if (RW1 && RW2 && (RC1 == RC2)) WAW <= 1'b1;
        else WAW <= 1'b0;
    end
endmodule

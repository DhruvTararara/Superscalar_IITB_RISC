`timescale 1ns / 1ps
module Issue_Unit(
    input [2:0] FU0, FU1, FU2, FU3, FU4, FU5, FU6, FU7,
    input [15:0] PC0, PC1, PC2, PC3, PC4, PC5, PC6, PC7,
    input [7:0] Ready_bits,
    output [2:0] Issue_RS_b, Issue_RS_a, Issue_RS_ls,
    output [15:0] PC_bi, PC_ai, PC_a2i, PC_lsi,
    output reg [2:0] Issue_RS_a2, 
    output valid_issue_b, valid_issue_a, valid_issue_ls,
    output reg valid_issue_a2);
    reg [7:0] b, a, ls;
    wire [2:0] FU [7:0];
    wire [15:0] PC [7:0];
    assign {FU[7], FU[6], FU[5], FU[4], FU[3], FU[2], FU[1], FU[0]} = {FU7, FU6, FU5, FU4, FU3, FU2, FU1, FU0};
    assign {PC[7], PC[6], PC[5], PC[4], PC[3], PC[2], PC[1], PC[0]} = {PC7, PC6, PC5, PC4, PC3, PC2, PC1, PC0};
    
    always @ (*) begin
        if (Ready_bits[0]) begin
            if (FU[0][0]) b[0] <= 1'b1;
            else b[0] <= 1'b0;
            if (FU[0][1]) a[0] <= 1'b1;
            else a[0] <= 1'b0;
            if (FU[0][2]) ls[0] <= 1'b1;
            else ls[0] <= 1'b0;
        end
        else {b[0], a[0], ls[0]} <= 3'b000;
        if (Ready_bits[1]) begin
            if (FU[1][0]) b[1] <= 1'b1;
            else b[1] <= 1'b0;
            if (FU[1][1]) a[1] <= 1'b1;
            else a[1] <= 1'b0;
            if (FU[1][2]) ls[1] <= 1'b1;
            else ls[1] <= 1'b0;
        end
        else {b[1], a[1], ls[1]} <= 3'b000;
        if (Ready_bits[2]) begin
            if (FU[2][0]) b[2] <= 1'b1;
            else b[2] <= 1'b0;
            if (FU[2][1]) a[2] <= 1'b1;
            else a[2] <= 1'b0;
            if (FU[2][2]) ls[2] <= 1'b1;
            else ls[2] <= 1'b0;
        end
        else {b[2], a[2], ls[2]} <= 3'b000;
        if (Ready_bits[3]) begin
            if (FU[3][0]) b[3] <= 1'b1;
            else b[3] <= 1'b0;
            if (FU[3][1]) a[3] <= 1'b1;
            else a[3] <= 1'b0;
            if (FU[3][2]) ls[3] <= 1'b1;
            else ls[3] <= 1'b0;
        end
        else {b[3], a[3], ls[3]} <= 3'b000;
        if (Ready_bits[4]) begin
            if (FU[4][0]) b[4] <= 1'b1;
            else b[4] <= 1'b0;
            if (FU[4][1]) a[4] <= 1'b1;
            else a[4] <= 1'b0;
            if (FU[4][2]) ls[4] <= 1'b1;
            else ls[4] <= 1'b0;
        end
        else {b[4], a[4], ls[4]} <= 3'b000;
        if (Ready_bits[5]) begin
            if (FU[5][0]) b[5] <= 1'b1;
            else b[5] <= 1'b0;
            if (FU[5][1]) a[5] <= 1'b1;
            else a[5] <= 1'b0;
            if (FU[5][2]) ls[5] <= 1'b1;
            else ls[5] <= 1'b0;
        end
        else {b[5], a[5], ls[5]} <= 3'b000;
        if (Ready_bits[6]) begin
            if (FU[6][0]) b[6] <= 1'b1;
            else b[6] <= 1'b0;
            if (FU[6][1]) a[6] <= 1'b1;
            else a[6] <= 1'b0;
            if (FU[6][2]) ls[6] <= 1'b1;
            else ls[6] <= 1'b0;
        end
        else {b[6], a[6], ls[6]} <= 3'b000;
        if (Ready_bits[7]) begin
            if (FU[7][0]) b[7] <= 1'b1;
            else b[7] <= 1'b0;
            if (FU[7][1]) a[7] <= 1'b1;
            else a[7] <= 1'b0;
            if (FU[7][2]) ls[7] <= 1'b1;
            else ls[7] <= 1'b0;
        end
        else {b[7], a[7], ls[7]} <= 3'b000;
    end
    
    assign Issue_RS_b = (b[0])? 3'd0: (b[1])? 3'd1: (b[2])? 3'd2: (b[3])? 3'd3: 
                        (b[4])? 3'd4: (b[5])? 3'd5: (b[6])? 3'd6: (b[7])? 3'd7: 3'd0; 
    assign valid_issue_b = (|b);
    assign PC_bi = PC[Issue_RS_b];
    assign Issue_RS_a = (a[0])? 3'd0: (a[1])? 3'd1: (a[2])? 3'd2: (a[3])? 3'd3: 
                        (a[4])? 3'd4: (a[5])? 3'd5: (a[6])? 3'd6: (a[7])? 3'd7: 3'd0; 
    assign valid_issue_a = (|a);
    assign PC_ai = PC[Issue_RS_a];
    always @ (*) begin
        if (a[0]) begin
            if (a[1]) begin valid_issue_a2 <= 1'b1; Issue_RS_a2 <= 3'd1; end
            else if (a[2]) begin valid_issue_a2 <= 1'b1; Issue_RS_a2 <= 3'd2; end
            else if (a[3]) begin valid_issue_a2 <= 1'b1; Issue_RS_a2 <= 3'd3; end
            else if (a[4]) begin valid_issue_a2 <= 1'b1; Issue_RS_a2 <= 3'd4; end
            else if (a[5]) begin valid_issue_a2 <= 1'b1; Issue_RS_a2 <= 3'd5; end
            else if (a[6]) begin valid_issue_a2 <= 1'b1; Issue_RS_a2 <= 3'd6; end
            else if (a[7]) begin valid_issue_a2 <= 1'b1; Issue_RS_a2 <= 3'd7; end
            else begin valid_issue_a2 <= 1'b0; Issue_RS_a2 <= 3'd0; end
        end
        else if (a[1]) begin
            if (a[2]) begin valid_issue_a2 <= 1'b1; Issue_RS_a2 <= 3'd2; end
            else if (a[3]) begin valid_issue_a2 <= 1'b1; Issue_RS_a2 <= 3'd3; end
            else if (a[4]) begin valid_issue_a2 <= 1'b1; Issue_RS_a2 <= 3'd4; end
            else if (a[5]) begin valid_issue_a2 <= 1'b1; Issue_RS_a2 <= 3'd5; end
            else if (a[6]) begin valid_issue_a2 <= 1'b1; Issue_RS_a2 <= 3'd6; end
            else if (a[7]) begin valid_issue_a2 <= 1'b1; Issue_RS_a2 <= 3'd7; end
            else begin valid_issue_a2 <= 1'b0; Issue_RS_a2 <= 3'd0; end
        end
        else if (a[2]) begin
            if (a[3]) begin valid_issue_a2 <= 1'b1; Issue_RS_a2 <= 3'd3; end
            else if (a[4]) begin valid_issue_a2 <= 1'b1; Issue_RS_a2 <= 3'd4; end
            else if (a[5]) begin valid_issue_a2 <= 1'b1; Issue_RS_a2 <= 3'd5; end
            else if (a[6]) begin valid_issue_a2 <= 1'b1; Issue_RS_a2 <= 3'd6; end
            else if (a[7]) begin valid_issue_a2 <= 1'b1; Issue_RS_a2 <= 3'd7; end
            else begin valid_issue_a2 <= 1'b0; Issue_RS_a2 <= 3'd0; end
        end
        else if (a[3]) begin
            if (a[4]) begin valid_issue_a2 <= 1'b1; Issue_RS_a2 <= 3'd4; end
            else if (a[5]) begin valid_issue_a2 <= 1'b1; Issue_RS_a2 <= 3'd5; end
            else if (a[6]) begin valid_issue_a2 <= 1'b1; Issue_RS_a2 <= 3'd6; end
            else if (a[7]) begin valid_issue_a2 <= 1'b1; Issue_RS_a2 <= 3'd7; end
            else begin valid_issue_a2 <= 1'b0; Issue_RS_a2 <= 3'd0; end
        end
        else if (a[4]) begin
            if (a[5]) begin valid_issue_a2 <= 1'b1; Issue_RS_a2 <= 3'd5; end
            else if (a[6]) begin valid_issue_a2 <= 1'b1; Issue_RS_a2 <= 3'd6; end
            else if (a[7]) begin valid_issue_a2 <= 1'b1; Issue_RS_a2 <= 3'd7; end
            else begin valid_issue_a2 <= 1'b0; Issue_RS_a2 <= 3'd0; end
        end
        else if (a[5]) begin
            if (a[6]) begin valid_issue_a2 <= 1'b1; Issue_RS_a2 <= 3'd6; end
            else if (a[7]) begin valid_issue_a2 <= 1'b1; Issue_RS_a2 <= 3'd7; end
            else begin valid_issue_a2 <= 1'b0; Issue_RS_a2 <= 3'd0; end
        end
        else if (a[6]) begin
            if (a[7]) begin valid_issue_a2 <= 1'b1; Issue_RS_a2 <= 3'd7; end
            else begin valid_issue_a2 <= 1'b0; Issue_RS_a2 <= 3'd0; end
        end
        else begin valid_issue_a2 <= 1'b0; Issue_RS_a2 <= 3'd0; end
    end
    assign PC_a2i = PC[Issue_RS_a2];
    assign Issue_RS_ls = (ls[0])? 3'd0: (ls[1])? 3'd1: (ls[2])? 3'd2: (ls[3])? 3'd3: 
                         (ls[4])? 3'd4: (ls[5])? 3'd5: (ls[6])? 3'd6: (ls[7])? 3'd7: 3'd0; 
    assign valid_issue_ls = (|ls);
    assign PC_lsi = PC[Issue_RS_ls];
    
endmodule
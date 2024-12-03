module Issue_Unit(
    input [2:0] FU0, FU1, FU2, FU3, FU4, FU5, FU6, FU7,
    input [7:0] Ready_bits,
    output [2:0] Issue_RS_b, Issue_RS_a, Issue_RS_ls,
    output valid_issue_b, valid_issue_a, valid_issue_ls);
    reg [7:0] b, a, ls;
    wire [2:0] FU [7:0];
    assign {FU[7], FU[6], FU[5], FU[4], FU[3], FU[2], FU[1], FU[0]} = {FU7, FU6, FU5, FU4, FU3, FU2, FU1, FU0};
    
    generate
        genvar i;
        for (i = 0; i < 8; i = i + 1) begin
            always @ (*) begin
                if (Ready_bits[i]) begin
                    if (FU[i] == 3'b001) b[i] <= 1'b1;
                    else b[i] <= 1'b0;
                    if (FU[i] == 3'b010) a[i] <= 1'b1;
                    else a[i] <= 1'b0;
                    if (FU[i] == 3'b100) ls[i] <= 1'b1;
                    else ls[i] <= 1'b0;
                end
                else {b[i], a[i], ls[i]} <= 3'b000;
            end
        end
    endgenerate
    assign Issue_RS_b = (b[0])? 3'd0: (b[1])? 3'd1: (b[2])? 3'd2: (b[3])? 3'd3: 
                        (b[4])? 3'd4: (b[5])? 3'd5: (b[6])? 3'd6: (b[7])? 3'd7: 3'd0; 
    assign valid_issue_b = (^b);
    assign Issue_RS_a = (a[0])? 3'd0: (a[1])? 3'd1: (a[2])? 3'd2: (a[3])? 3'd3: 
                        (a[4])? 3'd4: (a[5])? 3'd5: (a[6])? 3'd6: (a[7])? 3'd7: 3'd0; 
    assign valid_issue_a = (^a);
    assign Issue_RS_ls = (ls[0])? 3'd0: (ls[1])? 3'd1: (ls[2])? 3'd2: (ls[3])? 3'd3: 
                         (ls[4])? 3'd4: (ls[5])? 3'd5: (ls[6])? 3'd6: (ls[7])? 3'd7: 3'd0; 
    assign valid_issue_ls = (^ls);
    
endmodule
module Allocate_unit(
    input [15:0] PC1, PC2,
    input [3:0] op1, op2,
//    input [3:0] RR_free_bitmap,
    input RR_stall,//input from Register File
//    input [7:0] ROB_free_bitmap,
    input [2:0] ROB_head,
    input [2:0] ROB_tail,
    input [7:0] RS_free_bitmap,
    input RegWrite1, RegWrite2,
    input CWrite1, ZWrite1, CWrite2, ZWrite2,
    input [2:0] RA1, RA2, RB1, RB2, RC1, RC2,//input from Dispatch buffer
    input valid1, valid2,//input from Dispatch buffer
    input [15:0] ra1, ra2, rb1, rb2, rc1, rc2,//input from Register File
    input v_ra1, v_ra2, v_rb1, v_rb2, v_rc1, v_rc2,//input from Register File
    input c1, c2, z1, z2, v_c1, v_c2, v_z1, v_z2,//input from C and Z Registers
    input [2:0] b_ctrl1, b_ctrl2,
    input [5:0] a_ctrl1, a_ctrl2,
    input [2:0] ls_ctrl1, ls_ctrl2,
    input [1:0] spec_tag1, spec_tag2,
    input branch_predict1, branch_predict2,
    input [8:0] Imm2_1, Imm2_2,
    input [1:0] FU_bits1, FU_bits2,
    input [15:0] SEI1_1, SEI1_2, SEI2_1, SEI2_2,
    output reg valid1_out, valid2_out,//output to Register File
    output RegWrite1_out, RegWrite2_out,//output to Register File
    output [2:0] RA1_out, RA2_out, RB1_out, RB2_out, RC1_out, RC2_out,//output to Register File
    output reg [2:0] RS_tag1, RS_tag2,//output to Register File and Reservation Station
    output [2:0] FU_bits1_out, FU_bits2_out,//output to Register File
    output reg [2:0] ROB_tag1, ROB_tag2,
    output reg [136:0] RS_input1, RS_input2,//To reservation station
    output reg [23:0] ROB_input1, ROB_input2,
    output reg stall);
    
    reg erb;
//    wire [2:0] RR_sum = RR_free_bitmap[0] + RR_free_bitmap[1] + RR_free_bitmap[2] + RR_free_bitmap[3] + RR_free_bitmap[4] + RR_free_bitmap[5] + RR_free_bitmap[6] + RR_free_bitmap[7];
    wire [3:0] RS_sum = RS_free_bitmap[0] + RS_free_bitmap[1] + RS_free_bitmap[2] + RS_free_bitmap[3] + RS_free_bitmap[4] + RS_free_bitmap[5] + RS_free_bitmap[6] + RS_free_bitmap[7];
    wire [3:0] ROB_sum = 4'd8 - ((ROB_tail - ROB_head) % 8);//ROB_free_bitmap[0] + ROB_free_bitmap[1] + ROB_free_bitmap[2] + ROB_free_bitmap[3] + ROB_free_bitmap[4] + ROB_free_bitmap[5] + ROB_free_bitmap[6] + ROB_free_bitmap[7];
    wire [2:0] free_RS1, free_RS2;
    wire [2:0] free_ROB1, free_ROB2;
    
    assign RegWrite1_out = RegWrite1;
    assign RegWrite2_out = RegWrite2;
    assign {RA1_out, RA2_out, RB1_out, RB2_out, RC1_out, RC2_out} = {RA1, RA2, RB1, RB2, RC1, RC2};
    assign {FU_bits1_out, FU_bits2_out} = {FU_bits1, FU_bits2};
    assign free_RS1 = (RS_free_bitmap[0])? 3'b000:
                      (RS_free_bitmap[1])? 3'b001:
                      (RS_free_bitmap[2])? 3'b010:
                      (RS_free_bitmap[3])? 3'b011:
                      (RS_free_bitmap[4])? 3'b100:
                      (RS_free_bitmap[5])? 3'b101:
                      (RS_free_bitmap[6])? 3'b110:
                      (RS_free_bitmap[7])? 3'b111: 3'b000;
    wire [7:0] sub1 = RS_free_bitmap - (1 << (free_RS1));
    assign free_RS2 = (sub1[0])? 3'b000:
                      (sub1[1])? 3'b001:
                      (sub1[2])? 3'b010:
                      (sub1[3])? 3'b011:
                      (sub1[4])? 3'b100:
                      (sub1[5])? 3'b101:
                      (sub1[6])? 3'b110:
                      (sub1[7])? 3'b111: 3'b000;
    
    assign free_ROB1 = ROB_tail;
    assign free_ROB2 = ROB_tail + 3'd1;
    
    always @ (*) begin
        if (valid1 & valid2) begin
            if (!RR_stall & (ROB_sum >= 2) & (RS_sum >= 2)) begin
                valid1_out <= 1'b1;
                valid2_out <= 1'b1;
                RS_tag1 <= free_RS1;
                RS_tag2 <= free_RS2;
                ROB_tag1 <= free_ROB1;
                ROB_tag2 <= free_ROB2;
                RS_input1 <= {op1, ROB_tag1, PC1, ra1, rb1, v_ra1, v_rb1, spec_tag1, branch_predict1, {RegWrite1, b_ctrl1}, c1, v_c1, z1, v_z1, rc1, v_rc1, a_ctrl1, Imm2_1, ls_ctrl1, SEI1_1, SEI2_1, FU_bits1};
                RS_input2 <= {op2, ROB_tag2, PC2, ra2, rb2, v_ra2, v_rb2, spec_tag2, branch_predict2, {RegWrite2, b_ctrl2}, c2, v_c2, z2, v_z2, rc2, v_rc2, a_ctrl2, Imm2_2, ls_ctrl2, SEI1_2, SEI2_2, FU_bits2};
                ROB_input1 <= {PC1, RC1, {RegWrite1, CWrite1, ZWrite1}, spec_tag1};
                ROB_input2 <= {PC2, RC2, {RegWrite2, CWrite2, ZWrite2}, spec_tag2};
            end
            else begin
                stall <= 1'b1;
            end
        end
        else if (valid1 & !valid2) begin
            if (!RR_stall & (ROB_sum >= 1) & (RS_sum >= 1)) begin
                valid1_out <= 1'b1;
                valid2_out <= 1'b0;
                RS_tag1 <= free_RS1;
                ROB_tag1 <= free_ROB1;
                RS_input1 <= {op1, ROB_tag1, PC1, ra1, rb1, v_ra1, v_rb1, spec_tag1, branch_predict1, b_ctrl1, c1, v_c1, z1, v_z1, rc1, v_rc1, a_ctrl1, Imm2_1, ls_ctrl1, SEI1_1, SEI2_1, FU_bits1};
                ROB_input1 <= {PC1, RC1, {RegWrite1, CWrite1, ZWrite1}, spec_tag1};
            end
            else stall <= 1'b1;
        end
        else if (!valid1 & valid2) begin
            if (!RR_stall & (ROB_sum >= 1) & (RS_sum >= 1)) begin
                valid1_out <= 1'b0;
                valid2_out <= 1'b1;
                RS_tag2 <= free_RS1;
                ROB_tag2 <= free_ROB1;
                RS_input2 <= {op2, ROB_tag2, PC2, ra2, rb2, v_ra2, v_rb2, spec_tag2, branch_predict2, b_ctrl2, c2, v_c2, z2, v_z2, rc2, v_rc2, a_ctrl2, Imm2_2, ls_ctrl2, SEI1_2, SEI2_2, FU_bits2};
                ROB_input2 <= {PC2, RC2, {RegWrite2, CWrite2, ZWrite2}, spec_tag2};
            end
            else stall <= 1'b1;
        end
        else stall <= 1'b1;
    end
    
endmodule
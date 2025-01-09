`timescale 1ns / 1ps
module Register_File(
    input clk, rst,
    //Allocate Unit
    input [3:0] op1, op2,
    input [2:0] ROB_tag1, ROB_tag2,
    input RegWrite1, RegWrite2,
    input [2:0] RAA1, RAA2, RBB1, RBB2, RCC1, RCC2,
    input [1:0] FU_bits1, FU_bits2,
    input valid1, valid2,
    input [2:0] RAW, 
    input WAR, WAW,
    //From ROB===========================
    input [15:0] ROB_ra1, ROB_ra2, ROB_rb1, ROB_rb2, ROB_rc1, ROB_rc2,
    input [7:0] valid_ROB,
    //===================================
    //From Write back stage==============
    input wb1, wb2,// wb = 1 when RegWrite = 1 (R bit in ROB) and valid bit = 1 (in ROB)
    input [2:0] ROB1, ROB2,
    input [2:0] RD1, RD2,
    input [15:0] reg_data1, reg_data2,
    //===================================
    //Common Data Bus (CDB)============
    input valid_b_cdb, valid_a_cdb, valid_a2_cdb, valid_ls_cdb,
    input [15:0] reg_data_b, alu_out, alu2_out, dm_data,
    input [2:0] ROB_b_cdb, ROB_a_cdb, ROB_a2_cdb, ROB_ls_cdb,
    //=================================
    //To ROB===========================
    output [2:0] RA1_t, RA2_t, RB1_t, RB2_t, Rc1_t, RC2_t,
    //=================================
    output reg [15:0] ra1, ra2, rb1, rb2, rc1, rc2,
    output reg v_ra1, v_ra2, v_rb1, v_rb2, v_rc1, v_rc2,
    output [2:0] RDD1_out, RDD2_out);
    reg [19:0] ARF [7:0];//3 bits - RR tag, 16 bits - data, 1 bit - Valid
    integer i;
    reg [7:0] da;
    reg [2:0] Rd1, Rd2;
    wire [15:0] RA1, RA2, RB1, RB2, RC1, RC2;
    
    //Source Read (Priority: RAW bit(for 2nd instruction) -> valid bit in registers -> valid bit in CDB)
//    assign ra1 = (ARF[RA1][0])? ARF[RA1][16:1]: ((ARF[RA1][19:17] == ROB_b_cdb) & valid_b_cdb)? reg_data_b: 
//                                                ((ARF[RA1][19:17] == ROB_a_cdb) & valid_a_cdb)? alu_out: 
//                                                ((ARF[RA1][19:17] == ROB_a2_cdb) & valid_a2_cdb)? alu2_out: 
//                                                ((ARF[RA1][19:17] == ROB_ls_cdb) & valid_ls_cdb)? dm_data: {13'b0, ARF[RA1][19:17]};
//    assign ra2 = (RAW[0])? ROB_tag1: (ARF[RA2][0])? ARF[RA2][16:1]: ((ARF[RA2][19:17] == ROB_b_cdb) & valid_b_cdb)? reg_data_b: 
//                                                ((ARF[RA2][19:17] == ROB_a_cdb) & valid_a_cdb)? alu_out: 
//                                                ((ARF[RA2][19:17] == ROB_a2_cdb) & valid_a2_cdb)? alu2_out: 
//                                                ((ARF[RA2][19:17] == ROB_ls_cdb) & valid_ls_cdb)? dm_data: {13'b0, ARF[RA2][19:17]};
//    assign rb1 = (ARF[RB1][0])? ARF[RB1][16:1]: ((ARF[RB1][19:17] == ROB_b_cdb) & valid_b_cdb)? reg_data_b: 
//                                                ((ARF[RB1][19:17] == ROB_a_cdb) & valid_a_cdb)? alu_out: 
//                                                ((ARF[RB1][19:17] == ROB_a2_cdb) & valid_a2_cdb)? alu2_out: 
//                                                ((ARF[RB1][19:17] == ROB_ls_cdb) & valid_ls_cdb)? dm_data: {13'b0, ARF[RB1][19:17]};
//    assign rb2 = (RAW[1])? ROB_tag1: (ARF[RB2][0])? ARF[RB2][16:1]: ((ARF[RB2][19:17] == ROB_b_cdb) & valid_b_cdb)? reg_data_b: 
//                                                ((ARF[RB2][19:17] == ROB_a_cdb) & valid_a_cdb)? alu_out: 
//                                                ((ARF[RB2][19:17] == ROB_a2_cdb) & valid_a2_cdb)? alu2_out: 
//                                                ((ARF[RB2][19:17] == ROB_ls_cdb) & valid_ls_cdb)? dm_data: {13'b0, ARF[RB2][19:17]};
//    assign rc1 = (ARF[RC1][0])? ARF[RC1][16:1]: ((ARF[RC1][19:17] == ROB_b_cdb) & valid_b_cdb)? reg_data_b: 
//                                                ((ARF[RC1][19:17] == ROB_a_cdb) & valid_a_cdb)? alu_out: 
//                                                ((ARF[RC1][19:17] == ROB_a2_cdb) & valid_a2_cdb)? alu2_out: 
//                                                ((ARF[RC1][19:17] == ROB_ls_cdb) & valid_ls_cdb)? dm_data: {13'b0, ARF[RC1][19:17]};
//    assign rc2 = (RAW[2])? ROB_tag1: (ARF[RC2][0])? ARF[RC2][16:1]: ((ARF[RC2][19:17] == ROB_b_cdb) & valid_b_cdb)? reg_data_b: 
//                                                ((ARF[RC2][19:17] == ROB_a_cdb) & valid_a_cdb)? alu_out: 
//                                                ((ARF[RC2][19:17] == ROB_a2_cdb) & valid_a2_cdb)? alu2_out: 
//                                                ((ARF[RC2][19:17] == ROB_ls_cdb) & valid_ls_cdb)? dm_data: {13'b0, ARF[RC2][19:17]};
//    assign v_ra1 = ARF[RA1][0] | ((ARF[RA1][19:17] == ROB_b_cdb) & valid_b_cdb & !ARF[RA1][0]) 
//                               | ((ARF[RA1][19:17] == ROB_a_cdb) & valid_a_cdb & !ARF[RA1][0])
//                               | ((ARF[RA1][19:17] == ROB_a2_cdb) & valid_a2_cdb & !ARF[RA1][0])
//                               | ((ARF[RA1][19:17] == ROB_ls_cdb) & valid_ls_cdb & !ARF[RA1][0]);
//    assign v_ra2 = (!RAW[0] & ARF[RA2][0]) | ((ARF[RA2][19:17] == ROB_b_cdb) & valid_b_cdb & !ARF[RA2][0]) 
//                               | ((ARF[RA2][19:17] == ROB_a_cdb) & valid_a_cdb & !ARF[RA2][0])
//                               | ((ARF[RA2][19:17] == ROB_a2_cdb) & valid_a2_cdb & !ARF[RA2][0])
//                               | ((ARF[RA2][19:17] == ROB_ls_cdb) & valid_ls_cdb & !ARF[RA2][0]);
//    assign v_rb1 = ARF[RB1][0] | ((ARF[RB1][19:17] == ROB_b_cdb) & valid_b_cdb & !ARF[RB1][0]) 
//                               | ((ARF[RB1][19:17] == ROB_a_cdb) & valid_a_cdb & !ARF[RB1][0])
//                               | ((ARF[RB1][19:17] == ROB_a2_cdb) & valid_a2_cdb & !ARF[RB1][0])
//                               | ((ARF[RB1][19:17] == ROB_ls_cdb) & valid_ls_cdb & !ARF[RB1][0]);
//    assign v_rb2 = (!RAW[1] & ARF[RB2][0]) | ((ARF[RB2][19:17] == ROB_b_cdb) & valid_b_cdb & !ARF[RB2][0]) 
//                               | ((ARF[RB2][19:17] == ROB_a_cdb) & valid_a_cdb & !ARF[RB2][0])
//                               | ((ARF[RB2][19:17] == ROB_a2_cdb) & valid_a2_cdb & !ARF[RB2][0])
//                               | ((ARF[RB2][19:17] == ROB_ls_cdb) & valid_ls_cdb & !ARF[RB2][0]);
//    assign v_rc1 = ARF[RC1][0] | ((ARF[RC1][19:17] == ROB_b_cdb) & valid_b_cdb & !ARF[RC1][0]) 
//                               | ((ARF[RC1][19:17] == ROB_a_cdb) & valid_a_cdb & !ARF[RC1][0])
//                               | ((ARF[RC1][19:17] == ROB_a2_cdb) & valid_a2_cdb & !ARF[RC1][0])
//                               | ((ARF[RC1][19:17] == ROB_ls_cdb) & valid_ls_cdb & !ARF[RC1][0]);
//    assign v_rc2 = (!RAW[2] & ARF[RC2][0]) | ((ARF[RC2][19:17] == ROB_b_cdb) & valid_b_cdb & !ARF[RC2][0]) 
//                               | ((ARF[RC2][19:17] == ROB_a_cdb) & valid_a_cdb & !ARF[RC2][0])
//                               | ((ARF[RC2][19:17] == ROB_a2_cdb) & valid_a2_cdb & !ARF[RC2][0])
//                               | ((ARF[RC2][19:17] == ROB_ls_cdb) & valid_ls_cdb & !ARF[RC2][0]);
    assign {RA1_t, RA2_t, RB1_t, RB2_t, Rc1_t, RC2_t} = {ARF[RA1][19:17], ARF[RA2][19:17], ARF[RB1][19:17], ARF[RB2][19:17], ARF[RC1][19:17], ARF[RC2][19:17]};
    always @ (*) begin
        if (!ARF[RA1][0]) begin
            if (valid_ROB[ARF[RA1][19:17]]) begin
                ra1 <= ROB_ra1;
                v_ra1 <= 1'b1;
            end
            else begin
                ra1 <= {13'b0, ARF[RA1][19:17]};
                v_ra1 <= 1'b0;
            end
        end
        else begin
            ra1 <= ARF[RA1][16:1];
            v_ra1 <= 1'b1;
        end
    end
    always @ (*) begin
        if (RAW[0]) begin
            ra2 <= {13'b0, ROB_tag1};
            v_ra2 <= 1'b0;
        end
        else begin
            if (!ARF[RA2][0]) begin
                if (valid_ROB[ARF[RA2][19:17]]) begin
                    ra2 <= ROB_ra2;
                    v_ra2 <= 1'b1;
                end
                else begin
                    ra2 <= {13'b0, ARF[RA2][19:17]};
                    v_ra2 <= 1'b0;
                end
            end
            else begin
                ra2 <= ARF[RA2][16:1];
                v_ra2 <= 1'b1;
            end
        end
    end
    always @ (*) begin
        if (!ARF[RB1][0]) begin
            if (valid_ROB[ARF[RB1][19:17]]) begin
                rb1 <= ROB_rb1;
                v_rb1 <= 1'b1;
            end
            else begin
                rb1 <= {13'b0, ARF[RB1][19:17]};
                v_rb1 <= 1'b0;
            end
        end
        else begin
            rb1 <= ARF[RB1][16:1];
            v_rb1 <= 1'b1;
        end
    end
    always @ (*) begin
        if (RAW[1]) begin
            rb2 <= {13'b0, ROB_tag1};
            v_rb2 <= 1'b0;
        end
        else begin
            if (!ARF[RB2][0]) begin
                if (valid_ROB[ARF[RB2][19:17]]) begin
                    rb2 <= ROB_rb2;
                    v_rb2 <= 1'b1;
                end
                else begin
                    rb2 <= {13'b0, ARF[RB2][19:17]};
                    v_rb2 <= 1'b0;
                end
            end
            else begin
                rb2 <= ARF[RB2][16:1];
                v_rb2 <= 1'b1;
            end
        end
    end
    always @ (*) begin
        if (!ARF[RC1][0]) begin
            if (valid_ROB[ARF[RC1][19:17]]) begin
                rc1 <= ROB_rc1;
                v_rc1 <= 1'b1;
            end
            else begin
                rc1 <= {13'b0, ARF[RC1][19:17]};
                v_rc1 <= 1'b0;
            end
        end
        else begin
            rc1 <= ARF[RC1][16:1];
            v_rc1 <= 1'b1;
        end
    end
    always @ (*) begin
        if (RAW[2]) begin
            rc2 <= {13'b0, ROB_tag1};
            v_rc2 <= 1'b0;
        end
        else begin
            if (!ARF[RC2][0]) begin
                if (valid_ROB[ARF[RC2][19:17]]) begin
                    rc2 <= ROB_rc1;
                    v_rc2 <= 1'b1;
                end
                else begin
                    rc2 <= {13'b0, ARF[RC2][19:17]};
                    v_rc2 <= 1'b0;
                end
            end
            else begin
                rc2 <= ARF[RC2][16:1];
                v_rc2 <= 1'b1;
            end
        end
    end
    
    assign RA1 = RAA1;
    assign RA2 = RAA2;
    assign RB1 = RBB1;
    assign RB2 = RBB2;
    assign RC1 = RCC1;
    assign RC2 = RCC2;
    assign RDD1_out = Rd1;
    assign RDD2_out = Rd2;
    //Change RC to Rd
    always @ (*) begin
        case (op1)
            4'b1101, 4'b0011, 4'b1100, 4'b0100: Rd1 <= RAA1;
            4'b0000: Rd1 <= RBB1;
            4'b0001, 4'b0010: Rd1 <= RCC1;
            default: Rd1 <= RCC1;
        endcase
    end
    always @ (*) begin
        case (op2)
            4'b1101, 4'b0011, 4'b1100, 4'b0100: Rd2 <= RAA2;
            4'b0000: Rd2 <= RBB2;
            4'b0001, 4'b0010: Rd2 <= RCC2;
            default: Rd2 <= RCC2;
        endcase
    end
    reg [7:0] rw1, rw2, WB1, WB2;
    wire [7:0] rw, WB;
    always @ (*) begin
        if (valid1 & RegWrite1) begin
            case (Rd1)
                3'b000: rw1 <= 8'b00000001;
                3'b001: rw1 <= 8'b00000010;
                3'b010: rw1 <= 8'b00000100;
                3'b011: rw1 <= 8'b00001000;
                3'b100: rw1 <= 8'b00010000;
                3'b101: rw1 <= 8'b00100000;
                3'b110: rw1 <= 8'b01000000;
                3'b111: rw1 <= 8'b10000000;
                default: rw1 <= 8'b00000000;
            endcase
        end
        else rw1 <= 8'b00000000;
    end
    always @ (*) begin
        if (valid2 & RegWrite2) begin
            case (Rd2)
                3'b000: rw2 <= 8'b00000001;
                3'b001: rw2 <= 8'b00000010;
                3'b010: rw2 <= 8'b00000100;
                3'b011: rw2 <= 8'b00001000;
                3'b100: rw2 <= 8'b00010000;
                3'b101: rw2 <= 8'b00100000;
                3'b110: rw2 <= 8'b01000000;
                3'b111: rw2 <= 8'b10000000;
                default: rw2 <= 8'b00000000;
            endcase
        end
        else rw2 <= 8'b00000000;
    end
    always @ (*) begin
        if (wb1) begin
            case (RD1)
                3'b000: WB1 <= 8'b00000001;
                3'b001: WB1 <= 8'b00000010;
                3'b010: WB1 <= 8'b00000100;
                3'b011: WB1 <= 8'b00001000;
                3'b100: WB1 <= 8'b00010000;
                3'b101: WB1 <= 8'b00100000;
                3'b110: WB1 <= 8'b01000000;
                3'b111: WB1 <= 8'b10000000;
                default: WB1 <= 8'b00000000;
            endcase
        end
        else WB1 <= 8'b00000000;
    end
    always @ (*) begin
        if (wb2) begin
            case (RD2)
                3'b000: WB2 <= 8'b00000001;
                3'b001: WB2 <= 8'b00000010;
                3'b010: WB2 <= 8'b00000100;
                3'b011: WB2 <= 8'b00001000;
                3'b100: WB2 <= 8'b00010000;
                3'b101: WB2 <= 8'b00100000;
                3'b110: WB2 <= 8'b01000000;
                3'b111: WB2 <= 8'b10000000;
                default: WB2 <= 8'b00000000;
            endcase
        end
        else WB2 <= 8'b00000000;
    end
    assign rw = rw1 | rw2;
    assign WB = WB1 | WB2;
    always @ (posedge clk) begin
        if (rst) da <= 8'd0;
        else begin
            da[0] <= (~rw[0] & ~WB[0] & da[0]) | rw[0];
            da[1] <= (~rw[1] & ~WB[1] & da[1]) | rw[1];
            da[2] <= (~rw[2] & ~WB[2] & da[2]) | rw[2];
            da[3] <= (~rw[3] & ~WB[3] & da[3]) | rw[3];
            da[4] <= (~rw[4] & ~WB[4] & da[4]) | rw[4];
            da[5] <= (~rw[5] & ~WB[5] & da[5]) | rw[5];
            da[6] <= (~rw[6] & ~WB[6] & da[6]) | rw[6];
            da[7] <= (~rw[7] & ~WB[7] & da[7]) | rw[7];
        end
    end
//    always @ (posedge clk) begin
//        if (rst) da <= 8'd0;
//        else begin
//            if (valid1 & valid2) begin
//                if (RegWrite1 & RegWrite2) 
//                    if (WAW) da[Rd1] <= 1'b1;
//                    else {da[Rd1], da[Rd2]} <= 2'b11;
//                else if (RegWrite1 & !RegWrite2) da[Rd1] <= 1'b1;
//                else if (!RegWrite1 & RegWrite2) da[Rd2] <= 1'b1;
//                else ;
//            end
//            else if (valid1 & RegWrite1 & !valid2) da[Rd1] <= 1'b1;
//            else if (!valid1 & valid2 & RegWrite2) da[Rd2] <= 1'b1;
//            else begin
//            end
//        end
//    end
    
    //Destination Allocate
    reg [7:0] next_valid;
    always @ (*) begin
        next_valid <= ~(rw) & ((WB) | {ARF[7][0], ARF[6][0], ARF[5][0], ARF[4][0], ARF[3][0], ARF[2][0], ARF[1][0], ARF[0][0]});
    end
    always @ (posedge clk) begin
        if (rst) begin
            ARF[0] <= 20'd1;
            ARF[1] <= 20'd1;
            ARF[2] <= 20'd1;
            ARF[3] <= 20'd1;
            ARF[4] <= 20'd1;
            ARF[5] <= 20'd1;
            ARF[6] <= 20'd1;
            ARF[7] <= 20'd1;
        end
        else begin
            {ARF[7][0], ARF[6][0], ARF[5][0], ARF[4][0], ARF[3][0], ARF[2][0], ARF[1][0], ARF[0][0]} <= next_valid;
            //Destnation Allocate
            if (valid1 & valid2) begin
                if (RegWrite1 & RegWrite2) begin
                    if (WAW) begin
                         ARF[Rd1][19:17] <= ROB_tag2;
                    end
                    else begin
                        ARF[Rd1][19:17] <= ROB_tag1;
                        ARF[Rd2][19:17] <= ROB_tag2;
                    end
                end
                else if (RegWrite1 & !RegWrite2) begin
                    ARF[Rd1][19:17] <= ROB_tag1;
                end
                else if (!RegWrite1 & RegWrite2) begin
                    ARF[Rd2][19:17] <= ROB_tag2;
                end
                else begin
                end
            end
            else if (valid1 & RegWrite1 & !valid2) begin
                ARF[Rd1][19:17] <= ROB_tag1;
            end
            else if (!valid1 & valid2 & RegWrite2) begin
                ARF[Rd2][19:17] <= ROB_tag2;
            end
            else begin
            end
            
            //Write Back
            if (wb1 & wb2) begin
                if (RD1 == RD2) begin
                    ARF[RD2][16:1]<= reg_data2;
                end
                else begin
                    ARF[RD1][16:1]<= reg_data1;
                    ARF[RD2][16:1]<= reg_data2;
                end
            end
            else if (wb1 & !wb2) begin
                ARF[RD1][16:1]<= reg_data1;
            end
            else if (!wb1 & wb2) begin
                ARF[RD2][16:1]<= reg_data2;
            end
            else begin
            end
        end
    end
//    //Free Rename registers
//    wire [3:0] sub_busy_bits;
//    wire [3:0] RR_busy_bits = {RRF[3][1], RRF[2][1], RRF[1][1], RRF[0][1]};
//    wire [1:0] free_RR1 = (!RRF[0][1])? 2'd0:
//                          (!RRF[1][1])? 2'd1:
//                          (!RRF[2][1])? 2'd2:
//                          (!RRF[3][1])? 2'd3: 2'd0;
//    wire [1:0] free_RR2 = (!sub_busy_bits[0])? 2'd0:
//                          (!sub_busy_bits[1])? 2'd1:
//                          (!sub_busy_bits[2])? 2'd2:
//                          (!sub_busy_bits[3])? 2'd3: 2'd0;
//    assign sub_busy_bits = RR_busy_bits & ~(1 << free_RR1);
    
//    //Sum of Valid ARF Values
//    wire [3:0] Valid_sum = ARF[0][2] + ARF[1][2] + ARF[2][2] + ARF[3][2] + ARF[4][2] + ARF[5][2] + ARF[6][2] + ARF[7][2];
    
//    //Destination Allocate bits indication bits to overrule the write back stage
//    reg [3:0] da_bits;
    
//    //Logic for Destination allocate bits
//    always @ (*) begin
//        if (rst) begin
//            da_bits <= 4'd0;
//        end
//        else begin
//            if (!RR_stall) begin
//                if (valid1 & valid2) begin
//                    if (RegWrite1 & RegWrite2) begin
//                        if (WAW) begin
//                            if (ARF[RC1][2]) begin
//                                da_bits[free_RR1] <= 1'b1;
//                            end
//                            else begin
//                                da_bits[ARF[RC1][1:0]] <= 1'b1;
//                            end
//                        end
//                        else begin
//                            if (ARF[RC1][2]) begin
//                                da_bits[free_RR1] <= 1'b1;
//                            end
//                            else begin
//                                da_bits[ARF[RC1][1:0]] <= 1'b1;
//                            end
//                            if (ARF[RC2][2]) begin
//                                da_bits[free_RR2] <= 1'b1;
//                            end
//                            else begin
//                                da_bits[ARF[RC2][1:0]] <= 1'b1;
//                            end
//                        end
//                    end
//                    else if (RegWrite1 & !RegWrite2) begin
//                        if (ARF[RC1][2]) begin
//                            da_bits[free_RR1] <= 1'b1;
//                        end
//                        else begin
//                            da_bits[ARF[RC1][1:0]] <= 1'b1;
//                        end
//                    end
//                    else if (!RegWrite1 & RegWrite2) begin
//                        if (ARF[RC2][2]) begin
//                            da_bits[free_RR1] <= 1'b1;
//                        end
//                        else begin
//                            da_bits[ARF[RC2][1:0]] <= 1'b1;
//                        end
//                    end
//                    else begin
//                    end
//                end
//                else if (valid1 & !valid2) begin
//                    if (RegWrite1) begin
//                        if (ARF[RC1][2]) begin
//                            da_bits[free_RR1] <= 1'b1;
//                        end
//                        else begin
//                            da_bits[ARF[RC1][1:0]] <= 1'b1;
//                        end
//                    end
//                    else begin
//                    end
//                end
//                else if (!valid1 & valid2) begin
//                    if (RegWrite2) begin
//                        if (ARF[RC2][2]) begin
//                            da_bits[free_RR1] <= 1'b1;
//                        end
//                        else begin
//                            da_bits[ARF[RC2][1:0]] <= 1'b1;
//                        end
//                    end
//                    else begin
//                    end
//                end
//                else begin
//                end
//            end
//            else begin
//            end
//        end
//    end
    
//    //Logic for Stall signal
//    always @ (*) begin
//        if (rst) RR_stall <= 1'b0;
//        else begin
//            if ((RegWrite1 & valid1) & (RegWrite2 & valid2)) begin
//                case ({ARF[RC1][2], ARF[RC2][2]})
//                    2'b00: RR_stall <= 1'b0;
//                    2'b01, 2'b10: begin
//                        if (Valid_sum > 4'd4) RR_stall <= 1'b0;
//                        else RR_stall <= 1'b1;
//                    end
//                    2'b11: begin
//                        if (Valid_sum > 4'd5) RR_stall <= 1'b0;
//                        else RR_stall <= 1'b1;
//                    end
//                    default: RR_stall <= 1'b0;
//                endcase
//            end
//            else if ((RegWrite1 & valid1) & !valid2) begin
//                if (ARF[RC1][2] && (Valid_sum > 4'd4)) RR_stall <= 1'b0;
//                else RR_stall <= 1'b1;
//            end
//            else if (!valid1 & (RegWrite2 & valid2)) begin
//                if (ARF[RC2][2] && (Valid_sum > 4'd4)) RR_stall <= 1'b0;
//                else RR_stall <= 1'b1;
//            end
//            else begin
//            end
//        end
//    end
    
//    //Logic to manage allocation, forward and writeback the data values
//    always @ (posedge clk) begin
//        if (rst) begin
//            ARF[0] <= 19'd4;
//            ARF[1] <= 19'd4;
//            ARF[2] <= 19'd4;
//            ARF[3] <= 19'd4;
//            ARF[4] <= 19'd4;
//            ARF[5] <= 19'd4;
//            ARF[6] <= 19'd4;
//            ARF[7] <= 19'd4;
//            RRF[0] <= 19'd0;
//            RRF[1] <= 19'd0;
//            RRF[2] <= 19'd0;
//            RRF[3] <= 19'd0;
//        end
//        else begin
//            //Destination Allocate
//            if (!RR_stall) begin
//                if (valid1 & valid2) begin
//                    if (RegWrite1 & RegWrite2) begin
//                        if (WAW) begin
//                            if (ARF[RC1][2]) begin
//                                ARF[RC1][2] <= 1'b0;
//                                ARF[RC1][1:0] <= free_RR1;
//                                RRF[free_RR1][1:0] <= 2'b10;
//                                RRF[free_RR1][17:2] <= {13'd0, RS_tag2};
//                            end
//                            else begin
//                                RRF[ARF[RC1][1:0]][17:2] <= {13'd0, RS_tag2};
//                            end
//                        end
//                        else begin
//                            if (ARF[RC1][2]) begin
//                                ARF[RC1][2] <= 1'b0;
//                                ARF[RC1][1:0] <= free_RR1;
//                                RRF[free_RR1][1:0] <= 2'b10;
//                                RRF[free_RR1][17:2] <= {13'd0, RS_tag1};
//                            end
//                            else begin
//                                RRF[ARF[RC1][1:0]][17:2] <= {13'd0, RS_tag1};
//                            end
//                            if (ARF[RC2][2]) begin
//                                ARF[RC2][2] <= 1'b0;
//                                ARF[RC2][1:0] <= free_RR2;
//                                RRF[free_RR2][1:0] <= 2'b10;
//                                RRF[free_RR2][17:2] <= {13'd0, RS_tag2};
//                            end
//                            else begin
//                                RRF[ARF[RC2][1:0]][17:2] <= {13'd0, RS_tag2};
//                            end
//                        end
//                    end
//                    else if (RegWrite1 & !RegWrite2) begin
//                        if (ARF[RC1][2]) begin
//                            ARF[RC1][2] <= 1'b0;
//                            ARF[RC1][1:0] <= free_RR1;
//                            RRF[free_RR1][1:0] <= 2'b10;
//                            RRF[free_RR1][17:2] <= {13'd0, RS_tag1};
//                        end
//                        else begin
//                            RRF[ARF[RC1][1:0]][17:2] <= {13'd0, RS_tag1};
//                        end
//                    end
//                    else if (!RegWrite1 & RegWrite2) begin
//                        if (ARF[RC2][2]) begin
//                            ARF[RC2][2] <= 1'b0;
//                            ARF[RC2][1:0] <= free_RR1;
//                            RRF[free_RR1][1:0] <= 2'b10;
//                            RRF[free_RR1][17:2] <= {13'd0, RS_tag2};
//                        end
//                        else begin
//                            RRF[ARF[RC2][1:0]][17:2] <= {13'd0, RS_tag2};
//                        end
//                    end
//                    else begin
//                    end
//                end
//                else if (valid1 & !valid2) begin
//                    if (RegWrite1) begin
//                        if (ARF[RC1][2]) begin
//                            ARF[RC1][2] <= 1'b0;
//                            ARF[RC1][1:0] <= free_RR1;
//                            RRF[free_RR1][1:0] <= 2'b10;
//                            RRF[free_RR1][17:2] <= {13'd0, RS_tag1};
//                        end
//                        else begin
//                            RRF[ARF[RC1][1:0]][17:2] <= {13'd0, RS_tag1};
//                        end
//                    end
//                    else begin
//                    end
//                end
//                else if (!valid1 & valid2) begin
//                    if (RegWrite2) begin
//                        if (ARF[RC2][2]) begin
//                            ARF[RC2][2] <= 1'b0;
//                            ARF[RC2][1:0] <= free_RR1;
//                            RRF[free_RR1][1:0] <= 2'b10;
//                            RRF[free_RR1][17:2] <= {13'd0, RS_tag2};
//                        end
//                        else begin
//                            RRF[ARF[RC2][1:0]][17:2] <= {13'd0, RS_tag2};
//                        end
//                    end
//                    else begin
//                    end
//                end
//                else begin
//                end
//            end
//            else begin
//            end
//            //Write Back
//            if (wb)
//            //Finish
//        end
//    end
    
//    //Logic for Source data Reading
//    always @ (*) begin
//        //Source Read
//        //RA1
//        if (ARF[RA1][2]) begin
//            ra1 <= ARF[RA1][18:3];
//            v_ra1 <= 1'b1;
//        end
//        else begin
//            if (RRF[ARF[RA1][1:0]][0]) begin
//                ra1 <= RRF[ARF[RA1][1:0]][18:3];
//                v_ra1 <= 1'b1;
//            end
//            else begin
//                ra1 <= RRF[ARF[RA1][1:0]][18:3];
//                v_ra1 <= 1'b0;
//            end
//        end
//        //RA2
//        if (ARF[RA2][2]) begin
//            ra2 <= ARF[RA2][18:3];
//            v_ra2 <= 1'b1;
//        end
//        else begin
//            if (RRF[ARF[RA2][1:0]][0]) begin
//                ra2 <= RRF[ARF[RA2][1:0]][18:3];
//                v_ra2 <= 1'b1;
//            end
//            else begin
//                ra2 <= RRF[ARF[RA2][1:0]][18:3];
//                v_ra2 <= 1'b0;
//            end
//        end
//        //RB1
//        if (ARF[RB1][2]) begin
//            rb1 <= ARF[RB1][18:3];
//            v_rb1 <= 1'b1;
//        end
//        else begin
//            if (RRF[ARF[RB1][1:0]][0]) begin
//                rb1 <= RRF[ARF[RB1][1:0]][18:3];
//                v_rb1 <= 1'b1;
//            end
//            else begin
//                rb1 <= RRF[ARF[RB1][1:0]][18:3];
//                v_rb1 <= 1'b0;
//            end
//        end
//        //RB2
//        if (ARF[RB2][2]) begin
//            rb2 <= ARF[RB2][18:3];
//            v_rb2 <= 1'b1;
//        end
//        else begin
//            if (RRF[ARF[RB2][1:0]][0]) begin
//                rb2 <= RRF[ARF[RB2][1:0]][18:3];
//                v_rb2 <= 1'b1;
//            end
//            else begin
//                rb2 <= RRF[ARF[RB2][1:0]][18:3];
//                v_rb2 <= 1'b0;
//            end
//        end
//        //RC1
//        if (ARF[RC1][2]) begin
//            rc1 <= ARF[RC1][18:3];
//            v_rc1 <= 1'b1;
//        end
//        else begin
//            if (RRF[ARF[RC1][1:0]][0]) begin
//                rc1 <= RRF[ARF[RC1][1:0]][18:3];
//                v_rc1 <= 1'b1;
//            end
//            else begin
//                rc1 <= RRF[ARF[RC1][1:0]][18:3];
//                v_rc1 <= 1'b0;
//            end
//        end
//        //RC2
//        if (ARF[RC2][2]) begin
//            rc2 <= ARF[RC2][18:3];
//            v_rc2 <= 1'b1;
//        end
//        else begin
//            if (RRF[ARF[RC2][1:0]][0]) begin
//                rc2 <= RRF[ARF[RC2][1:0]][18:3];
//                v_rc2 <= 1'b1;
//            end
//            else begin
//                rc2 <= RRF[ARF[RC2][1:0]][18:3];
//                v_rc2 <= 1'b0;
//            end
//        end
//    end
    
endmodule

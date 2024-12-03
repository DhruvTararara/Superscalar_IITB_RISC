module Register_File(
    input clk, rst,
    //Allocate Unit
    input [2:0] ROB_tag1, ROB_tag2,
    input RegWrite1, RegWrite2,
    input [2:0] RAA1, RAA2, RBB1, RBB2, RCC1, RCC2,
    input [1:0] FU_bits1, FU_bits2,
    input valid1, valid2,
    input [2:0] RAW, 
    input WAR, WAW,
    //From Write back stage==============
    input wb1, wb2,// wb = 1 when RegWrite = 1 (R bit in ROB) and valid bit = 1 (in ROB)
    input ROB1, ROB2,
    input [2:0] RD1, RD2,
    input [15:0] reg_data1, reg_data2,
    //===================================
    output [15:0] ra1, ra2, rb1, rb2, rc1, rc2,
    output v_ra1, v_ra2, v_rb1, v_rb2, v_rc1, v_rc2);
    reg [19:0] ARF [7:0];//3 bits - RR tag, 16 bits - data, 1 bit - Valid
    integer i;
    reg [7:0] da;
    wire [15:0] RA1, RA2, RB1, RB2, RC1, RC2;
    assign RA1 = RAA1;
    assign RA2 = RAA2;
    assign RB1 = RBB1;
    assign RB2 = RBB2;
    assign RC1 = RCC1;
    assign RC2 = RCC2;
    always @ (posedge clk) begin
        if (rst) da <= 8'd0;
        else begin
            if (valid1 & valid2) begin
                if (RegWrite1 & RegWrite2) 
                    if (WAW) da[RC1] <= 1'b1;
                    else {da[RC1], da[RC2]} <= 2'b11;
                else if (RegWrite1 & !RegWrite2) da[RC1] <= 1'b1;
                else if (!RegWrite1 & RegWrite2) da[RC2] <= 1'b1;
                else ;
            end
            else if (valid1 & RegWrite1 & !valid2) da[RC1] <= 1'b1;
            else if (!valid1 & valid2 & RegWrite2) da[RC2] <= 1'b1;
            else begin
            end
        end
    end
    
    //Source Read
    assign ra1 = (ARF[RA1][0])? ARF[RA1][16:1]: {13'b0, ARF[RA1][19:17]};
    assign ra2 = (ARF[RA2][0])? ARF[RA2][16:1]: (RAW[0])? ROB_tag1: {13'b0, ARF[RA2][19:17]};
    assign rb1 = (ARF[RB1][0])? ARF[RB1][16:1]: {13'b0, ARF[RB1][19:17]};
    assign rb2 = (ARF[RB2][0])? ARF[RB2][16:1]: (RAW[1])? ROB_tag1: {13'b0, ARF[RB2][19:17]};
    assign rc1 = (ARF[RC1][0])? ARF[RC1][16:1]: {13'b0, ARF[RC1][19:17]};
    assign rc2 = (ARF[RC2][0])? ARF[RC2][16:1]: (RAW[2])? ROB_tag1: {13'b0, ARF[RC2][19:17]};
    assign v_ra1 = ARF[RA1][0];
    assign v_ra2 = ARF[RA2][0];
    assign v_rb1 = ARF[RB1][0];
    assign v_rb2 = ARF[RB2][0];
    assign v_rc1 = ARF[RC1][0];
    assign v_rc2 = ARF[RC2][0];
    
    //Destination Allocate
    always @ (posedge clk) begin
        if (rst) begin
            ARF[0] <= 20'd0;
            ARF[1] <= 20'd0;
            ARF[2] <= 20'd0;
            ARF[3] <= 20'd0;
            ARF[4] <= 20'd0;
            ARF[5] <= 20'd0;
            ARF[6] <= 20'd0;
            ARF[7] <= 20'd0;
        end
        else begin
            //Destnation Allocate
            if (valid1 & valid2) begin
                if (RegWrite1 & RegWrite2) begin
                    if (WAW) begin
                         ARF[RC1][0] <= 1'b0;
                         ARF[RC1][19:17] <= ROB_tag2;
                    end
                    else begin
                        ARF[RC1][0] <= 1'b0;
                        ARF[RC2][0] <= 1'b0;
                        ARF[RC1][19:17] <= ROB_tag1;
                        ARF[RC2][19:17] <= ROB_tag2;
                    end
                end
                else if (RegWrite1 & !RegWrite2) begin
                    ARF[RC1][0] <= 1'b0;
                    ARF[RC1][19:17] <= ROB_tag1;
                end
                else if (!RegWrite1 & RegWrite2) begin
                    ARF[RC2][0] <= 1'b0;
                    ARF[RC2][19:17] <= ROB_tag2;
                end
                else begin
                end
            end
            else if (valid1 & RegWrite1 & !valid2) begin
                ARF[RC1][0] <= 1'b0;
                ARF[RC1][19:17] <= ROB_tag1;
            end
            else if (!valid1 & valid2 & RegWrite2) begin
                ARF[RC2][0] <= 1'b0;
                ARF[RC2][19:17] <= ROB_tag2;
            end
            else begin
            end
            
            //Write Back
            if (wb1 & wb2) begin
                if (RD1 == RD2) begin
                    if (!da[RD1]) begin
                        if (ARF[RD1][19:17] == ROB2) ARF[RD1][16:0]<= {reg_data2, 1'b1};
                    end
                    else begin
                        if (ARF[RD1][19:17] == ROB2) ARF[RD2][16:1]<= reg_data2;
                    end
                end
                else begin
                    if (!da[RD1]) begin if (ARF[RD1][19:17] == ROB1) ARF[RD1][16:0]<= {reg_data1, 1'b1}; end
                    else begin if (ARF[RD1][19:17] == ROB1) ARF[RD1][16:1]<= reg_data1; end
                    if (!da[RD2]) begin if (ARF[RD2][19:17] == ROB2) ARF[RD2][16:0]<= {reg_data2, 1'b1}; end
                    else begin if (ARF[RD2][19:17] == ROB2) ARF[RD2][16:1]<= reg_data2; end
                end
            end
            else if (wb1 & !wb2) begin
                if (!da[RD1]) begin if (ARF[RD1][19:17] == ROB1) ARF[RD1][16:0]<= {reg_data1, 1'b1}; end
                else begin if (ARF[RD1][19:17] == ROB1) ARF[RD1][16:1]<= reg_data1; end
            end
            else if (!wb1 & wb2) begin
                if (!da[RD2]) begin if (ARF[RD2][19:17] == ROB2) ARF[RD2][16:0]<= {reg_data2, 1'b1}; end
                else begin if (ARF[RD2][19:17] == ROB2) ARF[RD2][16:1]<= reg_data2; end
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

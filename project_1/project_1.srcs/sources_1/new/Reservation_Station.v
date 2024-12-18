`timescale 1ns / 1ps
module Reservation_Station(
    input clk, rst,
    input [136:0] RS_input1, RS_input2,
    input valid1, valid2,
    input [2:0] RS_tag1, RS_tag2,
    output reg [7:0] Busy,
    //From issue unit==================
    input [2:0] issue_RS_b, issue_RS_a, issue_RS_a2, issue_RS_ls,
    input valid_issue_b, valid_issue_a, valid_issue_a2, valid_issue_ls,
    //=================================
    //Common Data Bus (CDB)============
    input valid_b_cdb, valid_a_cdb, valid_a2_cdb, valid_ls_cdb,
    input [15:0] reg_data_b, alu_out, alu2_out, dm_data,
    input [2:0] ROB_b_cdb, ROB_a_cdb, ROB_a2_cdb, ROB_ls_cdb,
    //=================================
    //To issue Unit====================
    output [2:0] FU_bits0, FU_bits1, FU_bits2, FU_bits3, FU_bits4, FU_bits5, FU_bits6, FU_bits7,
    output [15:0] PC0, PC1, PC2, PC3, PC4, PC5, PC6, PC7,
    output reg [7:0] Ready,
    //=================================
    //To Branch Unit===================
    output [3:0] op_b,//97 bits
    output [2:0] ROB_tag_b,
    output [15:0] PC_b, ra_b, rb_b,
    output v_ra_b, v_rb_b,
    output [15:0] SEI1_b, SEI2_b,
    output [1:0] spec_tag_b,
    output b_p_b,
    output [3:0] b_ctrl_b,
    output valid_b,
    //=================================
    //To ALU===========================
    output [2:0] ROB_tag_a,//99 bits
    output [15:0] PC_a, ra_a, rb_a, rc_a,
    output c_a, z_a,
    output v_ra_a, v_rb_a, v_rc_a, v_c_a, v_z_a,
    output [1:0] spec_tag_a,
    output [5:0] a_ctrl_a,
    output [15:0] SEI1_a,
    output valid_a,
    //==================================
    //To ALU2===========================
    output [2:0] ROB_tag_a2,//99 bits
    output [15:0] PC_a2, ra_a2, rb_a2, rc_a2,
    output c_a2, z_a2,
    output v_ra_a2, v_rb_a2, v_rc_a2, v_c_a2, v_z_a2,
    output [1:0] spec_tag_a2,
    output [5:0] a_ctrl_a2,
    output [15:0] SEI1_a2,
    output valid_a2,
    //==================================
    //Load-Store Unit===================
    output [2:0] ROB_tag_l,//100 bits
    output [15:0] PC_l, ra_l, rb_l,
    output v_ra_l, v_rb_l,
    output [8:0] Imm2_l,
    output [15:0] SEI1_l, SEI2_l,
    output [1:0] spec_tag_l,
    output [2:0] ls_ctrl_l,
    output valid_l
    //==================================
    );
    //RS Entry
    reg [3:0] op [7:0];
    reg [2:0] ROB_tag [7:0];
    reg [15:0] PC [7:0];
    reg [15:0] ra [7:0];
    reg [15:0] rb [7:0];
    reg [15:0] rc [7:0];
    reg v_ra [7:0];
    reg v_rb [7:0];
    reg v_rc [7:0];
    reg [1:0] spec_tag [7:0];
    reg b_p [7:0];
    reg [3:0] b_ctrl [7:0];
    reg [5:0] a_ctrl [7:0];
    reg [2:0] ls_ctrl [7:0];
    reg c [7:0];
    reg v_c [7:0];
    reg z [7:0];
    reg v_z [7:0];
    reg [8:0] Imm2 [7:0];
    reg [15:0] SEI1 [7:0];
    reg [15:0] SEI2 [7:0];
    reg [2:0] FU_bits [7:0];//LAB
    reg [7:0] valid;//1 if a valid dispatched instruction is researved
    //To Issue Unit
    assign {FU_bits0, FU_bits1, FU_bits2, FU_bits3, FU_bits4, FU_bits5, FU_bits6, FU_bits7} = {FU_bits[0], FU_bits[1], FU_bits[2], FU_bits[3], FU_bits[4], FU_bits[5], FU_bits[6], FU_bits[7]};
    assign {PC0, PC1, PC2, PC3, PC4, PC5, PC6, PC7} = {PC[0], PC[1], PC[2], PC[3], PC[4], PC[5], PC[6], PC[7]};
    //Instruction Issue
    assign {op_b, ROB_tag_b, PC_b, ra_b, rb_b, v_ra_b, v_rb_b, SEI1_b, 
            SEI2_b, spec_tag_b, b_p_b, b_ctrl_b, valid_b} = (valid_issue_b)? {op[issue_RS_b], ROB_tag[issue_RS_b], PC[issue_RS_b], ra[issue_RS_b], 
                                                                             rb[issue_RS_b], v_ra[issue_RS_b], v_rb[issue_RS_b], SEI1[issue_RS_b], 
                                                                             SEI2[issue_RS_b], spec_tag[issue_RS_b], b_p[issue_RS_b], 
                                                                             b_ctrl[issue_RS_b], valid[issue_RS_b]}: 97'd0;
    assign {ROB_tag_a, PC_a, ra_a, rb_a, rc_a, c_a, z_a, v_ra_a, v_rb_a,
            v_rc_a, v_c_a, v_z_a, spec_tag_a, a_ctrl_a, SEI1_a, valid_a} = (valid_issue_a)? {ROB_tag[issue_RS_a], PC[issue_RS_a], ra[issue_RS_a], 
                                                                                            rb[issue_RS_a], rc[issue_RS_a],  c[issue_RS_a], 
                                                                                            z[issue_RS_a], v_ra[issue_RS_a], v_rb[issue_RS_a], 
                                                                                            v_rc[issue_RS_a], v_c[issue_RS_a], v_z[issue_RS_a], 
                                                                                            spec_tag[issue_RS_a], a_ctrl[issue_RS_a], SEI1[issue_RS_a], 
                                                                                            valid[issue_RS_a]}: 99'd0;
    
    assign {ROB_tag_a2, PC_a2, ra_a2, rb_a2, rc_a2, c_a2, z_a2, v_ra_a2, v_rb_a2,
            v_rc_a2, v_c_a2, v_z_a2, spec_tag_a2, a_ctrl_a2, SEI1_a2, valid_a2} = (valid_issue_a2)? {ROB_tag[issue_RS_a2], PC[issue_RS_a2], ra[issue_RS_a2], 
                                                                                            rb[issue_RS_a2], rc[issue_RS_a2],  c[issue_RS_a2], 
                                                                                            z[issue_RS_a2], v_ra[issue_RS_a2], v_rb[issue_RS_a2], 
                                                                                            v_rc[issue_RS_a2], v_c[issue_RS_a2], v_z[issue_RS_a2], 
                                                                                            spec_tag[issue_RS_a2], a_ctrl[issue_RS_a2], SEI1[issue_RS_a2], 
                                                                                            valid[issue_RS_a2]}: 99'd0;
    
    assign {ROB_tag_l, PC_l, ra_l, rb_l, v_ra_l, v_rb_l, Imm2_l,
            SEI1_l, SEI2_l, spec_tag_l, ls_ctrl_l, valid_l} = (valid_issue_ls)? {ROB_tag[issue_RS_ls], PC[issue_RS_ls], ra[issue_RS_ls], rb[issue_RS_ls], 
                                                                                v_ra[issue_RS_ls], v_rb[issue_RS_ls], Imm2[issue_RS_ls], SEI1[issue_RS_ls],
                                                                                SEI2[issue_RS_ls], spec_tag[issue_RS_ls], ls_ctrl[issue_RS_ls], 
                                                                                valid[issue_RS_ls]}: 100'd0;
    
    //Busy bit
    always @ (posedge clk) begin
        if (rst) Busy <= 8'd0;
        else begin
            if (valid1 & valid2) {Busy[RS_tag1], Busy[RS_tag2]} <= 2'b11;
            else if (valid1 & !valid2) Busy[RS_tag1] <= 1'b1;
            else if (!valid1 & valid2) Busy[RS_tag1] <= 1'b1;
            else ;
            if (Busy[issue_RS_b]) begin
                if (valid_issue_b) Busy[issue_RS_b] <= 1'b0;
            end
            if (Busy[issue_RS_a]) begin
                if (valid_issue_a) Busy[issue_RS_a] <= 1'b0;
            end
            if (Busy[issue_RS_a2]) begin
                if (valid_issue_a2) Busy[issue_RS_a2] <= 1'b0;
            end
            if (Busy[issue_RS_ls]) begin
               if (valid_issue_ls) Busy[issue_RS_ls] <= 1'b0;
            end
        end
    end
    
    //Writing
    always @ (posedge clk) begin
        if (rst) begin
            valid <= 8'b00000000;
        end
//        else if (Flush) begin
//        end
        else begin
            if (valid1 & valid2) begin
                {op[RS_tag1], ROB_tag[RS_tag1], PC[RS_tag1], ra[RS_tag1], rb[RS_tag1], v_ra[RS_tag1], v_rb[RS_tag1], 
                spec_tag[RS_tag1], b_p[RS_tag1], b_ctrl[RS_tag1], c[RS_tag1], 
                v_c[RS_tag1], z[RS_tag1], v_z[RS_tag1], rc[RS_tag1], v_rc[RS_tag1], 
                a_ctrl[RS_tag1], Imm2[RS_tag1], ls_ctrl[RS_tag1], SEI1[RS_tag1], 
                SEI2[RS_tag1], FU_bits[RS_tag1]} <= RS_input1;
                //0000 000 0000000000000000 0000000000000000 0000000000000000 0 0 00 0 0000 1 1 0 0 0100011110000000 0 000000 001010000 001 0000100000000000 0000000100000000 00 100001010

                {op[RS_tag2], ROB_tag[RS_tag2], PC[RS_tag2], ra[RS_tag2], rb[RS_tag2], v_ra[RS_tag2], v_rb[RS_tag2], 
                spec_tag[RS_tag2], b_p[RS_tag2], b_ctrl[RS_tag2], c[RS_tag2], 
                v_c[RS_tag2], z[RS_tag2], v_z[RS_tag2], rc[RS_tag2], v_rc[RS_tag2], 
                a_ctrl[RS_tag2], Imm2[RS_tag2], ls_ctrl[RS_tag2], SEI1[RS_tag2], 
                SEI2[RS_tag2], FU_bits[RS_tag2]} <= RS_input2;
                
                {valid[RS_tag1], valid[RS_tag2]} <= 2'b11;
                
            end
            else if (valid1 & !valid2) begin
                {op[RS_tag1], ROB_tag[RS_tag1], PC[RS_tag1], ra[RS_tag1], rb[RS_tag1], v_ra[RS_tag1], v_rb[RS_tag1], 
                spec_tag[RS_tag1], b_p[RS_tag1], b_ctrl[RS_tag1], c[RS_tag1], 
                v_c[RS_tag1], z[RS_tag1], v_z[RS_tag1], rc[RS_tag1], v_rc[RS_tag1], 
                a_ctrl[RS_tag1], Imm2[RS_tag1], ls_ctrl[RS_tag1], SEI1[RS_tag1], 
                SEI2[RS_tag1], FU_bits[RS_tag1]} <= RS_input1;
                
                valid[RS_tag1] <= 1'b1;
                
            end
            else if (!valid1 & valid2) begin
                {op[RS_tag1], ROB_tag[RS_tag1], PC[RS_tag1], ra[RS_tag1], rb[RS_tag1], v_ra[RS_tag1], v_rb[RS_tag1], 
                spec_tag[RS_tag1], b_p[RS_tag1], b_ctrl[RS_tag1], c[RS_tag1], 
                v_c[RS_tag1], z[RS_tag1], v_z[RS_tag1], rc[RS_tag1], v_rc[RS_tag1], 
                a_ctrl[RS_tag1], Imm2[RS_tag1], ls_ctrl[RS_tag1], SEI1[RS_tag1], 
                SEI2[RS_tag1], FU_bits[RS_tag1]} <= RS_input2;
                
                valid[RS_tag1] <= 1'b1;
                
            end
            else begin
            end
        end
    end
    
    integer i;

    always @ (*) begin
        for (i = 0; i < 8; i = i + 1) begin
            if (Busy[i]) begin
                if (((FU_bits[i] == 3'b001) || (FU_bits[i] == 3'b100)) && (v_ra[i] & v_rb[i])) begin
                    Ready[i] = 1'b1; // Blocking assignment
                end
                else if ((FU_bits[i] == 3'b010) && (v_ra[i] & v_rb[i] & v_c[i] & v_z[i] & v_rc[i])) begin
                    Ready[i] = 1'b1; // Blocking assignment
                end
                else Ready[i] = 1'b0; // Blocking assignment
            end
            else Ready[i] = 1'b0; // Blocking assignment
        end
    end


    //Data Forwarding
    
    integer j;
    
    always @ (posedge clk) begin
        for (j = 0; j < 8; j = j + 1) begin
            if (Busy[i]) begin
                if (valid_b_cdb) begin
                    if (ROB_b_cdb == ra[i] && !v_ra[i]) begin
                        ra[i] <= reg_data_b;
                        v_ra[i] <= 1'b1;
                    end
                    if (ROB_b_cdb == rb[i] && !v_rb[i]) begin
                        rb[i] <= reg_data_b;
                        v_rb[i] <= 1'b1;
                    end
                    if (ROB_b_cdb == rc[i] && !v_rc[i]) begin
                        rc[i] <= reg_data_b;
                        v_rc[i] <= 1'b1;
                    end
                end
                if (valid_a_cdb) begin
                    if (ROB_a_cdb == ra[i] && !v_ra[i]) begin
                        ra[i] <= alu_out;
                        v_ra[i] <= 1'b1;
                    end
                    if (ROB_a_cdb == rb[i] && !v_rb[i]) begin
                        rb[i] <= alu_out;
                        v_rb[i] <= 1'b1;
                    end
                    if (ROB_a_cdb == rc[i] && !v_rc[i]) begin
                        rc[i] <= alu_out;
                        v_rc[i] <= 1'b1;
                    end
                end
                if (valid_a2_cdb) begin
                    if (ROB_a2_cdb == ra[i] && !v_ra[i]) begin
                        ra[i] <= alu2_out;
                        v_ra[i] <= 1'b1;
                    end
                    if (ROB_a2_cdb == rb[i] && !v_rb[i]) begin
                        rb[i] <= alu2_out;
                        v_rb[i] <= 1'b1;
                    end
                    if (ROB_a2_cdb == rc[i] && !v_rc[i]) begin
                        rc[i] <= alu2_out;
                        v_rc[i] <= 1'b1;
                    end
                end
                if (valid_ls_cdb) begin
                    if (ROB_ls_cdb == ra[i] && !v_ra[i]) begin
                        ra[i] <= dm_data;
                        v_ra[i] <= 1'b1;
                    end
                    if (ROB_ls_cdb == rb[i] && !v_rb[i]) begin
                        rb[i] <= dm_data;
                        v_rb[i] <= 1'b1;
                    end
                    if (ROB_ls_cdb == rc[i] && !v_rc[i]) begin
                        rc[i] <= dm_data;
                        v_rc[i] <= 1'b1;
                    end
                end
            end
        end
    end
    
    
    
endmodule

//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
//Date        : Fri Dec 20 18:08:56 2024
//Host        : CHEEMz-PC running 64-bit major release  (build 9200)
//Command     : generate_target Superscalar_Processor_wrapper.bd
//Design      : Superscalar_Processor_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module Superscalar_Processor_wrapper
   (Busy_0,
    Imm1_1_out_0,
    Imm1_2_out_0,
    Imm2_l_0,
    PC_b_0,
    PC_l_0,
    ROB_tag_b_0,
    ROB_tag_l_0,
    SEI1_b_0,
    SEI1_l_0,
    SEI2_b_0,
    SEI2_l_0,
    b_ctrl_b_0,
    b_p_b_0,
    clk_0,
    empty_0,
    full_0,
    ls_ctrl_l_0,
    op_b_0,
    ra_b_0,
    ra_l_0,
    rb_b_0,
    rb_l_0,
    rst_0,
    spec_tag_b_0,
    spec_tag_l_0,
    stall_0,
    v_ra_b_0,
    v_ra_l_0,
    v_rb_b_0,
    v_rb_l_0,
    valid_b_0,
    valid_l_0,
    wC1_0,
    wC2_0,
    wZ1_0,
    wZ2_0);
  output [7:0]Busy_0;
  output [5:0]Imm1_1_out_0;
  output [5:0]Imm1_2_out_0;
  output [8:0]Imm2_l_0;
  output [15:0]PC_b_0;
  output [15:0]PC_l_0;
  output [2:0]ROB_tag_b_0;
  output [2:0]ROB_tag_l_0;
  output [15:0]SEI1_b_0;
  output [15:0]SEI1_l_0;
  output [15:0]SEI2_b_0;
  output [15:0]SEI2_l_0;
  output [3:0]b_ctrl_b_0;
  output b_p_b_0;
  input clk_0;
  output empty_0;
  output full_0;
  output [2:0]ls_ctrl_l_0;
  output [3:0]op_b_0;
  output [15:0]ra_b_0;
  output [15:0]ra_l_0;
  output [15:0]rb_b_0;
  output [15:0]rb_l_0;
  input rst_0;
  output [1:0]spec_tag_b_0;
  output [1:0]spec_tag_l_0;
  output stall_0;
  output v_ra_b_0;
  output v_ra_l_0;
  output v_rb_b_0;
  output v_rb_l_0;
  output valid_b_0;
  output valid_l_0;
  output wC1_0;
  output wC2_0;
  output wZ1_0;
  output wZ2_0;

  wire [7:0]Busy_0;
  wire [5:0]Imm1_1_out_0;
  wire [5:0]Imm1_2_out_0;
  wire [8:0]Imm2_l_0;
  wire [15:0]PC_b_0;
  wire [15:0]PC_l_0;
  wire [2:0]ROB_tag_b_0;
  wire [2:0]ROB_tag_l_0;
  wire [15:0]SEI1_b_0;
  wire [15:0]SEI1_l_0;
  wire [15:0]SEI2_b_0;
  wire [15:0]SEI2_l_0;
  wire [3:0]b_ctrl_b_0;
  wire b_p_b_0;
  wire clk_0;
  wire empty_0;
  wire full_0;
  wire [2:0]ls_ctrl_l_0;
  wire [3:0]op_b_0;
  wire [15:0]ra_b_0;
  wire [15:0]ra_l_0;
  wire [15:0]rb_b_0;
  wire [15:0]rb_l_0;
  wire rst_0;
  wire [1:0]spec_tag_b_0;
  wire [1:0]spec_tag_l_0;
  wire stall_0;
  wire v_ra_b_0;
  wire v_ra_l_0;
  wire v_rb_b_0;
  wire v_rb_l_0;
  wire valid_b_0;
  wire valid_l_0;
  wire wC1_0;
  wire wC2_0;
  wire wZ1_0;
  wire wZ2_0;

  Superscalar_Processor Superscalar_Processor_i
       (.Busy_0(Busy_0),
        .Imm1_1_out_0(Imm1_1_out_0),
        .Imm1_2_out_0(Imm1_2_out_0),
        .Imm2_l_0(Imm2_l_0),
        .PC_b_0(PC_b_0),
        .PC_l_0(PC_l_0),
        .ROB_tag_b_0(ROB_tag_b_0),
        .ROB_tag_l_0(ROB_tag_l_0),
        .SEI1_b_0(SEI1_b_0),
        .SEI1_l_0(SEI1_l_0),
        .SEI2_b_0(SEI2_b_0),
        .SEI2_l_0(SEI2_l_0),
        .b_ctrl_b_0(b_ctrl_b_0),
        .b_p_b_0(b_p_b_0),
        .clk_0(clk_0),
        .empty_0(empty_0),
        .full_0(full_0),
        .ls_ctrl_l_0(ls_ctrl_l_0),
        .op_b_0(op_b_0),
        .ra_b_0(ra_b_0),
        .ra_l_0(ra_l_0),
        .rb_b_0(rb_b_0),
        .rb_l_0(rb_l_0),
        .rst_0(rst_0),
        .spec_tag_b_0(spec_tag_b_0),
        .spec_tag_l_0(spec_tag_l_0),
        .stall_0(stall_0),
        .v_ra_b_0(v_ra_b_0),
        .v_ra_l_0(v_ra_l_0),
        .v_rb_b_0(v_rb_b_0),
        .v_rb_l_0(v_rb_l_0),
        .valid_b_0(valid_b_0),
        .valid_l_0(valid_l_0),
        .wC1_0(wC1_0),
        .wC2_0(wC2_0),
        .wZ1_0(wZ1_0),
        .wZ2_0(wZ2_0));
endmodule

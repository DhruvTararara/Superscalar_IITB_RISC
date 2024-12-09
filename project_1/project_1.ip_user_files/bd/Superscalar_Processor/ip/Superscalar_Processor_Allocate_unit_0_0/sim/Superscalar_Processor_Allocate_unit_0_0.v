// (c) Copyright 1995-2024 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:module_ref:Allocate_unit:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module Superscalar_Processor_Allocate_unit_0_0 (
  PC1,
  PC2,
  op1,
  op2,
  RR_stall,
  ROB_head,
  ROB_tail,
  RS_free_bitmap,
  RegWrite1,
  RegWrite2,
  CWrite1,
  ZWrite1,
  CWrite2,
  ZWrite2,
  RAA1,
  RAA2,
  RBB1,
  RBB2,
  RCC1,
  RCC2,
  valid1,
  valid2,
  ra1,
  ra2,
  rb1,
  rb2,
  rc1,
  rc2,
  v_ra1,
  v_ra2,
  v_rb1,
  v_rb2,
  v_rc1,
  v_rc2,
  c1,
  c2,
  z1,
  z2,
  v_c1,
  v_c2,
  v_z1,
  v_z2,
  b_ctrl1,
  b_ctrl2,
  a_ctrl1,
  a_ctrl2,
  ls_ctrl1,
  ls_ctrl2,
  spec_tag1,
  spec_tag2,
  branch_predict1,
  branch_predict2,
  Imm2_1,
  Imm2_2,
  FU_bits1,
  FU_bits2,
  SEI1_1,
  SEI1_2,
  SEI2_1,
  SEI2_2,
  valid1_out,
  valid2_out,
  RegWrite1_out,
  RegWrite2_out,
  RA1_out,
  RA2_out,
  RB1_out,
  RB2_out,
  RC1_out,
  RC2_out,
  RS_tag1,
  RS_tag2,
  FU_bits1_out,
  FU_bits2_out,
  ROB_tag1,
  ROB_tag2,
  RS_input1,
  RS_input2,
  ROB_input1,
  ROB_input2,
  stall
);

input wire [15 : 0] PC1;
input wire [15 : 0] PC2;
input wire [3 : 0] op1;
input wire [3 : 0] op2;
input wire RR_stall;
input wire [2 : 0] ROB_head;
input wire [2 : 0] ROB_tail;
input wire [7 : 0] RS_free_bitmap;
input wire RegWrite1;
input wire RegWrite2;
input wire CWrite1;
input wire ZWrite1;
input wire CWrite2;
input wire ZWrite2;
input wire [2 : 0] RAA1;
input wire [2 : 0] RAA2;
input wire [2 : 0] RBB1;
input wire [2 : 0] RBB2;
input wire [2 : 0] RCC1;
input wire [2 : 0] RCC2;
input wire valid1;
input wire valid2;
input wire [15 : 0] ra1;
input wire [15 : 0] ra2;
input wire [15 : 0] rb1;
input wire [15 : 0] rb2;
input wire [15 : 0] rc1;
input wire [15 : 0] rc2;
input wire v_ra1;
input wire v_ra2;
input wire v_rb1;
input wire v_rb2;
input wire v_rc1;
input wire v_rc2;
input wire c1;
input wire c2;
input wire z1;
input wire z2;
input wire v_c1;
input wire v_c2;
input wire v_z1;
input wire v_z2;
input wire [2 : 0] b_ctrl1;
input wire [2 : 0] b_ctrl2;
input wire [5 : 0] a_ctrl1;
input wire [5 : 0] a_ctrl2;
input wire [2 : 0] ls_ctrl1;
input wire [2 : 0] ls_ctrl2;
input wire [1 : 0] spec_tag1;
input wire [1 : 0] spec_tag2;
input wire branch_predict1;
input wire branch_predict2;
input wire [8 : 0] Imm2_1;
input wire [8 : 0] Imm2_2;
input wire [1 : 0] FU_bits1;
input wire [1 : 0] FU_bits2;
input wire [15 : 0] SEI1_1;
input wire [15 : 0] SEI1_2;
input wire [15 : 0] SEI2_1;
input wire [15 : 0] SEI2_2;
output wire valid1_out;
output wire valid2_out;
output wire RegWrite1_out;
output wire RegWrite2_out;
output wire [2 : 0] RA1_out;
output wire [2 : 0] RA2_out;
output wire [2 : 0] RB1_out;
output wire [2 : 0] RB2_out;
output wire [2 : 0] RC1_out;
output wire [2 : 0] RC2_out;
output wire [2 : 0] RS_tag1;
output wire [2 : 0] RS_tag2;
output wire [1 : 0] FU_bits1_out;
output wire [1 : 0] FU_bits2_out;
output wire [2 : 0] ROB_tag1;
output wire [2 : 0] ROB_tag2;
output wire [136 : 0] RS_input1;
output wire [136 : 0] RS_input2;
output wire [23 : 0] ROB_input1;
output wire [23 : 0] ROB_input2;
output wire stall;

  Allocate_unit inst (
    .PC1(PC1),
    .PC2(PC2),
    .op1(op1),
    .op2(op2),
    .RR_stall(RR_stall),
    .ROB_head(ROB_head),
    .ROB_tail(ROB_tail),
    .RS_free_bitmap(RS_free_bitmap),
    .RegWrite1(RegWrite1),
    .RegWrite2(RegWrite2),
    .CWrite1(CWrite1),
    .ZWrite1(ZWrite1),
    .CWrite2(CWrite2),
    .ZWrite2(ZWrite2),
    .RAA1(RAA1),
    .RAA2(RAA2),
    .RBB1(RBB1),
    .RBB2(RBB2),
    .RCC1(RCC1),
    .RCC2(RCC2),
    .valid1(valid1),
    .valid2(valid2),
    .ra1(ra1),
    .ra2(ra2),
    .rb1(rb1),
    .rb2(rb2),
    .rc1(rc1),
    .rc2(rc2),
    .v_ra1(v_ra1),
    .v_ra2(v_ra2),
    .v_rb1(v_rb1),
    .v_rb2(v_rb2),
    .v_rc1(v_rc1),
    .v_rc2(v_rc2),
    .c1(c1),
    .c2(c2),
    .z1(z1),
    .z2(z2),
    .v_c1(v_c1),
    .v_c2(v_c2),
    .v_z1(v_z1),
    .v_z2(v_z2),
    .b_ctrl1(b_ctrl1),
    .b_ctrl2(b_ctrl2),
    .a_ctrl1(a_ctrl1),
    .a_ctrl2(a_ctrl2),
    .ls_ctrl1(ls_ctrl1),
    .ls_ctrl2(ls_ctrl2),
    .spec_tag1(spec_tag1),
    .spec_tag2(spec_tag2),
    .branch_predict1(branch_predict1),
    .branch_predict2(branch_predict2),
    .Imm2_1(Imm2_1),
    .Imm2_2(Imm2_2),
    .FU_bits1(FU_bits1),
    .FU_bits2(FU_bits2),
    .SEI1_1(SEI1_1),
    .SEI1_2(SEI1_2),
    .SEI2_1(SEI2_1),
    .SEI2_2(SEI2_2),
    .valid1_out(valid1_out),
    .valid2_out(valid2_out),
    .RegWrite1_out(RegWrite1_out),
    .RegWrite2_out(RegWrite2_out),
    .RA1_out(RA1_out),
    .RA2_out(RA2_out),
    .RB1_out(RB1_out),
    .RB2_out(RB2_out),
    .RC1_out(RC1_out),
    .RC2_out(RC2_out),
    .RS_tag1(RS_tag1),
    .RS_tag2(RS_tag2),
    .FU_bits1_out(FU_bits1_out),
    .FU_bits2_out(FU_bits2_out),
    .ROB_tag1(ROB_tag1),
    .ROB_tag2(ROB_tag2),
    .RS_input1(RS_input1),
    .RS_input2(RS_input2),
    .ROB_input1(ROB_input1),
    .ROB_input2(ROB_input2),
    .stall(stall)
  );
endmodule

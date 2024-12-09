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


// IP VLNV: xilinx.com:module_ref:Reservation_Station:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module Superscalar_Processor_Reservation_Station_0_0 (
  clk,
  rst,
  RS_input1,
  RS_input2,
  valid1,
  valid2,
  RS_tag1,
  RS_tag2,
  Busy,
  issue_RS_b,
  issue_RS_a,
  issue_RS_a2,
  issue_RS_ls,
  valid_issue_b,
  valid_issue_a,
  valid_issue_a2,
  valid_issue_ls,
  valid_b_cdb,
  valid_a_cdb,
  valid_a2_cdb,
  valid_ls_cdb,
  reg_data_b,
  alu_out,
  alu2_out,
  dm_data,
  ROB_b_cdb,
  ROB_a_cdb,
  ROB_a2_cdb,
  ROB_ls_cdb,
  FU_bits0,
  FU_bits1,
  FU_bits2,
  FU_bits3,
  FU_bits4,
  FU_bits5,
  FU_bits6,
  FU_bits7,
  PC0,
  PC1,
  PC2,
  PC3,
  PC4,
  PC5,
  PC6,
  PC7,
  Ready,
  op_b,
  ROB_tag_b,
  PC_b,
  ra_b,
  rb_b,
  v_ra_b,
  v_rb_b,
  SEI1_b,
  SEI2_b,
  spec_tag_b,
  b_p_b,
  b_ctrl_b,
  valid_b,
  ROB_tag_a,
  PC_a,
  ra_a,
  rb_a,
  rc_a,
  c_a,
  z_a,
  v_ra_a,
  v_rb_a,
  v_rc_a,
  v_c_a,
  v_z_a,
  spec_tag_a,
  a_ctrl_a,
  SEI1_a,
  valid_a,
  ROB_tag_a2,
  PC_a2,
  ra_a2,
  rb_a2,
  rc_a2,
  c_a2,
  z_a2,
  v_ra_a2,
  v_rb_a2,
  v_rc_a2,
  v_c_a2,
  v_z_a2,
  spec_tag_a2,
  a_ctrl_a2,
  SEI1_a2,
  valid_a2,
  ROB_tag_l,
  PC_l,
  ra_l,
  rb_l,
  v_ra_l,
  v_rb_l,
  Imm2_l,
  SEI1_l,
  SEI2_l,
  spec_tag_l,
  ls_ctrl_l,
  valid_l
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN Superscalar_Processor_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
input wire clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst RST" *)
input wire rst;
input wire [136 : 0] RS_input1;
input wire [136 : 0] RS_input2;
input wire valid1;
input wire valid2;
input wire [2 : 0] RS_tag1;
input wire [2 : 0] RS_tag2;
output wire [7 : 0] Busy;
input wire [2 : 0] issue_RS_b;
input wire [2 : 0] issue_RS_a;
input wire [2 : 0] issue_RS_a2;
input wire [2 : 0] issue_RS_ls;
input wire valid_issue_b;
input wire valid_issue_a;
input wire valid_issue_a2;
input wire valid_issue_ls;
input wire valid_b_cdb;
input wire valid_a_cdb;
input wire valid_a2_cdb;
input wire valid_ls_cdb;
input wire [15 : 0] reg_data_b;
input wire [15 : 0] alu_out;
input wire [15 : 0] alu2_out;
input wire [15 : 0] dm_data;
input wire [2 : 0] ROB_b_cdb;
input wire [2 : 0] ROB_a_cdb;
input wire [2 : 0] ROB_a2_cdb;
input wire [2 : 0] ROB_ls_cdb;
output wire [2 : 0] FU_bits0;
output wire [2 : 0] FU_bits1;
output wire [2 : 0] FU_bits2;
output wire [2 : 0] FU_bits3;
output wire [2 : 0] FU_bits4;
output wire [2 : 0] FU_bits5;
output wire [2 : 0] FU_bits6;
output wire [2 : 0] FU_bits7;
output wire [15 : 0] PC0;
output wire [15 : 0] PC1;
output wire [15 : 0] PC2;
output wire [15 : 0] PC3;
output wire [15 : 0] PC4;
output wire [15 : 0] PC5;
output wire [15 : 0] PC6;
output wire [15 : 0] PC7;
output wire [7 : 0] Ready;
output wire [3 : 0] op_b;
output wire [2 : 0] ROB_tag_b;
output wire [15 : 0] PC_b;
output wire [15 : 0] ra_b;
output wire [15 : 0] rb_b;
output wire v_ra_b;
output wire v_rb_b;
output wire [15 : 0] SEI1_b;
output wire [15 : 0] SEI2_b;
output wire [1 : 0] spec_tag_b;
output wire b_p_b;
output wire [3 : 0] b_ctrl_b;
output wire valid_b;
output wire [2 : 0] ROB_tag_a;
output wire [15 : 0] PC_a;
output wire [15 : 0] ra_a;
output wire [15 : 0] rb_a;
output wire [15 : 0] rc_a;
output wire c_a;
output wire z_a;
output wire v_ra_a;
output wire v_rb_a;
output wire v_rc_a;
output wire v_c_a;
output wire v_z_a;
output wire [1 : 0] spec_tag_a;
output wire [5 : 0] a_ctrl_a;
output wire [15 : 0] SEI1_a;
output wire valid_a;
output wire [2 : 0] ROB_tag_a2;
output wire [15 : 0] PC_a2;
output wire [15 : 0] ra_a2;
output wire [15 : 0] rb_a2;
output wire [15 : 0] rc_a2;
output wire c_a2;
output wire z_a2;
output wire v_ra_a2;
output wire v_rb_a2;
output wire v_rc_a2;
output wire v_c_a2;
output wire v_z_a2;
output wire [1 : 0] spec_tag_a2;
output wire [5 : 0] a_ctrl_a2;
output wire [15 : 0] SEI1_a2;
output wire valid_a2;
output wire [2 : 0] ROB_tag_l;
output wire [15 : 0] PC_l;
output wire [15 : 0] ra_l;
output wire [15 : 0] rb_l;
output wire v_ra_l;
output wire v_rb_l;
output wire [8 : 0] Imm2_l;
output wire [15 : 0] SEI1_l;
output wire [15 : 0] SEI2_l;
output wire [1 : 0] spec_tag_l;
output wire [2 : 0] ls_ctrl_l;
output wire valid_l;

  Reservation_Station inst (
    .clk(clk),
    .rst(rst),
    .RS_input1(RS_input1),
    .RS_input2(RS_input2),
    .valid1(valid1),
    .valid2(valid2),
    .RS_tag1(RS_tag1),
    .RS_tag2(RS_tag2),
    .Busy(Busy),
    .issue_RS_b(issue_RS_b),
    .issue_RS_a(issue_RS_a),
    .issue_RS_a2(issue_RS_a2),
    .issue_RS_ls(issue_RS_ls),
    .valid_issue_b(valid_issue_b),
    .valid_issue_a(valid_issue_a),
    .valid_issue_a2(valid_issue_a2),
    .valid_issue_ls(valid_issue_ls),
    .valid_b_cdb(valid_b_cdb),
    .valid_a_cdb(valid_a_cdb),
    .valid_a2_cdb(valid_a2_cdb),
    .valid_ls_cdb(valid_ls_cdb),
    .reg_data_b(reg_data_b),
    .alu_out(alu_out),
    .alu2_out(alu2_out),
    .dm_data(dm_data),
    .ROB_b_cdb(ROB_b_cdb),
    .ROB_a_cdb(ROB_a_cdb),
    .ROB_a2_cdb(ROB_a2_cdb),
    .ROB_ls_cdb(ROB_ls_cdb),
    .FU_bits0(FU_bits0),
    .FU_bits1(FU_bits1),
    .FU_bits2(FU_bits2),
    .FU_bits3(FU_bits3),
    .FU_bits4(FU_bits4),
    .FU_bits5(FU_bits5),
    .FU_bits6(FU_bits6),
    .FU_bits7(FU_bits7),
    .PC0(PC0),
    .PC1(PC1),
    .PC2(PC2),
    .PC3(PC3),
    .PC4(PC4),
    .PC5(PC5),
    .PC6(PC6),
    .PC7(PC7),
    .Ready(Ready),
    .op_b(op_b),
    .ROB_tag_b(ROB_tag_b),
    .PC_b(PC_b),
    .ra_b(ra_b),
    .rb_b(rb_b),
    .v_ra_b(v_ra_b),
    .v_rb_b(v_rb_b),
    .SEI1_b(SEI1_b),
    .SEI2_b(SEI2_b),
    .spec_tag_b(spec_tag_b),
    .b_p_b(b_p_b),
    .b_ctrl_b(b_ctrl_b),
    .valid_b(valid_b),
    .ROB_tag_a(ROB_tag_a),
    .PC_a(PC_a),
    .ra_a(ra_a),
    .rb_a(rb_a),
    .rc_a(rc_a),
    .c_a(c_a),
    .z_a(z_a),
    .v_ra_a(v_ra_a),
    .v_rb_a(v_rb_a),
    .v_rc_a(v_rc_a),
    .v_c_a(v_c_a),
    .v_z_a(v_z_a),
    .spec_tag_a(spec_tag_a),
    .a_ctrl_a(a_ctrl_a),
    .SEI1_a(SEI1_a),
    .valid_a(valid_a),
    .ROB_tag_a2(ROB_tag_a2),
    .PC_a2(PC_a2),
    .ra_a2(ra_a2),
    .rb_a2(rb_a2),
    .rc_a2(rc_a2),
    .c_a2(c_a2),
    .z_a2(z_a2),
    .v_ra_a2(v_ra_a2),
    .v_rb_a2(v_rb_a2),
    .v_rc_a2(v_rc_a2),
    .v_c_a2(v_c_a2),
    .v_z_a2(v_z_a2),
    .spec_tag_a2(spec_tag_a2),
    .a_ctrl_a2(a_ctrl_a2),
    .SEI1_a2(SEI1_a2),
    .valid_a2(valid_a2),
    .ROB_tag_l(ROB_tag_l),
    .PC_l(PC_l),
    .ra_l(ra_l),
    .rb_l(rb_l),
    .v_ra_l(v_ra_l),
    .v_rb_l(v_rb_l),
    .Imm2_l(Imm2_l),
    .SEI1_l(SEI1_l),
    .SEI2_l(SEI2_l),
    .spec_tag_l(spec_tag_l),
    .ls_ctrl_l(ls_ctrl_l),
    .valid_l(valid_l)
  );
endmodule

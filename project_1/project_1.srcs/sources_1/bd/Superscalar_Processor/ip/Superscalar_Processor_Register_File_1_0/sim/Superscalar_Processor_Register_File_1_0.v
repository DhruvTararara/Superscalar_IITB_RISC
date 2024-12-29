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


// IP VLNV: xilinx.com:module_ref:Register_File:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module Superscalar_Processor_Register_File_1_0 (
  clk,
  rst,
  op1,
  op2,
  ROB_tag1,
  ROB_tag2,
  RegWrite1,
  RegWrite2,
  RAA1,
  RAA2,
  RBB1,
  RBB2,
  RCC1,
  RCC2,
  FU_bits1,
  FU_bits2,
  valid1,
  valid2,
  RAW,
  WAR,
  WAW,
  ROB_ra1,
  ROB_ra2,
  ROB_rb1,
  ROB_rb2,
  ROB_rc1,
  ROB_rc2,
  valid_ROB,
  wb1,
  wb2,
  ROB1,
  ROB2,
  RD1,
  RD2,
  reg_data1,
  reg_data2,
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
  RA1_t,
  RA2_t,
  RB1_t,
  RB2_t,
  Rc1_t,
  RC2_t,
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
  RDD1_out,
  RDD2_out
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN Superscalar_Processor_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
input wire clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst RST" *)
input wire rst;
input wire [3 : 0] op1;
input wire [3 : 0] op2;
input wire [2 : 0] ROB_tag1;
input wire [2 : 0] ROB_tag2;
input wire RegWrite1;
input wire RegWrite2;
input wire [2 : 0] RAA1;
input wire [2 : 0] RAA2;
input wire [2 : 0] RBB1;
input wire [2 : 0] RBB2;
input wire [2 : 0] RCC1;
input wire [2 : 0] RCC2;
input wire [1 : 0] FU_bits1;
input wire [1 : 0] FU_bits2;
input wire valid1;
input wire valid2;
input wire [2 : 0] RAW;
input wire WAR;
input wire WAW;
input wire [15 : 0] ROB_ra1;
input wire [15 : 0] ROB_ra2;
input wire [15 : 0] ROB_rb1;
input wire [15 : 0] ROB_rb2;
input wire [15 : 0] ROB_rc1;
input wire [15 : 0] ROB_rc2;
input wire [7 : 0] valid_ROB;
input wire wb1;
input wire wb2;
input wire [2 : 0] ROB1;
input wire [2 : 0] ROB2;
input wire [2 : 0] RD1;
input wire [2 : 0] RD2;
input wire [15 : 0] reg_data1;
input wire [15 : 0] reg_data2;
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
output wire [2 : 0] RA1_t;
output wire [2 : 0] RA2_t;
output wire [2 : 0] RB1_t;
output wire [2 : 0] RB2_t;
output wire [2 : 0] Rc1_t;
output wire [2 : 0] RC2_t;
output wire [15 : 0] ra1;
output wire [15 : 0] ra2;
output wire [15 : 0] rb1;
output wire [15 : 0] rb2;
output wire [15 : 0] rc1;
output wire [15 : 0] rc2;
output wire v_ra1;
output wire v_ra2;
output wire v_rb1;
output wire v_rb2;
output wire v_rc1;
output wire v_rc2;
output wire [2 : 0] RDD1_out;
output wire [2 : 0] RDD2_out;

  Register_File inst (
    .clk(clk),
    .rst(rst),
    .op1(op1),
    .op2(op2),
    .ROB_tag1(ROB_tag1),
    .ROB_tag2(ROB_tag2),
    .RegWrite1(RegWrite1),
    .RegWrite2(RegWrite2),
    .RAA1(RAA1),
    .RAA2(RAA2),
    .RBB1(RBB1),
    .RBB2(RBB2),
    .RCC1(RCC1),
    .RCC2(RCC2),
    .FU_bits1(FU_bits1),
    .FU_bits2(FU_bits2),
    .valid1(valid1),
    .valid2(valid2),
    .RAW(RAW),
    .WAR(WAR),
    .WAW(WAW),
    .ROB_ra1(ROB_ra1),
    .ROB_ra2(ROB_ra2),
    .ROB_rb1(ROB_rb1),
    .ROB_rb2(ROB_rb2),
    .ROB_rc1(ROB_rc1),
    .ROB_rc2(ROB_rc2),
    .valid_ROB(valid_ROB),
    .wb1(wb1),
    .wb2(wb2),
    .ROB1(ROB1),
    .ROB2(ROB2),
    .RD1(RD1),
    .RD2(RD2),
    .reg_data1(reg_data1),
    .reg_data2(reg_data2),
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
    .RA1_t(RA1_t),
    .RA2_t(RA2_t),
    .RB1_t(RB1_t),
    .RB2_t(RB2_t),
    .Rc1_t(Rc1_t),
    .RC2_t(RC2_t),
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
    .RDD1_out(RDD1_out),
    .RDD2_out(RDD2_out)
  );
endmodule

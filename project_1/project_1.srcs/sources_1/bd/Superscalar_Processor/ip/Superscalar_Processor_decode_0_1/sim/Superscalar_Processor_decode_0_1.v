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


// IP VLNV: xilinx.com:module_ref:decode:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module Superscalar_Processor_decode_0_1 (
  clk,
  rst,
  IA1,
  IA2,
  instr1,
  instr2,
  branch_predict1,
  branch_predict2,
  valid1,
  valid2,
  IA1_out,
  IA2_out,
  op1,
  op2,
  RA1,
  RA2,
  RB1,
  RB2,
  RC1,
  RC2,
  comp1,
  comp2,
  CZ1,
  CZ2,
  Imm1_1,
  Imm1_2,
  Imm2_1,
  Imm2_2,
  SEI1_1,
  SEI1_2,
  SEI2_1,
  SEI2_2,
  spec_tag1,
  spec_tag2,
  valid1_out,
  valid2_out,
  branch_predict1_out,
  branch_predict2_out
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN Superscalar_Processor_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
input wire clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst RST" *)
input wire rst;
input wire [15 : 0] IA1;
input wire [15 : 0] IA2;
input wire [15 : 0] instr1;
input wire [15 : 0] instr2;
input wire branch_predict1;
input wire branch_predict2;
input wire valid1;
input wire valid2;
output wire [15 : 0] IA1_out;
output wire [15 : 0] IA2_out;
output wire [3 : 0] op1;
output wire [3 : 0] op2;
output wire [2 : 0] RA1;
output wire [2 : 0] RA2;
output wire [2 : 0] RB1;
output wire [2 : 0] RB2;
output wire [2 : 0] RC1;
output wire [2 : 0] RC2;
output wire comp1;
output wire comp2;
output wire [1 : 0] CZ1;
output wire [1 : 0] CZ2;
output wire [5 : 0] Imm1_1;
output wire [5 : 0] Imm1_2;
output wire [8 : 0] Imm2_1;
output wire [8 : 0] Imm2_2;
output wire [15 : 0] SEI1_1;
output wire [15 : 0] SEI1_2;
output wire [15 : 0] SEI2_1;
output wire [15 : 0] SEI2_2;
output wire [1 : 0] spec_tag1;
output wire [1 : 0] spec_tag2;
output wire valid1_out;
output wire valid2_out;
output wire branch_predict1_out;
output wire branch_predict2_out;

  decode inst (
    .clk(clk),
    .rst(rst),
    .IA1(IA1),
    .IA2(IA2),
    .instr1(instr1),
    .instr2(instr2),
    .branch_predict1(branch_predict1),
    .branch_predict2(branch_predict2),
    .valid1(valid1),
    .valid2(valid2),
    .IA1_out(IA1_out),
    .IA2_out(IA2_out),
    .op1(op1),
    .op2(op2),
    .RA1(RA1),
    .RA2(RA2),
    .RB1(RB1),
    .RB2(RB2),
    .RC1(RC1),
    .RC2(RC2),
    .comp1(comp1),
    .comp2(comp2),
    .CZ1(CZ1),
    .CZ2(CZ2),
    .Imm1_1(Imm1_1),
    .Imm1_2(Imm1_2),
    .Imm2_1(Imm2_1),
    .Imm2_2(Imm2_2),
    .SEI1_1(SEI1_1),
    .SEI1_2(SEI1_2),
    .SEI2_1(SEI2_1),
    .SEI2_2(SEI2_2),
    .spec_tag1(spec_tag1),
    .spec_tag2(spec_tag2),
    .valid1_out(valid1_out),
    .valid2_out(valid2_out),
    .branch_predict1_out(branch_predict1_out),
    .branch_predict2_out(branch_predict2_out)
  );
endmodule

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


// IP VLNV: xilinx.com:module_ref:DispatchBuffer:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module Superscalar_Processor_DispatchBuffer_0_0 (
  clk,
  rst,
  stall,
  IA1_in,
  IA2_in,
  op1_in,
  op2_in,
  RA1_in,
  RA2_in,
  RB1_in,
  RB2_in,
  RC1_in,
  RC2_in,
  comp1_in,
  comp2_in,
  CZ1_in,
  CZ2_in,
  Imm1_1_in,
  Imm1_2_in,
  Imm2_1_in,
  Imm2_2_in,
  SEI1_1_in,
  SEI1_2_in,
  SEI2_1_in,
  SEI2_2_in,
  spec_tag1_in,
  spec_tag2_in,
  valid_in1,
  valid_in2,
  branch_predict1_in,
  branch_predict2_in,
  issue1,
  issue2,
  IA1_out,
  IA2_out,
  op1_out,
  op2_out,
  RA1_out,
  RA2_out,
  RB1_out,
  RB2_out,
  RC1_out,
  RC2_out,
  comp1_out,
  comp2_out,
  CZ1_out,
  CZ2_out,
  Imm1_1_out,
  Imm1_2_out,
  Imm2_1_out,
  Imm2_2_out,
  SEI1_1_out,
  SEI1_2_out,
  SEI2_1_out,
  SEI2_2_out,
  spec_tag1_out,
  spec_tag2_out,
  valid_out1,
  valid_out2,
  branch_predict1_out,
  branch_predict2_out,
  full,
  empty
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN Superscalar_Processor_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
input wire clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst RST" *)
input wire rst;
input wire stall;
input wire [15 : 0] IA1_in;
input wire [15 : 0] IA2_in;
input wire [3 : 0] op1_in;
input wire [3 : 0] op2_in;
input wire [2 : 0] RA1_in;
input wire [2 : 0] RA2_in;
input wire [2 : 0] RB1_in;
input wire [2 : 0] RB2_in;
input wire [2 : 0] RC1_in;
input wire [2 : 0] RC2_in;
input wire comp1_in;
input wire comp2_in;
input wire [1 : 0] CZ1_in;
input wire [1 : 0] CZ2_in;
input wire [5 : 0] Imm1_1_in;
input wire [5 : 0] Imm1_2_in;
input wire [8 : 0] Imm2_1_in;
input wire [8 : 0] Imm2_2_in;
input wire [15 : 0] SEI1_1_in;
input wire [15 : 0] SEI1_2_in;
input wire [15 : 0] SEI2_1_in;
input wire [15 : 0] SEI2_2_in;
input wire [1 : 0] spec_tag1_in;
input wire [1 : 0] spec_tag2_in;
input wire valid_in1;
input wire valid_in2;
input wire branch_predict1_in;
input wire branch_predict2_in;
input wire issue1;
input wire issue2;
output wire [15 : 0] IA1_out;
output wire [15 : 0] IA2_out;
output wire [3 : 0] op1_out;
output wire [3 : 0] op2_out;
output wire [2 : 0] RA1_out;
output wire [2 : 0] RA2_out;
output wire [2 : 0] RB1_out;
output wire [2 : 0] RB2_out;
output wire [2 : 0] RC1_out;
output wire [2 : 0] RC2_out;
output wire comp1_out;
output wire comp2_out;
output wire [1 : 0] CZ1_out;
output wire [1 : 0] CZ2_out;
output wire [5 : 0] Imm1_1_out;
output wire [5 : 0] Imm1_2_out;
output wire [8 : 0] Imm2_1_out;
output wire [8 : 0] Imm2_2_out;
output wire [15 : 0] SEI1_1_out;
output wire [15 : 0] SEI1_2_out;
output wire [15 : 0] SEI2_1_out;
output wire [15 : 0] SEI2_2_out;
output wire [1 : 0] spec_tag1_out;
output wire [1 : 0] spec_tag2_out;
output wire valid_out1;
output wire valid_out2;
output wire branch_predict1_out;
output wire branch_predict2_out;
output wire full;
output wire empty;

  DispatchBuffer #(
    .BUFFER_SIZE(4),
    .OP_WIDTH(4),
    .REG_ADDR_WIDTH(3),
    .IMM1_WIDTH(6),
    .IMM2_WIDTH(9),
    .SEI1_WIDTH(16),
    .SEI2_WIDTH(16)
  ) inst (
    .clk(clk),
    .rst(rst),
    .stall(stall),
    .IA1_in(IA1_in),
    .IA2_in(IA2_in),
    .op1_in(op1_in),
    .op2_in(op2_in),
    .RA1_in(RA1_in),
    .RA2_in(RA2_in),
    .RB1_in(RB1_in),
    .RB2_in(RB2_in),
    .RC1_in(RC1_in),
    .RC2_in(RC2_in),
    .comp1_in(comp1_in),
    .comp2_in(comp2_in),
    .CZ1_in(CZ1_in),
    .CZ2_in(CZ2_in),
    .Imm1_1_in(Imm1_1_in),
    .Imm1_2_in(Imm1_2_in),
    .Imm2_1_in(Imm2_1_in),
    .Imm2_2_in(Imm2_2_in),
    .SEI1_1_in(SEI1_1_in),
    .SEI1_2_in(SEI1_2_in),
    .SEI2_1_in(SEI2_1_in),
    .SEI2_2_in(SEI2_2_in),
    .spec_tag1_in(spec_tag1_in),
    .spec_tag2_in(spec_tag2_in),
    .valid_in1(valid_in1),
    .valid_in2(valid_in2),
    .branch_predict1_in(branch_predict1_in),
    .branch_predict2_in(branch_predict2_in),
    .issue1(issue1),
    .issue2(issue2),
    .IA1_out(IA1_out),
    .IA2_out(IA2_out),
    .op1_out(op1_out),
    .op2_out(op2_out),
    .RA1_out(RA1_out),
    .RA2_out(RA2_out),
    .RB1_out(RB1_out),
    .RB2_out(RB2_out),
    .RC1_out(RC1_out),
    .RC2_out(RC2_out),
    .comp1_out(comp1_out),
    .comp2_out(comp2_out),
    .CZ1_out(CZ1_out),
    .CZ2_out(CZ2_out),
    .Imm1_1_out(Imm1_1_out),
    .Imm1_2_out(Imm1_2_out),
    .Imm2_1_out(Imm2_1_out),
    .Imm2_2_out(Imm2_2_out),
    .SEI1_1_out(SEI1_1_out),
    .SEI1_2_out(SEI1_2_out),
    .SEI2_1_out(SEI2_1_out),
    .SEI2_2_out(SEI2_2_out),
    .spec_tag1_out(spec_tag1_out),
    .spec_tag2_out(spec_tag2_out),
    .valid_out1(valid_out1),
    .valid_out2(valid_out2),
    .branch_predict1_out(branch_predict1_out),
    .branch_predict2_out(branch_predict2_out),
    .full(full),
    .empty(empty)
  );
endmodule

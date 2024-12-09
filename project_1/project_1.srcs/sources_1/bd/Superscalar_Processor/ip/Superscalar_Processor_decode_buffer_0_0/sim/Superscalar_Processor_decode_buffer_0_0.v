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


// IP VLNV: xilinx.com:module_ref:decode_buffer:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module Superscalar_Processor_decode_buffer_0_0 (
  clk,
  rst,
  PC_in,
  instr1_in,
  valid1_in,
  valid2_in,
  instr2_in,
  branch_predict1_in,
  branch_predict2_in,
  address_out1,
  address_out2,
  instr1_out,
  instr2_out,
  branch_predict1_out,
  branch_predict2_out,
  valid1_out,
  valid2_out
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 100000000, PHASE 0.000, CLK_DOMAIN Superscalar_Processor_clk_0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
input wire clk;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 rst RST" *)
input wire rst;
input wire [15 : 0] PC_in;
input wire [15 : 0] instr1_in;
input wire valid1_in;
input wire valid2_in;
input wire [15 : 0] instr2_in;
input wire branch_predict1_in;
input wire branch_predict2_in;
output wire [15 : 0] address_out1;
output wire [15 : 0] address_out2;
output wire [15 : 0] instr1_out;
output wire [15 : 0] instr2_out;
output wire branch_predict1_out;
output wire branch_predict2_out;
output wire valid1_out;
output wire valid2_out;

  decode_buffer inst (
    .clk(clk),
    .rst(rst),
    .PC_in(PC_in),
    .instr1_in(instr1_in),
    .valid1_in(valid1_in),
    .valid2_in(valid2_in),
    .instr2_in(instr2_in),
    .branch_predict1_in(branch_predict1_in),
    .branch_predict2_in(branch_predict2_in),
    .address_out1(address_out1),
    .address_out2(address_out2),
    .instr1_out(instr1_out),
    .instr2_out(instr2_out),
    .branch_predict1_out(branch_predict1_out),
    .branch_predict2_out(branch_predict2_out),
    .valid1_out(valid1_out),
    .valid2_out(valid2_out)
  );
endmodule

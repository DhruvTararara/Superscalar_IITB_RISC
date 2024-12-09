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


// IP VLNV: xilinx.com:module_ref:ALU:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module Superscalar_Processor_ALU_1_0 (
  ROB_tag,
  PC,
  ra,
  rb,
  rc,
  c,
  z,
  v_ra,
  v_rb,
  v_rc,
  v_c,
  v_z,
  spec_tag,
  a_ctrl,
  SEI1,
  valid,
  valid_out,
  ROB_tag_out,
  alu_out,
  PC_out
);

input wire [2 : 0] ROB_tag;
input wire [15 : 0] PC;
input wire [15 : 0] ra;
input wire [15 : 0] rb;
input wire [15 : 0] rc;
input wire c;
input wire z;
input wire v_ra;
input wire v_rb;
input wire v_rc;
input wire v_c;
input wire v_z;
input wire [1 : 0] spec_tag;
input wire [5 : 0] a_ctrl;
input wire [15 : 0] SEI1;
input wire valid;
output wire valid_out;
output wire [2 : 0] ROB_tag_out;
output wire [15 : 0] alu_out;
output wire [15 : 0] PC_out;

  ALU inst (
    .ROB_tag(ROB_tag),
    .PC(PC),
    .ra(ra),
    .rb(rb),
    .rc(rc),
    .c(c),
    .z(z),
    .v_ra(v_ra),
    .v_rb(v_rb),
    .v_rc(v_rc),
    .v_c(v_c),
    .v_z(v_z),
    .spec_tag(spec_tag),
    .a_ctrl(a_ctrl),
    .SEI1(SEI1),
    .valid(valid),
    .valid_out(valid_out),
    .ROB_tag_out(ROB_tag_out),
    .alu_out(alu_out),
    .PC_out(PC_out)
  );
endmodule

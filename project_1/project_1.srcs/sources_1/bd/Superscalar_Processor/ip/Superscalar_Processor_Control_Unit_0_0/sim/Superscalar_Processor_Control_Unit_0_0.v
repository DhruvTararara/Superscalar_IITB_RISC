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


// IP VLNV: xilinx.com:module_ref:Control_Unit:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module Superscalar_Processor_Control_Unit_0_0 (
  op1,
  op2,
  RegWrite1,
  RegWrite2,
  Comp1,
  Comp2,
  CZ1,
  CZ2,
  b_ctrl1,
  b_ctrl2,
  a_ctrl1,
  a_ctrl2,
  ls_ctrl1,
  ls_ctrl2,
  FU_bits1,
  FU_bits2
);

input wire [3 : 0] op1;
input wire [3 : 0] op2;
input wire RegWrite1;
input wire RegWrite2;
input wire Comp1;
input wire Comp2;
input wire [1 : 0] CZ1;
input wire [1 : 0] CZ2;
output wire [2 : 0] b_ctrl1;
output wire [2 : 0] b_ctrl2;
output wire [5 : 0] a_ctrl1;
output wire [5 : 0] a_ctrl2;
output wire [2 : 0] ls_ctrl1;
output wire [2 : 0] ls_ctrl2;
output wire [2 : 0] FU_bits1;
output wire [2 : 0] FU_bits2;

  Control_Unit inst (
    .op1(op1),
    .op2(op2),
    .RegWrite1(RegWrite1),
    .RegWrite2(RegWrite2),
    .Comp1(Comp1),
    .Comp2(Comp2),
    .CZ1(CZ1),
    .CZ2(CZ2),
    .b_ctrl1(b_ctrl1),
    .b_ctrl2(b_ctrl2),
    .a_ctrl1(a_ctrl1),
    .a_ctrl2(a_ctrl2),
    .ls_ctrl1(ls_ctrl1),
    .ls_ctrl2(ls_ctrl2),
    .FU_bits1(FU_bits1),
    .FU_bits2(FU_bits2)
  );
endmodule

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


// IP VLNV: xilinx.com:module_ref:Register_Interdependence:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module Superscalar_Processor_Register_Interdepend_0_0 (
  RW1,
  RW2,
  RA1,
  RA2,
  RB1,
  RB2,
  RC1,
  RC2,
  Rd1,
  Rd2,
  FU_bits1,
  FU_bits2,
  RAW,
  WAR,
  WAW
);

input wire RW1;
input wire RW2;
input wire [2 : 0] RA1;
input wire [2 : 0] RA2;
input wire [2 : 0] RB1;
input wire [2 : 0] RB2;
input wire [2 : 0] RC1;
input wire [2 : 0] RC2;
input wire [2 : 0] Rd1;
input wire [2 : 0] Rd2;
input wire [2 : 0] FU_bits1;
input wire [2 : 0] FU_bits2;
output wire [2 : 0] RAW;
output wire WAR;
output wire WAW;

  Register_Interdependence inst (
    .RW1(RW1),
    .RW2(RW2),
    .RA1(RA1),
    .RA2(RA2),
    .RB1(RB1),
    .RB2(RB2),
    .RC1(RC1),
    .RC2(RC2),
    .Rd1(Rd1),
    .Rd2(Rd2),
    .FU_bits1(FU_bits1),
    .FU_bits2(FU_bits2),
    .RAW(RAW),
    .WAR(WAR),
    .WAW(WAW)
  );
endmodule

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


// IP VLNV: xilinx.com:module_ref:Issue_Unit:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module Superscalar_Processor_Issue_Unit_0_0 (
  FU0,
  FU1,
  FU2,
  FU3,
  FU4,
  FU5,
  FU6,
  FU7,
  PC0,
  PC1,
  PC2,
  PC3,
  PC4,
  PC5,
  PC6,
  PC7,
  Ready_bits,
  Issue_RS_b,
  Issue_RS_a,
  Issue_RS_ls,
  PC_bi,
  PC_ai,
  PC_a2i,
  PC_lsi,
  Issue_RS_a2,
  valid_issue_b,
  valid_issue_a,
  valid_issue_ls,
  valid_issue_a2
);

input wire [2 : 0] FU0;
input wire [2 : 0] FU1;
input wire [2 : 0] FU2;
input wire [2 : 0] FU3;
input wire [2 : 0] FU4;
input wire [2 : 0] FU5;
input wire [2 : 0] FU6;
input wire [2 : 0] FU7;
input wire [15 : 0] PC0;
input wire [15 : 0] PC1;
input wire [15 : 0] PC2;
input wire [15 : 0] PC3;
input wire [15 : 0] PC4;
input wire [15 : 0] PC5;
input wire [15 : 0] PC6;
input wire [15 : 0] PC7;
input wire [7 : 0] Ready_bits;
output wire [2 : 0] Issue_RS_b;
output wire [2 : 0] Issue_RS_a;
output wire [2 : 0] Issue_RS_ls;
output wire [15 : 0] PC_bi;
output wire [15 : 0] PC_ai;
output wire [15 : 0] PC_a2i;
output wire [15 : 0] PC_lsi;
output wire [2 : 0] Issue_RS_a2;
output wire valid_issue_b;
output wire valid_issue_a;
output wire valid_issue_ls;
output wire valid_issue_a2;

  Issue_Unit inst (
    .FU0(FU0),
    .FU1(FU1),
    .FU2(FU2),
    .FU3(FU3),
    .FU4(FU4),
    .FU5(FU5),
    .FU6(FU6),
    .FU7(FU7),
    .PC0(PC0),
    .PC1(PC1),
    .PC2(PC2),
    .PC3(PC3),
    .PC4(PC4),
    .PC5(PC5),
    .PC6(PC6),
    .PC7(PC7),
    .Ready_bits(Ready_bits),
    .Issue_RS_b(Issue_RS_b),
    .Issue_RS_a(Issue_RS_a),
    .Issue_RS_ls(Issue_RS_ls),
    .PC_bi(PC_bi),
    .PC_ai(PC_ai),
    .PC_a2i(PC_a2i),
    .PC_lsi(PC_lsi),
    .Issue_RS_a2(Issue_RS_a2),
    .valid_issue_b(valid_issue_b),
    .valid_issue_a(valid_issue_a),
    .valid_issue_ls(valid_issue_ls),
    .valid_issue_a2(valid_issue_a2)
  );
endmodule

//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
//Date        : Sun Dec 29 14:54:27 2024
//Host        : CHEEMz-PC running 64-bit major release  (build 9200)
//Command     : generate_target Superscalar_Processor.bd
//Design      : Superscalar_Processor
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "Superscalar_Processor,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=Superscalar_Processor,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=19,numReposBlks=19,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=17,numPkgbdBlks=0,bdsource=USER,synth_mode=OOC_per_IP}" *) (* HW_HANDOFF = "Superscalar_Processor.hwdef" *) 
module Superscalar_Processor
   (Busy_0,
    Imm1_1_out_0,
    Imm1_2_out_0,
    Imm2_l_0,
    PC_b_0,
    PC_l_0,
    ROB_tag_b_0,
    ROB_tag_l_0,
    SEI1_b_0,
    SEI1_l_0,
    SEI2_b_0,
    SEI2_l_0,
    b_ctrl_b_0,
    b_p_b_0,
    clk_0,
    empty_0,
    full_0,
    ls_ctrl_l_0,
    op_b_0,
    ra_b_0,
    ra_l_0,
    rb_b_0,
    rb_l_0,
    rst_0,
    spec_tag_b_0,
    spec_tag_l_0,
    stall_0,
    v_ra_b_0,
    v_ra_l_0,
    v_rb_b_0,
    v_rb_l_0,
    valid_b_0,
    valid_l_0,
    wC1_0,
    wC2_0,
    wZ1_0,
    wZ2_0);
  output [7:0]Busy_0;
  output [5:0]Imm1_1_out_0;
  output [5:0]Imm1_2_out_0;
  output [8:0]Imm2_l_0;
  output [15:0]PC_b_0;
  output [15:0]PC_l_0;
  output [2:0]ROB_tag_b_0;
  output [2:0]ROB_tag_l_0;
  output [15:0]SEI1_b_0;
  output [15:0]SEI1_l_0;
  output [15:0]SEI2_b_0;
  output [15:0]SEI2_l_0;
  output [3:0]b_ctrl_b_0;
  output b_p_b_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK_0 CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK_0, ASSOCIATED_RESET rst_0, CLK_DOMAIN Superscalar_Processor_clk_0, FREQ_HZ 100000000, INSERT_VIP 0, PHASE 0.000" *) input clk_0;
  output empty_0;
  output full_0;
  output [2:0]ls_ctrl_l_0;
  output [3:0]op_b_0;
  output [15:0]ra_b_0;
  output [15:0]ra_l_0;
  output [15:0]rb_b_0;
  output [15:0]rb_l_0;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RST_0 RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RST_0, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input rst_0;
  output [1:0]spec_tag_b_0;
  output [1:0]spec_tag_l_0;
  output stall_0;
  output v_ra_b_0;
  output v_ra_l_0;
  output v_rb_b_0;
  output v_rb_l_0;
  output valid_b_0;
  output valid_l_0;
  output wC1_0;
  output wC2_0;
  output wZ1_0;
  output wZ2_0;

  wire [15:0]ALU_0_PC_out;
  wire [2:0]ALU_0_ROB_tag_out;
  wire [15:0]ALU_0_alu_out;
  wire ALU_0_valid_out;
  wire [15:0]ALU_1_PC_out;
  wire [2:0]ALU_1_ROB_tag_out;
  wire [15:0]ALU_1_alu_out;
  wire ALU_1_valid_out;
  wire [1:0]Allocate_unit_0_FU_bits1_out;
  wire [1:0]Allocate_unit_0_FU_bits2_out;
  wire [2:0]Allocate_unit_0_RA1_out;
  wire [2:0]Allocate_unit_0_RA2_out;
  wire [2:0]Allocate_unit_0_RB1_out;
  wire [2:0]Allocate_unit_0_RB2_out;
  wire [2:0]Allocate_unit_0_RC1_out;
  wire [2:0]Allocate_unit_0_RC2_out;
  wire [23:0]Allocate_unit_0_ROB_input1;
  wire [23:0]Allocate_unit_0_ROB_input2;
  wire [2:0]Allocate_unit_0_ROB_tag1;
  wire [2:0]Allocate_unit_0_ROB_tag2;
  wire [136:0]Allocate_unit_0_RS_input1;
  wire [136:0]Allocate_unit_0_RS_input2;
  wire [2:0]Allocate_unit_0_RS_tag1;
  wire [2:0]Allocate_unit_0_RS_tag2;
  wire Allocate_unit_0_RegWrite1_out;
  wire Allocate_unit_0_RegWrite2_out;
  wire [3:0]Allocate_unit_0_op1_out;
  wire [3:0]Allocate_unit_0_op2_out;
  wire Allocate_unit_0_stall;
  wire Allocate_unit_0_valid1_out;
  wire Allocate_unit_0_valid2_out;
  wire [2:0]Control_Unit_0_FU_bits1;
  wire [2:0]Control_Unit_0_FU_bits2;
  wire [5:0]Control_Unit_0_a_ctrl1;
  wire [5:0]Control_Unit_0_a_ctrl2;
  wire [2:0]Control_Unit_0_b_ctrl1;
  wire [2:0]Control_Unit_0_b_ctrl2;
  wire [2:0]Control_Unit_0_ls_ctrl1;
  wire [2:0]Control_Unit_0_ls_ctrl2;
  wire [1:0]DispatchBuffer_0_CZ1_out;
  wire [1:0]DispatchBuffer_0_CZ2_out;
  wire [15:0]DispatchBuffer_0_IA1_out;
  wire [15:0]DispatchBuffer_0_IA2_out;
  wire [5:0]DispatchBuffer_0_Imm1_1_out;
  wire [5:0]DispatchBuffer_0_Imm1_2_out;
  wire [8:0]DispatchBuffer_0_Imm2_1_out;
  wire [8:0]DispatchBuffer_0_Imm2_2_out;
  wire [2:0]DispatchBuffer_0_RA1_out;
  wire [2:0]DispatchBuffer_0_RA2_out;
  wire [2:0]DispatchBuffer_0_RB1_out;
  wire [2:0]DispatchBuffer_0_RB2_out;
  wire [2:0]DispatchBuffer_0_RC1_out;
  wire [2:0]DispatchBuffer_0_RC2_out;
  wire [15:0]DispatchBuffer_0_SEI1_1_out;
  wire [15:0]DispatchBuffer_0_SEI1_2_out;
  wire [15:0]DispatchBuffer_0_SEI2_1_out;
  wire [15:0]DispatchBuffer_0_SEI2_2_out;
  wire DispatchBuffer_0_branch_predict1_out;
  wire DispatchBuffer_0_branch_predict2_out;
  wire DispatchBuffer_0_comp1_out;
  wire DispatchBuffer_0_comp2_out;
  wire DispatchBuffer_0_empty;
  wire DispatchBuffer_0_full;
  wire [3:0]DispatchBuffer_0_op1_out;
  wire [3:0]DispatchBuffer_0_op2_out;
  wire [1:0]DispatchBuffer_0_spec_tag1_out;
  wire [1:0]DispatchBuffer_0_spec_tag2_out;
  wire DispatchBuffer_0_valid_out1;
  wire DispatchBuffer_0_valid_out2;
  wire [15:0]Instruction_Memory_0_instr1;
  wire [15:0]Instruction_Memory_0_instr2;
  wire [2:0]Issue_Unit_0_Issue_RS_a;
  wire [2:0]Issue_Unit_0_Issue_RS_a2;
  wire [2:0]Issue_Unit_0_Issue_RS_b;
  wire [2:0]Issue_Unit_0_Issue_RS_ls;
  wire [15:0]Issue_Unit_0_PC_a2i;
  wire [15:0]Issue_Unit_0_PC_ai;
  wire [15:0]Issue_Unit_0_PC_bi;
  wire [15:0]Issue_Unit_0_PC_lsi;
  wire Issue_Unit_0_valid_issue_a;
  wire Issue_Unit_0_valid_issue_a2;
  wire Issue_Unit_0_valid_issue_b;
  wire Issue_Unit_0_valid_issue_ls;
  wire [15:0]PC_0_PC_out;
  wire RegWrite_Ctrl_0_RegWrite1;
  wire RegWrite_Ctrl_0_RegWrite2;
  wire [2:0]Register_File_1_RA1_t;
  wire [2:0]Register_File_1_RA2_t;
  wire [2:0]Register_File_1_RB1_t;
  wire [2:0]Register_File_1_RB2_t;
  wire [2:0]Register_File_1_RC2_t;
  wire [2:0]Register_File_1_RDD1_out;
  wire [2:0]Register_File_1_RDD2_out;
  wire [2:0]Register_File_1_Rc1_t;
  wire [15:0]Register_File_1_ra1;
  wire [15:0]Register_File_1_ra2;
  wire [15:0]Register_File_1_rb1;
  wire [15:0]Register_File_1_rb2;
  wire [15:0]Register_File_1_rc1;
  wire [15:0]Register_File_1_rc2;
  wire Register_File_1_v_ra1;
  wire Register_File_1_v_ra2;
  wire Register_File_1_v_rb1;
  wire Register_File_1_v_rb2;
  wire Register_File_1_v_rc1;
  wire Register_File_1_v_rc2;
  wire [2:0]Register_Interdepend_0_RAW;
  wire Register_Interdepend_0_WAR;
  wire Register_Interdepend_0_WAW;
  wire [7:0]Reorder_Buffer_0_Busy;
  wire [2:0]Reorder_Buffer_0_RD1;
  wire [2:0]Reorder_Buffer_0_RD2;
  wire [2:0]Reorder_Buffer_0_ROB1;
  wire [2:0]Reorder_Buffer_0_ROB2;
  wire [15:0]Reorder_Buffer_0_ROB_ra1;
  wire [15:0]Reorder_Buffer_0_ROB_ra2;
  wire [15:0]Reorder_Buffer_0_ROB_rb1;
  wire [15:0]Reorder_Buffer_0_ROB_rb2;
  wire [15:0]Reorder_Buffer_0_ROB_rc1;
  wire [15:0]Reorder_Buffer_0_ROB_rc2;
  wire [2:0]Reorder_Buffer_0_head;
  wire [15:0]Reorder_Buffer_0_reg_data1;
  wire [15:0]Reorder_Buffer_0_reg_data2;
  wire [2:0]Reorder_Buffer_0_tail;
  wire [7:0]Reorder_Buffer_0_valid_ROB;
  wire [2:0]Reorder_Buffer_0_wb1;
  wire [2:0]Reorder_Buffer_0_wb2;
  wire [7:0]Reservation_Station_0_Busy;
  wire [2:0]Reservation_Station_0_FU_bits0;
  wire [2:0]Reservation_Station_0_FU_bits1;
  wire [2:0]Reservation_Station_0_FU_bits2;
  wire [2:0]Reservation_Station_0_FU_bits3;
  wire [2:0]Reservation_Station_0_FU_bits4;
  wire [2:0]Reservation_Station_0_FU_bits5;
  wire [2:0]Reservation_Station_0_FU_bits6;
  wire [2:0]Reservation_Station_0_FU_bits7;
  wire [8:0]Reservation_Station_0_Imm2_l;
  wire [15:0]Reservation_Station_0_PC0;
  wire [15:0]Reservation_Station_0_PC1;
  wire [15:0]Reservation_Station_0_PC2;
  wire [15:0]Reservation_Station_0_PC3;
  wire [15:0]Reservation_Station_0_PC4;
  wire [15:0]Reservation_Station_0_PC5;
  wire [15:0]Reservation_Station_0_PC6;
  wire [15:0]Reservation_Station_0_PC7;
  wire [15:0]Reservation_Station_0_PC_a;
  wire [15:0]Reservation_Station_0_PC_a2;
  wire [15:0]Reservation_Station_0_PC_b;
  wire [15:0]Reservation_Station_0_PC_l;
  wire [2:0]Reservation_Station_0_ROB_tag_a;
  wire [2:0]Reservation_Station_0_ROB_tag_a2;
  wire [2:0]Reservation_Station_0_ROB_tag_b;
  wire [2:0]Reservation_Station_0_ROB_tag_l;
  wire [7:0]Reservation_Station_0_Ready;
  wire [15:0]Reservation_Station_0_SEI1_a;
  wire [15:0]Reservation_Station_0_SEI1_a2;
  wire [15:0]Reservation_Station_0_SEI1_b;
  wire [15:0]Reservation_Station_0_SEI1_l;
  wire [15:0]Reservation_Station_0_SEI2_b;
  wire [15:0]Reservation_Station_0_SEI2_l;
  wire [5:0]Reservation_Station_0_a_ctrl_a;
  wire [5:0]Reservation_Station_0_a_ctrl_a2;
  wire [3:0]Reservation_Station_0_b_ctrl_b;
  wire Reservation_Station_0_b_p_b;
  wire Reservation_Station_0_c_a;
  wire Reservation_Station_0_c_a2;
  wire [2:0]Reservation_Station_0_ls_ctrl_l;
  wire [3:0]Reservation_Station_0_op_b;
  wire [15:0]Reservation_Station_0_ra_a;
  wire [15:0]Reservation_Station_0_ra_a2;
  wire [15:0]Reservation_Station_0_ra_b;
  wire [15:0]Reservation_Station_0_ra_l;
  wire [15:0]Reservation_Station_0_rb_a;
  wire [15:0]Reservation_Station_0_rb_a2;
  wire [15:0]Reservation_Station_0_rb_b;
  wire [15:0]Reservation_Station_0_rb_l;
  wire [15:0]Reservation_Station_0_rc_a;
  wire [15:0]Reservation_Station_0_rc_a2;
  wire [1:0]Reservation_Station_0_spec_tag_a;
  wire [1:0]Reservation_Station_0_spec_tag_a2;
  wire [1:0]Reservation_Station_0_spec_tag_b;
  wire [1:0]Reservation_Station_0_spec_tag_l;
  wire Reservation_Station_0_v_c_a;
  wire Reservation_Station_0_v_c_a2;
  wire Reservation_Station_0_v_ra_a;
  wire Reservation_Station_0_v_ra_a2;
  wire Reservation_Station_0_v_ra_b;
  wire Reservation_Station_0_v_ra_l;
  wire Reservation_Station_0_v_rb_a;
  wire Reservation_Station_0_v_rb_a2;
  wire Reservation_Station_0_v_rb_b;
  wire Reservation_Station_0_v_rb_l;
  wire Reservation_Station_0_v_rc_a;
  wire Reservation_Station_0_v_rc_a2;
  wire Reservation_Station_0_v_z_a;
  wire Reservation_Station_0_v_z_a2;
  wire Reservation_Station_0_valid_a;
  wire Reservation_Station_0_valid_a2;
  wire Reservation_Station_0_valid_b;
  wire Reservation_Station_0_valid_l;
  wire Reservation_Station_0_z_a;
  wire Reservation_Station_0_z_a2;
  wire Valid_instruction_ch_0_valid1;
  wire Valid_instruction_ch_0_valid2;
  wire Write_back_signals_0_wC1;
  wire Write_back_signals_0_wC2;
  wire Write_back_signals_0_wR1;
  wire Write_back_signals_0_wR2;
  wire Write_back_signals_0_wZ1;
  wire Write_back_signals_0_wZ2;
  wire clk_0_1;
  wire [1:0]decode_0_CZ1;
  wire [1:0]decode_0_CZ2;
  wire [15:0]decode_0_IA1_out;
  wire [15:0]decode_0_IA2_out;
  wire [5:0]decode_0_Imm1_1;
  wire [5:0]decode_0_Imm1_2;
  wire [8:0]decode_0_Imm2_1;
  wire [8:0]decode_0_Imm2_2;
  wire [2:0]decode_0_RA1;
  wire [2:0]decode_0_RA2;
  wire [2:0]decode_0_RB1;
  wire [2:0]decode_0_RB2;
  wire [2:0]decode_0_RC1;
  wire [2:0]decode_0_RC2;
  wire [15:0]decode_0_SEI1_1;
  wire [15:0]decode_0_SEI1_2;
  wire [15:0]decode_0_SEI2_1;
  wire [15:0]decode_0_SEI2_2;
  wire decode_0_branch_predict1_out;
  wire decode_0_branch_predict2_out;
  wire decode_0_comp1;
  wire decode_0_comp2;
  wire [3:0]decode_0_op1;
  wire [3:0]decode_0_op2;
  wire [1:0]decode_0_spec_tag1;
  wire [1:0]decode_0_spec_tag2;
  wire decode_0_valid1_out;
  wire decode_0_valid2_out;
  wire [15:0]decode_buffer_0_address_out1;
  wire [15:0]decode_buffer_0_address_out2;
  wire decode_buffer_0_branch_predict1_out;
  wire decode_buffer_0_branch_predict2_out;
  wire [15:0]decode_buffer_0_instr1_out;
  wire [15:0]decode_buffer_0_instr2_out;
  wire decode_buffer_0_valid1_out;
  wire decode_buffer_0_valid2_out;
  wire rst_0_1;
  wire [0:0]xlconstant_0_dout;
  wire [0:0]xlconstant_1_dout;

  assign Busy_0[7:0] = Reorder_Buffer_0_Busy;
  assign Imm1_1_out_0[5:0] = DispatchBuffer_0_Imm1_1_out;
  assign Imm1_2_out_0[5:0] = DispatchBuffer_0_Imm1_2_out;
  assign Imm2_l_0[8:0] = Reservation_Station_0_Imm2_l;
  assign PC_b_0[15:0] = Reservation_Station_0_PC_b;
  assign PC_l_0[15:0] = Reservation_Station_0_PC_l;
  assign ROB_tag_b_0[2:0] = Reservation_Station_0_ROB_tag_b;
  assign ROB_tag_l_0[2:0] = Reservation_Station_0_ROB_tag_l;
  assign SEI1_b_0[15:0] = Reservation_Station_0_SEI1_b;
  assign SEI1_l_0[15:0] = Reservation_Station_0_SEI1_l;
  assign SEI2_b_0[15:0] = Reservation_Station_0_SEI2_b;
  assign SEI2_l_0[15:0] = Reservation_Station_0_SEI2_l;
  assign b_ctrl_b_0[3:0] = Reservation_Station_0_b_ctrl_b;
  assign b_p_b_0 = Reservation_Station_0_b_p_b;
  assign clk_0_1 = clk_0;
  assign empty_0 = DispatchBuffer_0_empty;
  assign full_0 = DispatchBuffer_0_full;
  assign ls_ctrl_l_0[2:0] = Reservation_Station_0_ls_ctrl_l;
  assign op_b_0[3:0] = Reservation_Station_0_op_b;
  assign ra_b_0[15:0] = Reservation_Station_0_ra_b;
  assign ra_l_0[15:0] = Reservation_Station_0_ra_l;
  assign rb_b_0[15:0] = Reservation_Station_0_rb_b;
  assign rb_l_0[15:0] = Reservation_Station_0_rb_l;
  assign rst_0_1 = rst_0;
  assign spec_tag_b_0[1:0] = Reservation_Station_0_spec_tag_b;
  assign spec_tag_l_0[1:0] = Reservation_Station_0_spec_tag_l;
  assign stall_0 = Allocate_unit_0_stall;
  assign v_ra_b_0 = Reservation_Station_0_v_ra_b;
  assign v_ra_l_0 = Reservation_Station_0_v_ra_l;
  assign v_rb_b_0 = Reservation_Station_0_v_rb_b;
  assign v_rb_l_0 = Reservation_Station_0_v_rb_l;
  assign valid_b_0 = Reservation_Station_0_valid_b;
  assign valid_l_0 = Reservation_Station_0_valid_l;
  assign wC1_0 = Write_back_signals_0_wC1;
  assign wC2_0 = Write_back_signals_0_wC2;
  assign wZ1_0 = Write_back_signals_0_wZ1;
  assign wZ2_0 = Write_back_signals_0_wZ2;
  Superscalar_Processor_ALU_0_0 ALU_0
       (.PC(Reservation_Station_0_PC_a),
        .PC_out(ALU_0_PC_out),
        .ROB_tag(Reservation_Station_0_ROB_tag_a),
        .ROB_tag_out(ALU_0_ROB_tag_out),
        .SEI1(Reservation_Station_0_SEI1_a),
        .a_ctrl(Reservation_Station_0_a_ctrl_a),
        .alu_out(ALU_0_alu_out),
        .c(Reservation_Station_0_c_a),
        .ra(Reservation_Station_0_ra_a),
        .rb(Reservation_Station_0_rb_a),
        .rc(Reservation_Station_0_rc_a),
        .spec_tag(Reservation_Station_0_spec_tag_a),
        .v_c(Reservation_Station_0_v_c_a),
        .v_ra(Reservation_Station_0_v_ra_a),
        .v_rb(Reservation_Station_0_v_rb_a),
        .v_rc(Reservation_Station_0_v_rc_a),
        .v_z(Reservation_Station_0_v_z_a),
        .valid(Reservation_Station_0_valid_a),
        .valid_out(ALU_0_valid_out),
        .z(Reservation_Station_0_z_a));
  Superscalar_Processor_ALU_1_0 ALU_1
       (.PC(Reservation_Station_0_PC_a2),
        .PC_out(ALU_1_PC_out),
        .ROB_tag(Reservation_Station_0_ROB_tag_a2),
        .ROB_tag_out(ALU_1_ROB_tag_out),
        .SEI1(Reservation_Station_0_SEI1_a2),
        .a_ctrl(Reservation_Station_0_a_ctrl_a2),
        .alu_out(ALU_1_alu_out),
        .c(Reservation_Station_0_c_a2),
        .ra(Reservation_Station_0_ra_a2),
        .rb(Reservation_Station_0_rb_a2),
        .rc(Reservation_Station_0_rc_a2),
        .spec_tag(Reservation_Station_0_spec_tag_a2),
        .v_c(Reservation_Station_0_v_c_a2),
        .v_ra(Reservation_Station_0_v_ra_a2),
        .v_rb(Reservation_Station_0_v_rb_a2),
        .v_rc(Reservation_Station_0_v_rc_a2),
        .v_z(Reservation_Station_0_v_z_a2),
        .valid(Reservation_Station_0_valid_a2),
        .valid_out(ALU_1_valid_out),
        .z(Reservation_Station_0_z_a2));
  Superscalar_Processor_Allocate_unit_0_0 Allocate_unit_0
       (.CWrite1(xlconstant_1_dout),
        .CWrite2(xlconstant_1_dout),
        .FU_bits1(Control_Unit_0_FU_bits1),
        .FU_bits1_out(Allocate_unit_0_FU_bits1_out),
        .FU_bits2(Control_Unit_0_FU_bits2),
        .FU_bits2_out(Allocate_unit_0_FU_bits2_out),
        .Imm2_1(DispatchBuffer_0_Imm2_1_out),
        .Imm2_2(DispatchBuffer_0_Imm2_2_out),
        .PC1(DispatchBuffer_0_IA1_out),
        .PC2(DispatchBuffer_0_IA2_out),
        .RA1_out(Allocate_unit_0_RA1_out),
        .RA2_out(Allocate_unit_0_RA2_out),
        .RAA1(DispatchBuffer_0_RA1_out),
        .RAA2(DispatchBuffer_0_RA2_out),
        .RB1_out(Allocate_unit_0_RB1_out),
        .RB2_out(Allocate_unit_0_RB2_out),
        .RBB1(DispatchBuffer_0_RB1_out),
        .RBB2(DispatchBuffer_0_RB2_out),
        .RC1_out(Allocate_unit_0_RC1_out),
        .RC2_out(Allocate_unit_0_RC2_out),
        .RCC1(DispatchBuffer_0_RC1_out),
        .RCC2(DispatchBuffer_0_RC2_out),
        .ROB_head(Reorder_Buffer_0_head),
        .ROB_input1(Allocate_unit_0_ROB_input1),
        .ROB_input2(Allocate_unit_0_ROB_input2),
        .ROB_tag1(Allocate_unit_0_ROB_tag1),
        .ROB_tag2(Allocate_unit_0_ROB_tag2),
        .ROB_tail(Reorder_Buffer_0_tail),
        .RR_stall(xlconstant_0_dout),
        .RS_free_bitmap(Reservation_Station_0_Busy),
        .RS_input1(Allocate_unit_0_RS_input1),
        .RS_input2(Allocate_unit_0_RS_input2),
        .RS_tag1(Allocate_unit_0_RS_tag1),
        .RS_tag2(Allocate_unit_0_RS_tag2),
        .Rd1(Register_File_1_RDD1_out),
        .Rd2(Register_File_1_RDD2_out),
        .RegWrite1(RegWrite_Ctrl_0_RegWrite1),
        .RegWrite1_out(Allocate_unit_0_RegWrite1_out),
        .RegWrite2(RegWrite_Ctrl_0_RegWrite2),
        .RegWrite2_out(Allocate_unit_0_RegWrite2_out),
        .SEI1_1(DispatchBuffer_0_SEI1_1_out),
        .SEI1_2(DispatchBuffer_0_SEI1_2_out),
        .SEI2_1(DispatchBuffer_0_SEI2_1_out),
        .SEI2_2(DispatchBuffer_0_SEI2_2_out),
        .ZWrite1(xlconstant_1_dout),
        .ZWrite2(xlconstant_1_dout),
        .a_ctrl1(Control_Unit_0_a_ctrl1),
        .a_ctrl2(Control_Unit_0_a_ctrl2),
        .b_ctrl1(Control_Unit_0_b_ctrl1),
        .b_ctrl2(Control_Unit_0_b_ctrl2),
        .branch_predict1(DispatchBuffer_0_branch_predict1_out),
        .branch_predict2(DispatchBuffer_0_branch_predict2_out),
        .c1(xlconstant_1_dout),
        .c2(xlconstant_1_dout),
        .ls_ctrl1(Control_Unit_0_ls_ctrl1),
        .ls_ctrl2(Control_Unit_0_ls_ctrl2),
        .op1(DispatchBuffer_0_op1_out),
        .op1_out(Allocate_unit_0_op1_out),
        .op2(DispatchBuffer_0_op2_out),
        .op2_out(Allocate_unit_0_op2_out),
        .ra1(Register_File_1_ra1),
        .ra2(Register_File_1_ra2),
        .rb1(Register_File_1_rb1),
        .rb2(Register_File_1_rb2),
        .rc1(Register_File_1_rc1),
        .rc2(Register_File_1_rc2),
        .spec_tag1(DispatchBuffer_0_spec_tag1_out),
        .spec_tag2(DispatchBuffer_0_spec_tag2_out),
        .stall(Allocate_unit_0_stall),
        .v_c1(xlconstant_1_dout),
        .v_c2(xlconstant_1_dout),
        .v_ra1(Register_File_1_v_ra1),
        .v_ra2(Register_File_1_v_ra2),
        .v_rb1(Register_File_1_v_rb1),
        .v_rb2(Register_File_1_v_rb2),
        .v_rc1(Register_File_1_v_rc1),
        .v_rc2(Register_File_1_v_rc2),
        .v_z1(xlconstant_1_dout),
        .v_z2(xlconstant_1_dout),
        .valid1(DispatchBuffer_0_valid_out1),
        .valid1_out(Allocate_unit_0_valid1_out),
        .valid2(DispatchBuffer_0_valid_out2),
        .valid2_out(Allocate_unit_0_valid2_out),
        .z1(xlconstant_1_dout),
        .z2(xlconstant_1_dout));
  Superscalar_Processor_Control_Unit_0_0 Control_Unit_0
       (.CZ1(DispatchBuffer_0_CZ1_out),
        .CZ2(DispatchBuffer_0_CZ2_out),
        .Comp1(DispatchBuffer_0_comp1_out),
        .Comp2(DispatchBuffer_0_comp2_out),
        .FU_bits1(Control_Unit_0_FU_bits1),
        .FU_bits2(Control_Unit_0_FU_bits2),
        .RegWrite1(RegWrite_Ctrl_0_RegWrite1),
        .RegWrite2(RegWrite_Ctrl_0_RegWrite2),
        .a_ctrl1(Control_Unit_0_a_ctrl1),
        .a_ctrl2(Control_Unit_0_a_ctrl2),
        .b_ctrl1(Control_Unit_0_b_ctrl1),
        .b_ctrl2(Control_Unit_0_b_ctrl2),
        .ls_ctrl1(Control_Unit_0_ls_ctrl1),
        .ls_ctrl2(Control_Unit_0_ls_ctrl2),
        .op1(DispatchBuffer_0_op1_out),
        .op2(DispatchBuffer_0_op2_out));
  Superscalar_Processor_DispatchBuffer_0_0 DispatchBuffer_0
       (.CZ1_in(decode_0_CZ1),
        .CZ1_out(DispatchBuffer_0_CZ1_out),
        .CZ2_in(decode_0_CZ2),
        .CZ2_out(DispatchBuffer_0_CZ2_out),
        .IA1_in(decode_0_IA1_out),
        .IA1_out(DispatchBuffer_0_IA1_out),
        .IA2_in(decode_0_IA2_out),
        .IA2_out(DispatchBuffer_0_IA2_out),
        .Imm1_1_in(decode_0_Imm1_1),
        .Imm1_1_out(DispatchBuffer_0_Imm1_1_out),
        .Imm1_2_in(decode_0_Imm1_2),
        .Imm1_2_out(DispatchBuffer_0_Imm1_2_out),
        .Imm2_1_in(decode_0_Imm2_1),
        .Imm2_1_out(DispatchBuffer_0_Imm2_1_out),
        .Imm2_2_in(decode_0_Imm2_2),
        .Imm2_2_out(DispatchBuffer_0_Imm2_2_out),
        .RA1_in(decode_0_RA1),
        .RA1_out(DispatchBuffer_0_RA1_out),
        .RA2_in(decode_0_RA2),
        .RA2_out(DispatchBuffer_0_RA2_out),
        .RB1_in(decode_0_RB1),
        .RB1_out(DispatchBuffer_0_RB1_out),
        .RB2_in(decode_0_RB2),
        .RB2_out(DispatchBuffer_0_RB2_out),
        .RC1_in(decode_0_RC1),
        .RC1_out(DispatchBuffer_0_RC1_out),
        .RC2_in(decode_0_RC2),
        .RC2_out(DispatchBuffer_0_RC2_out),
        .SEI1_1_in(decode_0_SEI1_1),
        .SEI1_1_out(DispatchBuffer_0_SEI1_1_out),
        .SEI1_2_in(decode_0_SEI1_2),
        .SEI1_2_out(DispatchBuffer_0_SEI1_2_out),
        .SEI2_1_in(decode_0_SEI2_1),
        .SEI2_1_out(DispatchBuffer_0_SEI2_1_out),
        .SEI2_2_in(decode_0_SEI2_2),
        .SEI2_2_out(DispatchBuffer_0_SEI2_2_out),
        .branch_predict1_in(decode_0_branch_predict1_out),
        .branch_predict1_out(DispatchBuffer_0_branch_predict1_out),
        .branch_predict2_in(decode_0_branch_predict2_out),
        .branch_predict2_out(DispatchBuffer_0_branch_predict2_out),
        .clk(clk_0_1),
        .comp1_in(decode_0_comp1),
        .comp1_out(DispatchBuffer_0_comp1_out),
        .comp2_in(decode_0_comp2),
        .comp2_out(DispatchBuffer_0_comp2_out),
        .empty(DispatchBuffer_0_empty),
        .full(DispatchBuffer_0_full),
        .issue1(xlconstant_1_dout),
        .issue2(xlconstant_1_dout),
        .op1_in(decode_0_op1),
        .op1_out(DispatchBuffer_0_op1_out),
        .op2_in(decode_0_op2),
        .op2_out(DispatchBuffer_0_op2_out),
        .rst(rst_0_1),
        .spec_tag1_in(decode_0_spec_tag1),
        .spec_tag1_out(DispatchBuffer_0_spec_tag1_out),
        .spec_tag2_in(decode_0_spec_tag2),
        .spec_tag2_out(DispatchBuffer_0_spec_tag2_out),
        .stall(xlconstant_0_dout),
        .valid_in1(decode_0_valid1_out),
        .valid_in2(decode_0_valid2_out),
        .valid_out1(DispatchBuffer_0_valid_out1),
        .valid_out2(DispatchBuffer_0_valid_out2));
  Superscalar_Processor_Instruction_Memory_0_0 Instruction_Memory_0
       (.PC(PC_0_PC_out),
        .instr1(Instruction_Memory_0_instr1),
        .instr2(Instruction_Memory_0_instr2),
        .rst(rst_0_1));
  Superscalar_Processor_Issue_Unit_0_0 Issue_Unit_0
       (.FU0(Reservation_Station_0_FU_bits0),
        .FU1(Reservation_Station_0_FU_bits1),
        .FU2(Reservation_Station_0_FU_bits2),
        .FU3(Reservation_Station_0_FU_bits3),
        .FU4(Reservation_Station_0_FU_bits4),
        .FU5(Reservation_Station_0_FU_bits5),
        .FU6(Reservation_Station_0_FU_bits6),
        .FU7(Reservation_Station_0_FU_bits7),
        .Issue_RS_a(Issue_Unit_0_Issue_RS_a),
        .Issue_RS_a2(Issue_Unit_0_Issue_RS_a2),
        .Issue_RS_b(Issue_Unit_0_Issue_RS_b),
        .Issue_RS_ls(Issue_Unit_0_Issue_RS_ls),
        .PC0(Reservation_Station_0_PC0),
        .PC1(Reservation_Station_0_PC1),
        .PC2(Reservation_Station_0_PC2),
        .PC3(Reservation_Station_0_PC3),
        .PC4(Reservation_Station_0_PC4),
        .PC5(Reservation_Station_0_PC5),
        .PC6(Reservation_Station_0_PC6),
        .PC7(Reservation_Station_0_PC7),
        .PC_a2i(Issue_Unit_0_PC_a2i),
        .PC_ai(Issue_Unit_0_PC_ai),
        .PC_bi(Issue_Unit_0_PC_bi),
        .PC_lsi(Issue_Unit_0_PC_lsi),
        .Ready_bits(Reservation_Station_0_Ready),
        .valid_issue_a(Issue_Unit_0_valid_issue_a),
        .valid_issue_a2(Issue_Unit_0_valid_issue_a2),
        .valid_issue_b(Issue_Unit_0_valid_issue_b),
        .valid_issue_ls(Issue_Unit_0_valid_issue_ls));
  Superscalar_Processor_PC_0_0 PC_0
       (.PC_Write(xlconstant_1_dout),
        .PC_in(PC_0_PC_out),
        .PC_out(PC_0_PC_out),
        .branch_predict1(xlconstant_0_dout),
        .branch_predict2(xlconstant_0_dout),
        .branch_predict_PC1({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,xlconstant_0_dout}),
        .branch_predict_PC2({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,xlconstant_0_dout}),
        .branch_resolve(xlconstant_0_dout),
        .branch_resolve_PC({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,xlconstant_0_dout}),
        .clk(clk_0_1),
        .rst(rst_0_1));
  Superscalar_Processor_RegWrite_Ctrl_0_0 RegWrite_Ctrl_0
       (.RegWrite1(RegWrite_Ctrl_0_RegWrite1),
        .RegWrite2(RegWrite_Ctrl_0_RegWrite2),
        .op1(DispatchBuffer_0_op1_out),
        .op2(DispatchBuffer_0_op2_out),
        .stall(xlconstant_0_dout),
        .valid1(DispatchBuffer_0_valid_out1),
        .valid2(DispatchBuffer_0_valid_out2));
  Superscalar_Processor_Register_File_1_0 Register_File_1
       (.FU_bits1(Allocate_unit_0_FU_bits1_out),
        .FU_bits2(Allocate_unit_0_FU_bits2_out),
        .RA1_t(Register_File_1_RA1_t),
        .RA2_t(Register_File_1_RA2_t),
        .RAA1(Allocate_unit_0_RA1_out),
        .RAA2(Allocate_unit_0_RA2_out),
        .RAW(Register_Interdepend_0_RAW),
        .RB1_t(Register_File_1_RB1_t),
        .RB2_t(Register_File_1_RB2_t),
        .RBB1(Allocate_unit_0_RB1_out),
        .RBB2(Allocate_unit_0_RB2_out),
        .RC2_t(Register_File_1_RC2_t),
        .RCC1(Allocate_unit_0_RC1_out),
        .RCC2(Allocate_unit_0_RC2_out),
        .RD1(Reorder_Buffer_0_RD1),
        .RD2(Reorder_Buffer_0_RD2),
        .RDD1_out(Register_File_1_RDD1_out),
        .RDD2_out(Register_File_1_RDD2_out),
        .ROB1(Reorder_Buffer_0_ROB1),
        .ROB2(Reorder_Buffer_0_ROB2),
        .ROB_a2_cdb(ALU_1_ROB_tag_out),
        .ROB_a_cdb(ALU_0_ROB_tag_out),
        .ROB_b_cdb({1'b0,1'b0,xlconstant_0_dout}),
        .ROB_ls_cdb({1'b0,1'b0,xlconstant_0_dout}),
        .ROB_ra1(Reorder_Buffer_0_ROB_ra1),
        .ROB_ra2(Reorder_Buffer_0_ROB_ra2),
        .ROB_rb1(Reorder_Buffer_0_ROB_rb1),
        .ROB_rb2(Reorder_Buffer_0_ROB_rb2),
        .ROB_rc1(Reorder_Buffer_0_ROB_rc1),
        .ROB_rc2(Reorder_Buffer_0_ROB_rc2),
        .ROB_tag1(Allocate_unit_0_ROB_tag1),
        .ROB_tag2(Allocate_unit_0_ROB_tag2),
        .Rc1_t(Register_File_1_Rc1_t),
        .RegWrite1(Allocate_unit_0_RegWrite1_out),
        .RegWrite2(Allocate_unit_0_RegWrite2_out),
        .WAR(Register_Interdepend_0_WAR),
        .WAW(Register_Interdepend_0_WAW),
        .alu2_out(ALU_1_alu_out),
        .alu_out(ALU_0_alu_out),
        .clk(clk_0_1),
        .dm_data({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,xlconstant_0_dout}),
        .op1(Allocate_unit_0_op1_out),
        .op2(Allocate_unit_0_op2_out),
        .ra1(Register_File_1_ra1),
        .ra2(Register_File_1_ra2),
        .rb1(Register_File_1_rb1),
        .rb2(Register_File_1_rb2),
        .rc1(Register_File_1_rc1),
        .rc2(Register_File_1_rc2),
        .reg_data1(Reorder_Buffer_0_reg_data1),
        .reg_data2(Reorder_Buffer_0_reg_data2),
        .reg_data_b({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,xlconstant_0_dout}),
        .rst(rst_0_1),
        .v_ra1(Register_File_1_v_ra1),
        .v_ra2(Register_File_1_v_ra2),
        .v_rb1(Register_File_1_v_rb1),
        .v_rb2(Register_File_1_v_rb2),
        .v_rc1(Register_File_1_v_rc1),
        .v_rc2(Register_File_1_v_rc2),
        .valid1(Allocate_unit_0_valid1_out),
        .valid2(Allocate_unit_0_valid2_out),
        .valid_ROB(Reorder_Buffer_0_valid_ROB),
        .valid_a2_cdb(ALU_1_valid_out),
        .valid_a_cdb(ALU_0_valid_out),
        .valid_b_cdb(xlconstant_0_dout),
        .valid_ls_cdb(xlconstant_0_dout),
        .wb1(Write_back_signals_0_wR1),
        .wb2(Write_back_signals_0_wR2));
  Superscalar_Processor_Register_Interdepend_0_0 Register_Interdepend_0
       (.FU_bits1(Control_Unit_0_FU_bits1),
        .FU_bits2(Control_Unit_0_FU_bits2),
        .RA1(DispatchBuffer_0_RA1_out),
        .RA2(DispatchBuffer_0_RA2_out),
        .RAW(Register_Interdepend_0_RAW),
        .RB1(DispatchBuffer_0_RB1_out),
        .RB2(DispatchBuffer_0_RB2_out),
        .RC1(DispatchBuffer_0_RC1_out),
        .RC2(DispatchBuffer_0_RC2_out),
        .RW1(RegWrite_Ctrl_0_RegWrite1),
        .RW2(RegWrite_Ctrl_0_RegWrite2),
        .Rd1(Register_File_1_RDD1_out),
        .Rd2(Register_File_1_RDD2_out),
        .WAR(Register_Interdepend_0_WAR),
        .WAW(Register_Interdepend_0_WAW));
  Superscalar_Processor_Reorder_Buffer_0_0 Reorder_Buffer_0
       (.Busy(Reorder_Buffer_0_Busy),
        .PC_a2_cdb(ALU_1_PC_out),
        .PC_a2i(Issue_Unit_0_PC_a2i),
        .PC_a_cdb(ALU_0_PC_out),
        .PC_ai(Issue_Unit_0_PC_ai),
        .PC_b_cdb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,xlconstant_1_dout}),
        .PC_bi(Issue_Unit_0_PC_bi),
        .PC_ls_cdb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,xlconstant_1_dout}),
        .PC_lsi(Issue_Unit_0_PC_lsi),
        .RA1_t(Register_File_1_RA1_t),
        .RA2_t(Register_File_1_RA2_t),
        .RB1_t(Register_File_1_RB1_t),
        .RB2_t(Register_File_1_RB2_t),
        .RC1_t(Register_File_1_Rc1_t),
        .RC2_t(Register_File_1_RC2_t),
        .RD1(Reorder_Buffer_0_RD1),
        .RD2(Reorder_Buffer_0_RD2),
        .ROB1(Reorder_Buffer_0_ROB1),
        .ROB2(Reorder_Buffer_0_ROB2),
        .ROB_a2_cdb(ALU_1_ROB_tag_out),
        .ROB_a_cdb(ALU_0_ROB_tag_out),
        .ROB_b_cdb({1'b0,1'b0,xlconstant_1_dout}),
        .ROB_input1(Allocate_unit_0_ROB_input1),
        .ROB_input2(Allocate_unit_0_ROB_input2),
        .ROB_ls_cdb({1'b0,1'b0,xlconstant_1_dout}),
        .ROB_ra1(Reorder_Buffer_0_ROB_ra1),
        .ROB_ra2(Reorder_Buffer_0_ROB_ra2),
        .ROB_rb1(Reorder_Buffer_0_ROB_rb1),
        .ROB_rb2(Reorder_Buffer_0_ROB_rb2),
        .ROB_rc1(Reorder_Buffer_0_ROB_rc1),
        .ROB_rc2(Reorder_Buffer_0_ROB_rc2),
        .ROB_tag1(Allocate_unit_0_ROB_tag1),
        .ROB_tag2(Allocate_unit_0_ROB_tag2),
        .alu2_out(ALU_1_alu_out),
        .alu_out(ALU_0_alu_out),
        .clk(clk_0_1),
        .dm_data({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,xlconstant_1_dout}),
        .head(Reorder_Buffer_0_head),
        .misprediction(xlconstant_0_dout),
        .reg_data1(Reorder_Buffer_0_reg_data1),
        .reg_data2(Reorder_Buffer_0_reg_data2),
        .reg_data_b({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,xlconstant_1_dout}),
        .rst(rst_0_1),
        .spec_tag_b({1'b0,xlconstant_1_dout}),
        .tail(Reorder_Buffer_0_tail),
        .valid1(Allocate_unit_0_valid1_out),
        .valid2(Allocate_unit_0_valid2_out),
        .valid_ROB(Reorder_Buffer_0_valid_ROB),
        .valid_a2_cdb(ALU_1_valid_out),
        .valid_a2i(Issue_Unit_0_valid_issue_a2),
        .valid_a_cdb(ALU_0_valid_out),
        .valid_ai(Issue_Unit_0_valid_issue_a),
        .valid_b_cdb(xlconstant_0_dout),
        .valid_bi(Issue_Unit_0_valid_issue_b),
        .valid_ls_cdb(xlconstant_0_dout),
        .valid_lsi(Issue_Unit_0_valid_issue_ls),
        .wb1(Reorder_Buffer_0_wb1),
        .wb2(Reorder_Buffer_0_wb2));
  Superscalar_Processor_Reservation_Station_0_0 Reservation_Station_0
       (.Busy(Reservation_Station_0_Busy),
        .FU_bits0(Reservation_Station_0_FU_bits0),
        .FU_bits1(Reservation_Station_0_FU_bits1),
        .FU_bits2(Reservation_Station_0_FU_bits2),
        .FU_bits3(Reservation_Station_0_FU_bits3),
        .FU_bits4(Reservation_Station_0_FU_bits4),
        .FU_bits5(Reservation_Station_0_FU_bits5),
        .FU_bits6(Reservation_Station_0_FU_bits6),
        .FU_bits7(Reservation_Station_0_FU_bits7),
        .Imm2_l(Reservation_Station_0_Imm2_l),
        .PC0(Reservation_Station_0_PC0),
        .PC1(Reservation_Station_0_PC1),
        .PC2(Reservation_Station_0_PC2),
        .PC3(Reservation_Station_0_PC3),
        .PC4(Reservation_Station_0_PC4),
        .PC5(Reservation_Station_0_PC5),
        .PC6(Reservation_Station_0_PC6),
        .PC7(Reservation_Station_0_PC7),
        .PC_a(Reservation_Station_0_PC_a),
        .PC_a2(Reservation_Station_0_PC_a2),
        .PC_b(Reservation_Station_0_PC_b),
        .PC_l(Reservation_Station_0_PC_l),
        .ROB1(Reorder_Buffer_0_ROB1),
        .ROB2(Reorder_Buffer_0_ROB2),
        .ROB_a2_cdb(ALU_1_ROB_tag_out),
        .ROB_a_cdb(ALU_0_ROB_tag_out),
        .ROB_b_cdb({1'b0,1'b0,xlconstant_0_dout}),
        .ROB_ls_cdb({1'b0,1'b0,xlconstant_0_dout}),
        .ROB_tag_a(Reservation_Station_0_ROB_tag_a),
        .ROB_tag_a2(Reservation_Station_0_ROB_tag_a2),
        .ROB_tag_b(Reservation_Station_0_ROB_tag_b),
        .ROB_tag_l(Reservation_Station_0_ROB_tag_l),
        .RS_input1(Allocate_unit_0_RS_input1),
        .RS_input2(Allocate_unit_0_RS_input2),
        .RS_tag1(Allocate_unit_0_RS_tag1),
        .RS_tag2(Allocate_unit_0_RS_tag2),
        .Ready(Reservation_Station_0_Ready),
        .SEI1_a(Reservation_Station_0_SEI1_a),
        .SEI1_a2(Reservation_Station_0_SEI1_a2),
        .SEI1_b(Reservation_Station_0_SEI1_b),
        .SEI1_l(Reservation_Station_0_SEI1_l),
        .SEI2_b(Reservation_Station_0_SEI2_b),
        .SEI2_l(Reservation_Station_0_SEI2_l),
        .a_ctrl_a(Reservation_Station_0_a_ctrl_a),
        .a_ctrl_a2(Reservation_Station_0_a_ctrl_a2),
        .alu2_out(ALU_1_alu_out),
        .alu_out(ALU_0_alu_out),
        .b_ctrl_b(Reservation_Station_0_b_ctrl_b),
        .b_p_b(Reservation_Station_0_b_p_b),
        .c_a(Reservation_Station_0_c_a),
        .c_a2(Reservation_Station_0_c_a2),
        .clk(clk_0_1),
        .dm_data({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,xlconstant_0_dout}),
        .issue_RS_a(Issue_Unit_0_Issue_RS_a),
        .issue_RS_a2(Issue_Unit_0_Issue_RS_a2),
        .issue_RS_b(Issue_Unit_0_Issue_RS_b),
        .issue_RS_ls(Issue_Unit_0_Issue_RS_ls),
        .ls_ctrl_l(Reservation_Station_0_ls_ctrl_l),
        .op_b(Reservation_Station_0_op_b),
        .ra_a(Reservation_Station_0_ra_a),
        .ra_a2(Reservation_Station_0_ra_a2),
        .ra_b(Reservation_Station_0_ra_b),
        .ra_l(Reservation_Station_0_ra_l),
        .rb_a(Reservation_Station_0_rb_a),
        .rb_a2(Reservation_Station_0_rb_a2),
        .rb_b(Reservation_Station_0_rb_b),
        .rb_l(Reservation_Station_0_rb_l),
        .rc_a(Reservation_Station_0_rc_a),
        .rc_a2(Reservation_Station_0_rc_a2),
        .reg_data1(Reorder_Buffer_0_reg_data1),
        .reg_data2(Reorder_Buffer_0_reg_data2),
        .reg_data_b({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,xlconstant_0_dout}),
        .rst(rst_0_1),
        .spec_tag_a(Reservation_Station_0_spec_tag_a),
        .spec_tag_a2(Reservation_Station_0_spec_tag_a2),
        .spec_tag_b(Reservation_Station_0_spec_tag_b),
        .spec_tag_l(Reservation_Station_0_spec_tag_l),
        .v_c_a(Reservation_Station_0_v_c_a),
        .v_c_a2(Reservation_Station_0_v_c_a2),
        .v_ra_a(Reservation_Station_0_v_ra_a),
        .v_ra_a2(Reservation_Station_0_v_ra_a2),
        .v_ra_b(Reservation_Station_0_v_ra_b),
        .v_ra_l(Reservation_Station_0_v_ra_l),
        .v_rb_a(Reservation_Station_0_v_rb_a),
        .v_rb_a2(Reservation_Station_0_v_rb_a2),
        .v_rb_b(Reservation_Station_0_v_rb_b),
        .v_rb_l(Reservation_Station_0_v_rb_l),
        .v_rc_a(Reservation_Station_0_v_rc_a),
        .v_rc_a2(Reservation_Station_0_v_rc_a2),
        .v_z_a(Reservation_Station_0_v_z_a),
        .v_z_a2(Reservation_Station_0_v_z_a2),
        .valid1(Allocate_unit_0_valid1_out),
        .valid2(Allocate_unit_0_valid2_out),
        .valid_a(Reservation_Station_0_valid_a),
        .valid_a2(Reservation_Station_0_valid_a2),
        .valid_a2_cdb(ALU_1_valid_out),
        .valid_a_cdb(ALU_0_valid_out),
        .valid_b(Reservation_Station_0_valid_b),
        .valid_b_cdb(xlconstant_0_dout),
        .valid_issue_a(Issue_Unit_0_valid_issue_a),
        .valid_issue_a2(Issue_Unit_0_valid_issue_a2),
        .valid_issue_b(Issue_Unit_0_valid_issue_b),
        .valid_issue_ls(Issue_Unit_0_valid_issue_ls),
        .valid_l(Reservation_Station_0_valid_l),
        .valid_ls_cdb(xlconstant_0_dout),
        .wb1(Write_back_signals_0_wR1),
        .wb2(Write_back_signals_0_wR2),
        .z_a(Reservation_Station_0_z_a),
        .z_a2(Reservation_Station_0_z_a2));
  Superscalar_Processor_Valid_instruction_ch_0_0 Valid_instruction_ch_0
       (.branch_predict1(xlconstant_0_dout),
        .instr1(Instruction_Memory_0_instr1),
        .instr2(Instruction_Memory_0_instr2),
        .rst(rst_0_1),
        .valid1(Valid_instruction_ch_0_valid1),
        .valid2(Valid_instruction_ch_0_valid2));
  Superscalar_Processor_Write_back_signals_0_0 Write_back_signals_0
       (.wC1(Write_back_signals_0_wC1),
        .wC2(Write_back_signals_0_wC2),
        .wR1(Write_back_signals_0_wR1),
        .wR2(Write_back_signals_0_wR2),
        .wZ1(Write_back_signals_0_wZ1),
        .wZ2(Write_back_signals_0_wZ2),
        .wb1(Reorder_Buffer_0_wb1),
        .wb2(Reorder_Buffer_0_wb2));
  Superscalar_Processor_decode_0_1 decode_0
       (.CZ1(decode_0_CZ1),
        .CZ2(decode_0_CZ2),
        .IA1(decode_buffer_0_address_out1),
        .IA1_out(decode_0_IA1_out),
        .IA2(decode_buffer_0_address_out2),
        .IA2_out(decode_0_IA2_out),
        .Imm1_1(decode_0_Imm1_1),
        .Imm1_2(decode_0_Imm1_2),
        .Imm2_1(decode_0_Imm2_1),
        .Imm2_2(decode_0_Imm2_2),
        .RA1(decode_0_RA1),
        .RA2(decode_0_RA2),
        .RB1(decode_0_RB1),
        .RB2(decode_0_RB2),
        .RC1(decode_0_RC1),
        .RC2(decode_0_RC2),
        .SEI1_1(decode_0_SEI1_1),
        .SEI1_2(decode_0_SEI1_2),
        .SEI2_1(decode_0_SEI2_1),
        .SEI2_2(decode_0_SEI2_2),
        .branch_predict1(decode_buffer_0_branch_predict1_out),
        .branch_predict1_out(decode_0_branch_predict1_out),
        .branch_predict2(decode_buffer_0_branch_predict2_out),
        .branch_predict2_out(decode_0_branch_predict2_out),
        .clk(clk_0_1),
        .comp1(decode_0_comp1),
        .comp2(decode_0_comp2),
        .instr1(decode_buffer_0_instr1_out),
        .instr2(decode_buffer_0_instr2_out),
        .op1(decode_0_op1),
        .op2(decode_0_op2),
        .rst(rst_0_1),
        .spec_tag1(decode_0_spec_tag1),
        .spec_tag2(decode_0_spec_tag2),
        .valid1(decode_buffer_0_valid1_out),
        .valid1_out(decode_0_valid1_out),
        .valid2(decode_buffer_0_valid2_out),
        .valid2_out(decode_0_valid2_out));
  Superscalar_Processor_decode_buffer_0_0 decode_buffer_0
       (.PC_in(PC_0_PC_out),
        .address_out1(decode_buffer_0_address_out1),
        .address_out2(decode_buffer_0_address_out2),
        .branch_predict1_in(xlconstant_0_dout),
        .branch_predict1_out(decode_buffer_0_branch_predict1_out),
        .branch_predict2_in(xlconstant_0_dout),
        .branch_predict2_out(decode_buffer_0_branch_predict2_out),
        .clk(clk_0_1),
        .instr1_in(Instruction_Memory_0_instr1),
        .instr1_out(decode_buffer_0_instr1_out),
        .instr2_in(Instruction_Memory_0_instr2),
        .instr2_out(decode_buffer_0_instr2_out),
        .rst(rst_0_1),
        .stall(xlconstant_0_dout),
        .valid1_in(Valid_instruction_ch_0_valid1),
        .valid1_out(decode_buffer_0_valid1_out),
        .valid2_in(Valid_instruction_ch_0_valid2),
        .valid2_out(decode_buffer_0_valid2_out));
  Superscalar_Processor_xlconstant_0_0 xlconstant_0
       (.dout(xlconstant_0_dout));
  Superscalar_Processor_xlconstant_1_0 xlconstant_1
       (.dout(xlconstant_1_dout));
endmodule

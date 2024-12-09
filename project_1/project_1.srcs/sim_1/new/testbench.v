`timescale 1ns / 1ps
module testbench();
  wire [7:0]Busy_0;
  wire [5:0]Imm1_1_out_0;
  wire [5:0]Imm1_2_out_0;
  wire [8:0]Imm2_l_0;
  wire [15:0]PC_b_0;
  wire [15:0]PC_l_0;
  wire [2:0]ROB_tag_b_0;
  wire [2:0]ROB_tag_l_0;
  wire [15:0]SEI1_b_0;
  wire [15:0]SEI1_l_0;
  wire [15:0]SEI2_b_0;
  wire [15:0]SEI2_l_0;
  wire [3:0]b_ctrl_b_0;
  wire b_p_b_0;
  wire [2:0]buffer_count_0;
  reg clk_0;
  wire empty_0;
  wire full_0;
  wire [2:0]ls_ctrl_l_0;
  wire [3:0]op_b_0;
  wire [15:0]ra_b_0;
  wire [15:0]ra_l_0;
  wire [15:0]rb_b_0;
  wire [15:0]rb_l_0;
  reg rst_0;
  wire [1:0]spec_tag_b_0;
  wire [1:0]spec_tag_l_0;
  wire stall_0;
  wire v_ra_b_0;
  wire v_ra_l_0;
  wire v_rb_b_0;
  wire v_rb_l_0;
  wire valid_b_0;
  wire valid_l_0;
  wire wC1_0;
  wire wC2_0;
  wire wZ1_0;
  wire wZ2_0;
    
     Superscalar_Processor_wrapper processor
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
    buffer_count_0,
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
    initial begin
        clk_0 = 1'b0;
        forever #10 clk_0 = ~clk_0; 
    end
    initial begin
        rst_0 = 1'b1;
        #20 rst_0 = 1'b0;
    end
    initial begin
        $readmemh("C:/Xilinx/IITB_RISC_Superscalar/project_1/memory.txt", processor.Superscalar_Processor_i.Instruction_Memory_0.inst.mem);
        //$readmemh("memory.txt", processor.Superscalar_Processor_i.Instruction_Memory_0[*]);
        //$readmemh("C:/Xilinx/IITB_RISC/memory.txt", processor.IITB_RISC_i.Data_memory_0.inst.mem);
    end
endmodule


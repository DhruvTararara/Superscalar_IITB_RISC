module Load_Store(
    //From Reservation Station==
    input [2:0] ROB_tag,
    input [15:0] PC, ra, rb,
    input v_ra, v_rb,
    input [8:0] Imm2,
    input [15:0] SEI1, SEI2,
    input [1:0] spec_tag,
    input [2:0] ls_ctrl,
    input valid,
    //==========================
    //From Data Memory==========
    input [15:0] dm_data,
    //==========================
    output [2:0] ROB_tag_out,
    output [15:0] dm_data_out,
    output [15:0] DM_addr,
    output [15:0] DM_write_data,
    output MemRead, MemWrite, valid_out);
    
    wire i = rb + SEI1;
    assign dm_data_out = (MemRead)? dm_data : 16'd0;
    assign DM_addr = (ls_ctrl[0])? {7'b0, Imm2}: i;
    assign MemRead = ls_ctrl[2];
    assign MemWrite = ls_ctrl[1];
    assign ROB_tag_out = ROB_tag;
    assign valid_out = valid;
    
endmodule
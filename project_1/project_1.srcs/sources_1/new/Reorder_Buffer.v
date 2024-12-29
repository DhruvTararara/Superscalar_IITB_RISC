`timescale 1ns / 1ps
module Reorder_Buffer(
    input clk, rst,
    input [2:0] ROB_tag1, ROB_tag2,
    input valid1, valid2,
    input [23:0] ROB_input1, ROB_input2,//PC, RD, RCZ, spec_tag -> comes from Allocate unit
    
    //From Register File======================
    input [2:0] RA1_t, RA2_t, RB1_t, RB2_t, RC1_t, RC2_t,
    //========================================
    
    //From Issue Unit, to find Issue bit======
    input [15:0] PC_bi, PC_ai, PC_a2i, PC_lsi,
    input valid_bi, valid_ai, valid_a2i, valid_lsi,
    //========================================
    
    //From Branch Unit, to find Speculative bit
    input [1:0] spec_tag_b,
    //========================================
    
    //Common Data Bus (CDB)===================
    input [15:0] PC_b_cdb, PC_a_cdb, PC_a2_cdb, PC_ls_cdb,
    input valid_b_cdb, valid_a_cdb, valid_a2_cdb, valid_ls_cdb,
    input [15:0] reg_data_b, alu_out, alu2_out, dm_data,
    input [2:0] ROB_b_cdb, ROB_a_cdb, ROB_a2_cdb, ROB_ls_cdb,
    input misprediction,
    //=========================================
    
    //To Register File=========================
    output [15:0] ROB_ra1, ROB_ra2, ROB_rb1, ROB_rb2, ROB_rc1, ROB_rc2,
    output [7:0] valid_ROB,
    //=========================================
    //From Complete Unit (Write Back)==========
    output reg [2:0] wb1, wb2,//wb = {R, C, Z}
    output reg [15:0] reg_data1, reg_data2,
    output reg [2:0] RD1, RD2,
    output reg [2:0] ROB1, ROB2,
    //=========================================
    output wire [7:0] Busy,
    output reg [2:0] head,
    output reg [2:0] tail
    //=========================================
    );
    //ROB Entry
    reg [7:0] Issued;//
    reg [7:0] Finished;//
    reg [15:0] PC [7:0];
    reg [15:0] reg_data [7:0];
    reg [2:0] RD [7:0];
    reg [2:0] RCZ [7:0];
    reg [1:0] spec_tag [7:0];
    reg [7:0] Speculative;//
    reg [7:0] valid;//1: Instr. eligible to be completed (Write result)
    
    assign valid_ROB = valid;
    assign {ROB_ra1, ROB_ra2, ROB_rb1, ROB_rb2, ROB_rc1, ROB_rc2} = {reg_data[RA1_t], reg_data[RA2_t], reg_data[RB1_t], reg_data[RB2_t], reg_data[RC1_t], reg_data[RC2_t]};
    wire [3:0] count;
    wire full, empty;
    assign full = (count >= 7);
    assign empty = (count == 4'd0);
    assign count = (tail - head) % 8;//tail - head - (instructions added) - (instructions committed)
    integer i, j;
    reg [3:0] i_t [7:0];
    reg [3:0] h_i_1 [7:0];
    reg [7:0] Busy1, Busy2;
    reg [2:0] n_h;
    //Busy bits (depends totally on head and tail values)
    assign Busy = Busy1 ^ Busy2;

    //Finished bits
    always @ (posedge clk) begin
        if (rst) begin
            Finished <= 8'b00000000;
        end
        else begin
            if ((PC_b_cdb == PC[0] && valid_b_cdb) || (PC_a_cdb == PC[0] && valid_a_cdb) || (PC_a2_cdb == PC[0] && valid_a2_cdb) || (PC_ls_cdb == PC[0] && valid_ls_cdb)) Finished[0] <= Busy[0];
            else if (Busy[0]) Finished[0] <= Finished[0];
            else Finished[0] <= 1'b0;
            if ((PC_b_cdb == PC[1] && valid_b_cdb) || (PC_a_cdb == PC[1] && valid_a_cdb) || (PC_a2_cdb == PC[1] && valid_a2_cdb) || (PC_ls_cdb == PC[1] && valid_ls_cdb)) Finished[1] <= Busy[1];
            else if (Busy[1]) Finished[1] <= Finished[1];
            else Finished[1] <= 1'b0;
            if ((PC_b_cdb == PC[2] && valid_b_cdb) || (PC_a_cdb == PC[2] && valid_a_cdb) || (PC_a2_cdb == PC[2] && valid_a2_cdb) || (PC_ls_cdb == PC[2] && valid_ls_cdb)) Finished[2] <= Busy[2];
            else if (Busy[2]) Finished[2] <= Finished[2];
            else Finished[2] <= 1'b0;
            if ((PC_b_cdb == PC[3] && valid_b_cdb) || (PC_a_cdb == PC[3] && valid_a_cdb) || (PC_a2_cdb == PC[3] && valid_a2_cdb) || (PC_ls_cdb == PC[3] && valid_ls_cdb)) Finished[3] <= Busy[3];
            else if (Busy[3]) Finished[3] <= Finished[3];
            else Finished[3] <= 1'b0;
            if ((PC_b_cdb == PC[4] && valid_b_cdb) || (PC_a_cdb == PC[4] && valid_a_cdb) || (PC_a2_cdb == PC[4] && valid_a2_cdb) || (PC_ls_cdb == PC[4] && valid_ls_cdb)) Finished[4] <= Busy[4];
            else if (Busy[4]) Finished[4] <= Finished[4];
            else Finished[4] <= 1'b0;
            if ((PC_b_cdb == PC[5] && valid_b_cdb) || (PC_a_cdb == PC[5] && valid_a_cdb) || (PC_a2_cdb == PC[5] && valid_a2_cdb) || (PC_ls_cdb == PC[5] && valid_ls_cdb)) Finished[5] <= Busy[5];
            else if (Busy[5]) Finished[5] <= Finished[5];
            else Finished[5] <= 1'b0;
            if ((PC_b_cdb == PC[6] && valid_b_cdb) || (PC_a_cdb == PC[6] && valid_a_cdb) || (PC_a2_cdb == PC[6] && valid_a2_cdb) || (PC_ls_cdb == PC[6] && valid_ls_cdb)) Finished[6] <= Busy[6];
            else if (Busy[6]) Finished[6] <= Finished[6];
            else Finished[6] <= 1'b0;
            if ((PC_b_cdb == PC[7] && valid_b_cdb) || (PC_a_cdb == PC[7] && valid_a_cdb) || (PC_a2_cdb == PC[7] && valid_a2_cdb) || (PC_ls_cdb == PC[7] && valid_ls_cdb)) Finished[7] <= Busy[7];
            else if (Busy[7]) Finished[7] <= Finished[7];
            else Finished[7] <= 1'b0;
        end
    end
    //Issued bits
    always @ (posedge clk) begin
        if (rst) begin
            Issued <= 8'b00000000;
        end
        else begin
            if ((PC_bi == PC[0] && valid_bi) || (PC_ai == PC[0] && valid_ai) || (PC_a2i == PC[0] && valid_a2i) || (PC_lsi == PC[0] && valid_lsi)) Issued[0] <= Busy[0];
            else if (Busy[0]) Issued[0] <= Issued[0];
            else Issued[0] <= 1'b0;
            if ((PC_bi == PC[1] && valid_bi) || (PC_ai == PC[1] && valid_ai) || (PC_a2i == PC[1] && valid_a2i) || (PC_lsi == PC[1] && valid_lsi)) Issued[1] <= Busy[1];
            else if (Busy[1]) Issued[1] <= Issued[1];
            else Issued[1] <= 1'b0;
            if ((PC_bi == PC[2] && valid_bi) || (PC_ai == PC[2] && valid_ai) || (PC_a2i == PC[2] && valid_a2i) || (PC_lsi == PC[2] && valid_lsi)) Issued[2] <= Busy[2];
            else if (Busy[2]) Issued[2] <= Issued[2];
            else Issued[2] <= 1'b0;
            if ((PC_bi == PC[3] && valid_bi) || (PC_ai == PC[3] && valid_ai) || (PC_a2i == PC[3] && valid_a2i) || (PC_lsi == PC[3] && valid_lsi)) Issued[3] <= Busy[3];
            else if (Busy[3]) Issued[3] <= Issued[3];
            else Issued[3] <= 1'b0;
            if ((PC_bi == PC[4] && valid_bi) || (PC_ai == PC[4] && valid_ai) || (PC_a2i == PC[4] && valid_a2i) || (PC_lsi == PC[4] && valid_lsi)) Issued[4] <= Busy[4];
            else if (Busy[4]) Issued[4] <= Issued[4];
            else Issued[4] <= 1'b0;
            if ((PC_bi == PC[5] && valid_bi) || (PC_ai == PC[5] && valid_ai) || (PC_a2i == PC[5] && valid_a2i) || (PC_lsi == PC[5] && valid_lsi)) Issued[5] <= Busy[5];
            else if (Busy[5]) Issued[5] <= Issued[5];
            else Issued[5] <= 1'b0;
            if ((PC_bi == PC[6] && valid_bi) || (PC_ai == PC[6] && valid_ai) || (PC_a2i == PC[6] && valid_a2i) || (PC_lsi == PC[6] && valid_lsi)) Issued[6] <= Busy[6];
            else if (Busy[6]) Issued[6] <= Issued[6];
            else Issued[6] <= 1'b0;
            if ((PC_bi == PC[7] && valid_bi) || (PC_ai == PC[7] && valid_ai) || (PC_a2i == PC[7] && valid_a2i) || (PC_lsi == PC[7] && valid_lsi)) Issued[7] <= Busy[7];
            else if (Busy[7]) Issued[7] <= Issued[7];
            else Issued[7] <= 1'b0;
        end
    end
    //Speculative bits
    always @ (posedge clk) begin
        if (rst) Speculative <= 8'b11111111;
        else begin
            if ((spec_tag[head] == 2'b00) && (Busy[head])) Speculative[head] <= 1'b0;
            else if (spec_tag_b == spec_tag[head] && valid_b_cdb) begin
                Speculative[head] <= 1'b0;
                if (!misprediction) spec_tag[head] <= 2'd0;
                else spec_tag[head] <= spec_tag[head];
            end
            else if (Busy[head]) Speculative[head] <= Speculative[head];
            else Speculative[head] <= 1'b1;
            if ((spec_tag[(head+1)%8] == 2'b00) && (Busy[(head+1)%8])) Speculative[(head+1)%8] <= 1'b0;
            else if (spec_tag_b == spec_tag[(head+1)%8] && valid_b_cdb) begin
                Speculative[(head+1)%8] <= 1'b0;
                if (!misprediction) spec_tag[(head+1)%8] <= 2'd0;
                else spec_tag[(head+1)%8] <= spec_tag[(head+1)%8];
            end
            else if (Busy[(head+1)%8]) Speculative[(head+1)%8] <= Speculative[(head+1)%8];
            else Speculative[(head+1)%8] <= 1'b1;
            if ((spec_tag[(head+2)%8] == 2'b00) && (Busy[(head+2)%8])) Speculative[(head+2)%8] <= 1'b0;
            else if (spec_tag_b == spec_tag[(head+2)%8] && valid_b_cdb) begin
                Speculative[(head+2)%8] <= 1'b0;
                if (!misprediction) spec_tag[(head+2)%8] <= 2'd0;
                else spec_tag[(head+2)%8] <= spec_tag[(head+2)%8];
            end
            else if (Busy[(head+2)%8]) Speculative[(head+2)%8] <= Speculative[(head+2)%8];
            else Speculative[(head+2)%8] <= 1'b1;
            if ((spec_tag[(head+3)%8] == 2'b00) && (Busy[(head+3)%8])) Speculative[(head+3)%8] <= 1'b0;
            else if (spec_tag_b == spec_tag[(head+3)%8] && valid_b_cdb) begin
                Speculative[(head+3)%8] <= 1'b0;
                if (!misprediction) spec_tag[(head+3)%8] <= 2'd0;
                else spec_tag[(head+3)%8] <= spec_tag[(head+3)%8];
            end
            else if (Busy[(head+3)%8]) Speculative[(head+3)%8] <= Speculative[(head+3)%8];
            else Speculative[(head+3)%8] <= 1'b1;
            if ((spec_tag[(head+4)%8] == 2'b00) && (Busy[(head+4)%8])) Speculative[(head+4)%8] <= 1'b0;
            else if (spec_tag_b == spec_tag[(head+4)%8] && valid_b_cdb) begin
                Speculative[(head+4)%8] <= 1'b0;
                if (!misprediction) spec_tag[(head+4)%8] <= 2'd0;
                else spec_tag[(head+4)%8] <= spec_tag[(head+4)%8];
            end
            else if (Busy[(head+4)%8]) Speculative[(head+4)%8] <= Speculative[(head+4)%8];
            else Speculative[(head+4)%8] <= 1'b1;
            if ((spec_tag[(head+5)%8] == 2'b00) && (Busy[(head+5)%8])) Speculative[(head+5)%8] <= 1'b0;
            else if (spec_tag_b == spec_tag[(head+5)%8] && valid_b_cdb) begin
                Speculative[(head+5)%8] <= 1'b0;
                if (!misprediction) spec_tag[(head+5)%8] <= 2'd0;
                else spec_tag[(head+5)%8] <= spec_tag[(head+5)%8];
            end
            else if (Busy[(head+5)%8]) Speculative[(head+5)%8] <= Speculative[(head+5)%8];
            else Speculative[(head+5)%8] <= 1'b1;
            if ((spec_tag[(head+6)%8] == 2'b00) && (Busy[(head+6)%8])) Speculative[(head+6)%8] <= 1'b0;
            else if (spec_tag_b == spec_tag[(head+6)%8] && valid_b_cdb) begin
                Speculative[(head+6)%8] <= 1'b0;
                if (!misprediction) spec_tag[(head+6)%8] <= 2'd0;
                else spec_tag[(head+6)%8] <= spec_tag[(head+6)%8];
            end
            else if (Busy[(head+6)%8]) Speculative[(head+6)%8] <= Speculative[(head+6)%8];
            else Speculative[(head+6)%8] <= 1'b1;
            if ((spec_tag[(head+7)%8] == 2'b00) && (Busy[(head+7)%8])) Speculative[(head+7)%8] <= 1'b0;
            else if (spec_tag_b == spec_tag[(head+7)%8] && valid_b_cdb) begin
                Speculative[(head+7)%8] <= 1'b0;
                if (!misprediction) spec_tag[(head+7)%8] <= 2'd0;
                else spec_tag[(head+7)%8] <= spec_tag[(head+7)%8];
            end
            else if (Busy[(head+7)%8]) Speculative[(head+7)%8] <= Speculative[(head+7)%8];
            else Speculative[(head+7)%8] <= 1'b1;
        end
    end
    //Valid bits
    always @ (*) begin
        for (i = 0; i < 8; i = i + 1) begin
            if (Busy[i] & Issued[i] & Finished[i] & !Speculative[i]) valid[i] <= 1'b1;
            else valid[i] <= 1'b0;
        end
    end
    
    //Instructions Reserved (with change in control values for change in tail)
    always @ (posedge clk) begin
        if (rst) begin
            valid <= 8'd0;
            Busy1 <= 8'b11111111;
        end
        else begin
            //Use stall signal in this if statement only (Write Back is allowed even if processor is stalled)
            if (!full) begin
                if (valid1 & valid2) begin
                    {Busy1[ROB_tag1], Busy1[ROB_tag2]} <= {!Busy1[ROB_tag1], !Busy1[ROB_tag2]};
                    {PC[ROB_tag1], RD[ROB_tag1], RCZ[ROB_tag1], spec_tag[ROB_tag1]} <= ROB_input1;
                    {PC[ROB_tag2], RD[ROB_tag2], RCZ[ROB_tag2], spec_tag[ROB_tag2]} <= ROB_input2;
                end
                else if (valid1 & !valid2) begin
                    Busy1[ROB_tag1] <= !Busy1[ROB_tag1];
                    {PC[ROB_tag1], RD[ROB_tag1], RCZ[ROB_tag1], spec_tag[ROB_tag1]} <= ROB_input1;
                end
                else if (!valid1 & valid2) begin
                    Busy1[ROB_tag2] <= !Busy1[ROB_tag2];
                    {PC[ROB_tag2], RD[ROB_tag2], RCZ[ROB_tag2], spec_tag[ROB_tag2]} <= ROB_input2;
                end
                else begin
                end
            end
            else begin
            end
            
            //reg_data logic
            if (valid_b_cdb) reg_data[ROB_b_cdb] <= reg_data_b;
            if (valid_a_cdb) reg_data[ROB_a_cdb] <= alu_out;
            if (valid_a2_cdb) reg_data[ROB_a2_cdb] <= alu2_out;
            if (valid_ls_cdb) reg_data[ROB_ls_cdb] <= dm_data;
        end
    end
    
    //Commit (with change in value of head)
    always @ (*) begin
        if (rst) n_h <= 3'b000;
        else begin
//            if (!empty) begin
                if (valid[head] & valid[head + 3'd1]) n_h <= head + 3'b010;
                else if (valid[head] & !valid[head + 3'd1]) n_h <= head + 3'b001;
                else n_h <= head;
//            end
//            else n_h <= head;
        end
    end
    always @ (posedge clk) begin
        if (rst) head <= 3'b000;
        else head <= n_h;
    end
    always @ (posedge clk) begin
        if (rst) Busy2 <= 8'b11111111;
        else begin 
//            if (!empty) begin
                if (valid[head] & valid[head + 3'd1]) begin
                    {Busy2[head], Busy2[head + 1]} <= {!Busy2[head], !Busy2[head + 1]};
                end
                else if (valid[head] & !valid[head + 3'd1]) begin
                    Busy2[head] <= !Busy2[head];
                end
                else Busy2 <= Busy2;
//            end
//            else {wb1[2], wb2[2]} <= 2'b00;
        end
    end
    always @ (*) begin
        if (rst) begin
            Busy2 <= 8'b11111111;
        end
        else begin 
//            if (!empty) begin
                if (valid[head] & valid[head + 3'd1]) begin
                    {reg_data1, reg_data2} <= {reg_data[head], reg_data[head + 3'd1]};
                    {RD1, RD2} <= {RD[head], RD[head + 3'd1]};
                    {ROB1, ROB2} <= {head, head + 3'd1};
                    if (spec_tag[head] != 2'b00) begin
                        //Register Update
                        if (RCZ[head][2]) {wb1[2], wb2[2]} <= 2'b10;
                        else {wb1[2], wb2[2]} <= 2'b00;
                        //Carry flag Update
                        //Zero flag Update
                    end
                    else if (spec_tag[head] == 2'b00 && spec_tag[head + 1] != 2'b00) begin
                        //Register Update
                        if (RCZ[head][2] & RCZ[head + 3'd1][2]) {wb1[2], wb2[2]} <= 2'b11;
                        else if (RCZ[head][2] & !RCZ[head + 3'd1][2]) {wb1[2], wb2[2]} <= 2'b10;
                        else if (!RCZ[head][2] & !RCZ[head + 3'd1][2]) {wb1[2], wb2[2]} <= 2'b01;
                        else {wb1[2], wb2[2]} <= 2'b00;
                        //Carry flag Update
                        //Zero flag Update
                    end
                    else begin
                        //Register Update
                        if (RCZ[head][2] & RCZ[head + 3'd1][2]) {wb1[2], wb2[2]} <= 2'b11;
                        else if (RCZ[head][2] & !RCZ[head + 3'd1][2]) {wb1[2], wb2[2]} <= 2'b10;
                        else if (!RCZ[head][2] & !RCZ[head + 3'd1][2]) {wb1[2], wb2[2]} <= 2'b01;
                        else {wb1[2], wb2[2]} <= 2'b00;
                        //Carry flag Update
                        //Zero flag Update
                    end
                    
                end
                else if (valid[head] & !valid[head + 3'd1]) begin
                    {reg_data1} <= {reg_data[head]};
                    {RD1} <= {RD[head]};
                    {ROB1} <= {head};
                    if (spec_tag[head] != 2'b00) begin
                        //Register Update
                        if (RCZ[head][2]) {wb1[2], wb2[2]} <= 2'b10;
                        else {wb1[2], wb2[2]} <= 2'b00;
                        //Carry flag Update
                        //Zero flag Update
                    end
                    else begin
                        //Register Update
                        if (RCZ[head][2]) {wb1[2], wb2[2]} <= 2'b10;
                        else {wb1[2], wb2[2]} <= 2'b00;
                        //Carry flag Update
                        //Zero flag Update
                    end
                end
                else begin {RD1, RD2} <= {RD[head], RD[head + 3'd1]}; {wb1[2], wb2[2]} <= 2'b00; end
//            end
//            else {wb1[2], wb2[2]} <= 2'b00;
        end
    end
    
    
    //Tail value (using control signals s_ctrl: for Instruction commit; and n_ctrl: for newly dispatched instructions)
    reg [1:0] n_ctrl;
    always @ (*) begin
        if (rst) begin
        end
        else begin
            if (!full) begin
                if (valid1 & valid2) begin
                    n_ctrl <= 2'b10;//add 2
                end
                else if (valid1 & !valid2) begin
                    n_ctrl <= 2'b01;//add 1
                end
                else if (!valid1 & valid2) begin
                    n_ctrl <= 2'b01;//add 1
                end
                else begin
                    n_ctrl <= 2'b00;//No valid instructions dispatched
                end
            end
            //Processor is stalled
        end
    end
    reg [1:0] s_ctrl;
    always @ (*) begin
        if (rst) s_ctrl <= 2'b00;
        else begin
            if (!empty) begin
                if (valid[head] & valid[head + 3'd1]) begin
                    if (spec_tag[head] != 2'b00) s_ctrl <= 2'b01;//Misprediction: Tail to head + 2
                    else if (spec_tag[head] == 2'b00 && spec_tag[head + 1] != 2'b00) s_ctrl <= 2'b01;//Misprediction: Tail to haed + 2
                    else s_ctrl <= 2'b00;//No misprediction
                end
                else if (valid[head] & !valid[head + 3'd1]) begin
                    if (spec_tag[head] != 2'b00) s_ctrl <= 2'b10;//Misprediction: Tail to head + 1
                    else s_ctrl <= 2'b00;//No misprediction
                end
                else begin
                    s_ctrl <= s_ctrl;//No valid instruction at head of ROB
                end
            end
            //Processor is empty (head = tail)
        end
    end
    always @ (posedge clk) begin
        if (rst) tail <= 3'b000;
        else begin
            if (s_ctrl[0]) begin
                tail <= head + 3'd2;
            end
            else if (s_ctrl[1]) begin
                tail <= head + 3'd1;
            end
            else begin
                if (n_ctrl[0]) tail <= tail + 3'd1;
                else if (n_ctrl[1]) tail <= tail + 3'd2;
                else tail <= tail;
            end
        end
    end
    
    
endmodule
module Reorder_Buffer(
    input clk, rst,
    input [2:0] ROB_tag1, ROB_tag2,
    input valid1, valid2,
    input [23:0] ROB_input1, ROB_input2,//PC, RD, RCZ, spec_tag -> comes from Allocate unit
    
    //From Issue Unit, to find Issue bit
    input [15:0] PC_bi, PC_ai, PC_a2i, PC_lsi,
    input valid_bi, valid_ai, valid_a2i, valid_lsi,
    //==================================
    
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
    
    //From Complete Unit (Write Back)==========
    output reg [2:0] wb1, wb2,//wb = {R, C, Z}
    output reg [15:0] reg_data1, reg_data2,
    output reg [2:0] RD1, RD2,
    output reg [15:0] ROB1, ROB2,
    //=========================================
    output reg [7:0] Busy,
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
    
    
    wire [3:0] count;
    wire full, empty;
    assign full = (count >= 7);
    assign empty = (count == 4'd0);
    assign count = (tail - head) % 8;
    integer i, j;
    reg [3:0] i_t [7:0];
    reg [3:0] h_i_1 [7:0];
    
    //Busy bits (depends totally on head and tail values)
    always @ (*) begin
        for (j = 0; j < 8; j = j + 1) begin
            i_t[j] = j - tail;
            h_i_1[j] = head - j - 4'd1;
        end
    end
    always @ (*) begin
        for (i = 0; i < 8; i = i + 1) begin
            Busy[i] = i_t[i][3] & h_i_1[i][3];
        end
    end
    //Finished bits
    always @ (posedge clk) begin
        if (rst) begin
            Finished <= 8'b00000000;
        end
        else begin
            if ((PC_b_cdb == PC[0] && valid_b_cdb) || (PC_a_cdb == PC[0] && valid_a_cdb) || (PC_a2_cdb == PC[0] && valid_a2_cdb) || (PC_ls_cdb == PC[0] && valid_ls_cdb)) Finished[0] <= Busy[0];
            else if ((PC_b_cdb == PC[1] && valid_b_cdb) || (PC_a_cdb == PC[1] && valid_a_cdb) || (PC_a2_cdb == PC[0] && valid_a2_cdb) || (PC_ls_cdb == PC[1] && valid_ls_cdb)) Finished[0] <= Busy[1];
            else if ((PC_b_cdb == PC[2] && valid_b_cdb) || (PC_a_cdb == PC[2] && valid_a_cdb) || (PC_a2_cdb == PC[0] && valid_a2_cdb) || (PC_ls_cdb == PC[2] && valid_ls_cdb)) Finished[0] <= Busy[2];
            else if ((PC_b_cdb == PC[3] && valid_b_cdb) || (PC_a_cdb == PC[3] && valid_a_cdb) || (PC_a2_cdb == PC[0] && valid_a2_cdb) || (PC_ls_cdb == PC[3] && valid_ls_cdb)) Finished[0] <= Busy[3];
            else if ((PC_b_cdb == PC[4] && valid_b_cdb) || (PC_a_cdb == PC[4] && valid_a_cdb) || (PC_a2_cdb == PC[0] && valid_a2_cdb) || (PC_ls_cdb == PC[4] && valid_ls_cdb)) Finished[0] <= Busy[4];
            else if ((PC_b_cdb == PC[5] && valid_b_cdb) || (PC_a_cdb == PC[5] && valid_a_cdb) || (PC_a2_cdb == PC[0] && valid_a2_cdb) || (PC_ls_cdb == PC[5] && valid_ls_cdb)) Finished[0] <= Busy[5];
            else if ((PC_b_cdb == PC[6] && valid_b_cdb) || (PC_a_cdb == PC[6] && valid_a_cdb) || (PC_a2_cdb == PC[0] && valid_a2_cdb) || (PC_ls_cdb == PC[6] && valid_ls_cdb)) Finished[0] <= Busy[6];
            else if ((PC_b_cdb == PC[7] && valid_b_cdb) || (PC_a_cdb == PC[7] && valid_a_cdb) || (PC_a2_cdb == PC[0] && valid_a2_cdb) || (PC_ls_cdb == PC[7] && valid_ls_cdb)) Finished[0] <= Busy[7];
            else begin
            end
        end
    end
    //Issued bits
    always @ (posedge clk) begin
        if (rst) begin
            Issued <= 8'b00000000;
        end
        else begin
            if ((PC_bi == PC[0] && valid_bi) || (PC_ai == PC[0] && valid_ai) || (PC_a2i == PC[0] && valid_a2i) || (PC_lsi == PC[0] && valid_lsi)) Issued[0] <= Busy[0];
            else if ((PC_bi == PC[1] && valid_bi) || (PC_ai == PC[1] && valid_ai) || (PC_a2i == PC[0] && valid_a2i) || (PC_lsi == PC[1] && valid_lsi)) Issued[0] <= Busy[1];
            else if ((PC_bi == PC[2] && valid_bi) || (PC_ai == PC[2] && valid_ai) || (PC_a2i == PC[0] && valid_a2i) || (PC_lsi == PC[2] && valid_lsi)) Issued[0] <= Busy[2];
            else if ((PC_bi == PC[3] && valid_bi) || (PC_ai == PC[3] && valid_ai) || (PC_a2i == PC[0] && valid_a2i) || (PC_lsi == PC[3] && valid_lsi)) Issued[0] <= Busy[3];
            else if ((PC_bi == PC[4] && valid_bi) || (PC_ai == PC[4] && valid_ai) || (PC_a2i == PC[0] && valid_a2i) || (PC_lsi == PC[4] && valid_lsi)) Issued[0] <= Busy[4];
            else if ((PC_bi == PC[5] && valid_bi) || (PC_ai == PC[5] && valid_ai) || (PC_a2i == PC[0] && valid_a2i) || (PC_lsi == PC[5] && valid_lsi)) Issued[0] <= Busy[5];
            else if ((PC_bi == PC[6] && valid_bi) || (PC_ai == PC[6] && valid_ai) || (PC_a2i == PC[0] && valid_a2i) || (PC_lsi == PC[6] && valid_lsi)) Issued[0] <= Busy[6];
            else if ((PC_bi == PC[7] && valid_bi) || (PC_ai == PC[7] && valid_ai) || (PC_a2i == PC[0] && valid_a2i) || (PC_lsi == PC[7] && valid_lsi)) Issued[0] <= Busy[7];
            else begin
            end
        end
    end
    //Speculative bits
    always @ (posedge clk) begin
        if (rst) Speculative <= 8'b11111111;
        else begin
            if (spec_tag_b == spec_tag[head] && valid_b_cdb) begin
                Speculative[head] <= 1'b0;
                if (!misprediction) spec_tag[head] <= 2'd0;
                else spec_tag[head] <= spec_tag[head];
            end
            else if (spec_tag_b == spec_tag[head + 1] && valid_b_cdb) begin
                Speculative[head + 1] <= 1'b0;
                if (!misprediction) spec_tag[head + 1] <= 2'd0;
                else spec_tag[head + 1] <= spec_tag[head + 1];
            end
            else if (spec_tag_b == spec_tag[head + 2] && valid_b_cdb) begin
                Speculative[head + 2] <= 1'b0;
                if (!misprediction) spec_tag[head + 2] <= 2'd0;
                else spec_tag[head + 2] <= spec_tag[head + 2];
            end
            else if (spec_tag_b == spec_tag[head + 3] && valid_b_cdb) begin
                Speculative[head + 3] <= 1'b0;
                if (!misprediction) spec_tag[head + 3] <= 2'd0;
                else spec_tag[head + 3] <= spec_tag[head + 3];
            end
            else if (spec_tag_b == spec_tag[head] && valid_b_cdb) begin
                Speculative[head + 4] <= 1'b0;
                if (!misprediction) spec_tag[head + 4] <= 2'd0;
                else spec_tag[head + 4] <= spec_tag[head + 4];
            end
            else if (spec_tag_b == spec_tag[head + 5] && valid_b_cdb) begin
                Speculative[head + 5] <= 1'b0;
                if (!misprediction) spec_tag[head + 5] <= 2'd0;
                else spec_tag[head + 5] <= spec_tag[head + 5];
            end
            else if (spec_tag_b == spec_tag[head + 6] && valid_b_cdb) begin
                Speculative[head + 6] <= 1'b0;
                if (!misprediction) spec_tag[head + 6] <= 2'd0;
                else spec_tag[head + 6] <= spec_tag[head + 6];
            end
            else if (spec_tag_b == spec_tag[head + 7] && valid_b_cdb) begin
                Speculative[head + 7] <= 1'b0;
                if (!misprediction) spec_tag[head + 7] <= 2'd0;
                else spec_tag[head + 7] <= spec_tag[head + 7];
            end
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
        end
        else begin
            //Use stall signal in this if statement only (Write Back is allowed even if processor is stalled)
            if (!full) begin
                if (valid1 & valid2) begin
                    {PC[ROB_tag1], reg_data[ROB_tag1], RD[ROB_tag1], RCZ[ROB_tag1], spec_tag[ROB_tag1]} <= ROB_input1;
                    {PC[ROB_tag2], reg_data[ROB_tag2], RD[ROB_tag2], RCZ[ROB_tag2], spec_tag[ROB_tag2]} <= ROB_input2;
                end
                else if (valid1 & !valid2) begin
                    {PC[ROB_tag1], reg_data[ROB_tag1], RD[ROB_tag1], RCZ[ROB_tag1], spec_tag[ROB_tag1]} <= ROB_input1;
                end
                else if (!valid1 & valid2) begin
                    {PC[ROB_tag2], reg_data[ROB_tag2], RD[ROB_tag2], RCZ[ROB_tag2], spec_tag[ROB_tag2]} <= ROB_input2;
                end
                else begin
                end
            end
            
            //reg_data logic
            if (valid_b_cdb) reg_data[ROB_b_cdb] <= reg_data_b;
            if (valid_a_cdb) reg_data[ROB_a_cdb] <= alu_out;
            if (valid_a2_cdb) reg_data[ROB_a2_cdb] <= alu2_out;
            if (valid_ls_cdb) reg_data[ROB_ls_cdb] <= dm_data;
        end
    end
    
    //Commit (with change in value of head and control values for change in tail)
    always @ (posedge clk) begin
        if (rst) head <= 3'd0;
        else begin 
            if (!empty) begin
                if (valid[head] & valid[head + 3'd1]) begin
                    head <= head + 3'd2;
                    {reg_data1, reg_data2} <= {reg_data[head], reg_data[head + 3'd1]};
                    {RD1, RD2} <= {RD[head], RD[head + 3'd1]};
                    {ROB1, ROB2} <= {head, head + 3'd1};
                    if (spec_tag[head] != 2'b00) begin
                        //Register Update
                        if (RCZ[head][2]) {wb1[2], wb2[2]} <= 2'b01;
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
                    head <= head + 3'd1;
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
                else {wb1[2], wb2[2]} <= 2'b00;
            end
            else {wb1[2], wb2[2]} <= 2'b00;
        end
    end
    
    //Tail value (using control signals s_ctrl: for Instruction commit; and n_ctrl: for newly dispatched instructions)
    reg [1:0] n_ctrl;
    always @ (posedge clk) begin
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
                    s_ctrl <= 2'b11;//No valid instruction at head of ROB
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
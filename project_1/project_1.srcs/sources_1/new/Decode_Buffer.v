`timescale 1ns / 1ps
module decode_buffer(clk, rst, PC_in, instr1_in, valid1_in, valid2_in, instr2_in, 
                    branch_predict1_in, branch_predict2_in, address_out1, address_out2,
                    instr1_out, instr2_out, branch_predict1_out, branch_predict2_out, 
                    valid1_out, valid2_out);
    input clk, rst;
    input [15:0] PC_in;
    input [15:0] instr1_in, instr2_in;
    input branch_predict1_in, branch_predict2_in, valid1_in, valid2_in;
    output reg [15:0] address_out1, address_out2;
    output reg [15:0] instr1_out, instr2_out;
    output reg branch_predict1_out, branch_predict2_out;
    output reg valid1_out, valid2_out;
    reg [1:0] head, tail;
    wire [2:0] count;
    reg [15:0] address_queue [3:0];
    reg [15:0] instr_queue [3:0];
    reg [3:0] branch_prediction;
    wire [3:0] Busy;
    wire full, empty;
    assign full = (count >= 3);
    assign empty = (count == 3'd0);
    assign count = (tail - head - Busy[head] - Busy[head + 2'd1] + valid1_in + valid2_in) % 4;//tail - head - (instructions added) - (instructions committed)
    reg [2:0] i_t [3:0];
    reg [2:0] h_i_1 [3:0];
    reg [3:0] Busy1;
    reg [3:0] Busy2;
    //Busy bits (depends totally on head and tail values)
    assign Busy = Busy1 ^ Busy2;
    //Instruction incoming (Allowed even if there stall is 1)
    always @ (posedge clk) begin
        if (rst) begin
            tail <= 2'b00;
            Busy1 <= 4'b1111;
        end
        else begin
            if (!full) begin
                if (valid1_in & valid2_in) begin
                    {Busy1[tail], Busy1[tail + 2'd1]} <= {!Busy1[tail], !Busy1[tail + 2'd1]};
                    tail <= tail + 2'd2;
                    address_queue[tail] <= PC_in;
                    instr_queue[tail] <= instr1_in;
                    branch_prediction[tail] <= branch_predict1_in;
                    address_queue[tail+2'd1] <= PC_in + 2'd2;
                    instr_queue[tail+2'd1] <= instr2_in;
                    branch_prediction[tail+2'd1] <= branch_predict2_in;
                end
                else if (valid1_in & !valid2_in) begin
                    Busy1[tail] <= !Busy1[tail];
                    tail <= tail + 2'd1;
                    address_queue[tail] <= PC_in;
                    instr_queue[tail] <= instr1_in;
                    branch_prediction[tail] <= branch_predict1_in;
                end
                else begin
                    tail <= tail;
                    head <= head;
                end
            end
            else begin
            end
        end
    end
    //Instruction Outgoing (Not allowed if stall is 1)
    always @ (*) begin
        if (rst) begin
            Busy2 <= 4'b1111;
        end
        else begin
            if (!empty) begin
                if (Busy[head] & Busy[head + 2'd1]) begin
                    address_out1 <= address_queue[head];
                    instr1_out <= instr_queue[head];
                    branch_predict1_out <= branch_prediction[head];
                    address_out2 <= address_queue[head+2'd1];
                    instr2_out <= instr_queue[head+2'd1];
                    branch_predict2_out <= branch_prediction[head+2'd1];
                    {valid1_out, valid2_out} <= 2'b11;
                end
                else if (Busy[head] & !Busy[head + 3'd1]) begin
                    address_out1 <= address_queue[head];
                    instr1_out <= instr_queue[head];
                    branch_predict1_out <= branch_prediction[head];
                    {valid1_out, valid2_out} <= 2'b10;
                end
                else begin
                    {valid1_out, valid2_out} <= 2'b00;
                end
            end
            else begin
            end
        end
    end
    always @ (posedge clk) begin
        if (rst) begin
            head <= 2'b00;
        end
        else begin
            if (!empty) begin
                if (Busy[head] & Busy[head + 2'd1]) begin
                    {Busy2[head], Busy2[head + 2'd1]} <= {!Busy2[head], !Busy2[head + 2'd1]};
                    head <= head + 2'd2;
                end
                else if (Busy[head] & !Busy[head + 3'd1]) begin
                    Busy2[head] <= !Busy2[head];
                    head <= head + 2'd1;
                end
                else begin
                    head <= head;
                end
            end
            else begin
            end
        end
    end
    
endmodule
`timescale 1ns / 1ps
module DispatchBuffer #(
    parameter BUFFER_SIZE = 4,
    parameter OP_WIDTH = 4,
    parameter REG_ADDR_WIDTH = 3,
    parameter IMM1_WIDTH = 6,
    parameter IMM2_WIDTH = 9,
    parameter SEI1_WIDTH = 16,
    parameter SEI2_WIDTH = 16
)(
    input wire clk,
    input wire rst,
    
    // Input interface - Decoded instructions
    input [15:0] IA1_in, IA2_in,
    input wire [OP_WIDTH-1:0] op1_in,
    input wire [OP_WIDTH-1:0] op2_in,
    input wire [REG_ADDR_WIDTH-1:0] RA1_in,
    input wire [REG_ADDR_WIDTH-1:0] RA2_in,
    input wire [REG_ADDR_WIDTH-1:0] RB1_in,
    input wire [REG_ADDR_WIDTH-1:0] RB2_in,
    input wire [REG_ADDR_WIDTH-1:0] RC1_in,
    input wire [REG_ADDR_WIDTH-1:0] RC2_in,
    input wire comp1_in,
    input wire comp2_in,
    input wire [1:0] CZ1_in,
    input wire [1:0] CZ2_in,
    input wire [IMM1_WIDTH-1:0] Imm1_1_in,
    input wire [IMM1_WIDTH-1:0] Imm1_2_in,
    input wire [IMM2_WIDTH-1:0] Imm2_1_in,
    input wire [IMM2_WIDTH-1:0] Imm2_2_in,
    input wire [SEI1_WIDTH-1:0] SEI1_1_in,
    input wire [SEI1_WIDTH-1:0] SEI1_2_in,
    input wire [SEI2_WIDTH-1:0] SEI2_1_in,
    input wire [SEI2_WIDTH-1:0] SEI2_2_in,
    input [1:0] spec_tag1_in, spec_tag2_in,
    input wire valid_in1,
    input wire valid_in2,
    input wire branch_predict1_in,
    input wire branch_predict2_in,
    
    // Issue interface
    input wire issue1,
    input wire issue2,
    
    // Output interface
    output reg [15:0] IA1_out,
    output reg [15:0] IA2_out,
    output reg [OP_WIDTH-1:0] op1_out,
    output reg [OP_WIDTH-1:0] op2_out,
    output reg [REG_ADDR_WIDTH-1:0] RA1_out,
    output reg [REG_ADDR_WIDTH-1:0] RA2_out,
    output reg [REG_ADDR_WIDTH-1:0] RB1_out,
    output reg [REG_ADDR_WIDTH-1:0] RB2_out,
    output reg [REG_ADDR_WIDTH-1:0] RC1_out,
    output reg [REG_ADDR_WIDTH-1:0] RC2_out,
    output reg comp1_out,
    output reg comp2_out,
    output reg [1:0] CZ1_out,
    output reg [1:0] CZ2_out,
    output reg [IMM1_WIDTH-1:0] Imm1_1_out,
    output reg [IMM1_WIDTH-1:0] Imm1_2_out,
    output reg [IMM2_WIDTH-1:0] Imm2_1_out,
    output reg [IMM2_WIDTH-1:0] Imm2_2_out,
    output reg [SEI1_WIDTH-1:0] SEI1_1_out,
    output reg [SEI1_WIDTH-1:0] SEI1_2_out,
    output reg [SEI2_WIDTH-1:0] SEI2_1_out,
    output reg [SEI2_WIDTH-1:0] SEI2_2_out,
    output reg [1:0] spec_tag1_out,
    output reg [1:0] spec_tag2_out,
    output reg valid_out1,
    output reg valid_out2,
    output reg branch_predict1_out,
    output reg branch_predict2_out,
    
    // Buffer status
    output wire full,
    output wire empty
);

    // Define buffer storage structures
    reg [OP_WIDTH-1:0] op [BUFFER_SIZE-1:0];
    reg [REG_ADDR_WIDTH-1:0] RA [BUFFER_SIZE-1:0];
    reg [REG_ADDR_WIDTH-1:0] RB [BUFFER_SIZE-1:0];
    reg [REG_ADDR_WIDTH-1:0] RC [BUFFER_SIZE-1:0];
    reg comp [BUFFER_SIZE-1:0];
    reg [1:0] CZ [BUFFER_SIZE-1:0];
    reg [IMM1_WIDTH-1:0] Imm1 [BUFFER_SIZE-1:0];
    reg [IMM2_WIDTH-1:0] Imm2 [BUFFER_SIZE-1:0];
    reg [SEI1_WIDTH-1:0] SEI1 [BUFFER_SIZE-1:0];
    reg [SEI2_WIDTH-1:0] SEI2 [BUFFER_SIZE-1:0];
    reg branch_predict [BUFFER_SIZE-1:0];
    reg [15:0] IA [3:0];
    reg [1:0] spec_tag [3:0];
    wire [3:0] Busy;
    // Buffer management pointers
    reg [$clog2(BUFFER_SIZE)-1:0] head;
    reg [$clog2(BUFFER_SIZE)-1:0] tail;
    wire [$clog2(BUFFER_SIZE):0] count;
    
    // Status signals
    assign full = (count >= 3);
    assign empty = (count == 3'd0);
    assign count = (tail - head - Busy[head] - Busy[head + 2'd1] + valid_in1 + valid_in2) % 4;//tail - head - (instructions added) - (instructions committed)
    reg [2:0] i_t [3:0];
    reg [2:0] h_i_1 [3:0];
    reg [3:0] Busy1, Busy2;
    
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
                if (valid_in1 & valid_in2) begin
                    {Busy1[tail], Busy1[tail + 2'd1]} <= {!Busy1[tail], !Busy1[tail + 2'd1]};
                    tail <= tail +2'd2;
                    op[tail] <= op1_in;
                    RA[tail] <= RA1_in;
                    RB[tail] <= RB1_in;
                    RC[tail] <= RC1_in;
                    comp[tail] <= comp1_in;
                    CZ[tail] <= CZ1_in;
                    Imm1[tail] <= Imm1_1_in;
                    Imm2[tail] <= Imm2_1_in;
                    SEI1[tail] <= SEI1_1_in;
                    SEI2[tail] <= SEI2_1_in;
                    branch_predict[tail] <= branch_predict1_in;
                    IA[tail] <= IA1_in;
                    spec_tag[tail] <= spec_tag1_in;
                    op[(tail + 1) % BUFFER_SIZE] <= op2_in;
                    RA[(tail + 1) % BUFFER_SIZE] <= RA2_in;
                    RB[(tail + 1) % BUFFER_SIZE] <= RB2_in;
                    RC[(tail + 1) % BUFFER_SIZE] <= RC2_in;
                    comp[(tail + 1) % BUFFER_SIZE] <= comp2_in;
                    CZ[(tail + 1) % BUFFER_SIZE] <= CZ2_in;
                    Imm1[(tail + 1) % BUFFER_SIZE] <= Imm1_2_in;
                    Imm2[(tail + 1) % BUFFER_SIZE] <= Imm2_2_in;
                    SEI1[(tail + 1) % BUFFER_SIZE] <= SEI1_2_in;
                    SEI2[(tail + 1) % BUFFER_SIZE] <= SEI2_2_in;
                    branch_predict[(tail + 1) % BUFFER_SIZE] <= branch_predict2_in;
                    IA[tail + 1] <= IA2_in;
                    spec_tag[tail + 1] <= spec_tag2_in;
                end
                else if (valid_in1 & !valid_in2) begin
                    Busy1[tail] <= !Busy1[tail];
                    tail <= tail + 2'd1;
                    op[tail] <= op1_in;
                    RA[tail] <= RA1_in;
                    RB[tail] <= RB1_in;
                    RC[tail] <= RC1_in;
                    comp[tail] <= comp1_in;
                    CZ[tail] <= CZ1_in;
                    Imm1[tail] <= Imm1_1_in;
                    Imm2[tail] <= Imm2_1_in;
                    SEI1[tail] <= SEI1_1_in;
                    SEI2[tail] <= SEI2_1_in;
                    branch_predict[tail] <= branch_predict1_in;
                    IA[tail] <= IA1_in;
                    spec_tag[tail] <= spec_tag1_in;
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
                    op1_out <= op[head];
                    RA1_out <= RA[head];
                    RB1_out <= RB[head];
                    RC1_out <= RC[head];
                    comp1_out <= comp[head];
                    CZ1_out <= CZ[head];
                    Imm1_1_out <= Imm1[head];
                    Imm2_1_out <= Imm2[head];
                    SEI1_1_out <= SEI1[head];
                    SEI2_1_out <= SEI2[head];
                    branch_predict1_out <= branch_predict[head];
                    IA1_out <= IA[head];
                    spec_tag1_out <= spec_tag[head];
                    op2_out <= op[(head + 1) % BUFFER_SIZE];
                    RA2_out <= RA[(head + 1) % BUFFER_SIZE];
                    RB2_out <= RB[(head + 1) % BUFFER_SIZE];
                    RC2_out <= RC[(head + 1) % BUFFER_SIZE];
                    comp2_out <= comp[(head + 1) % BUFFER_SIZE];
                    CZ2_out <= CZ[(head + 1) % BUFFER_SIZE];
                    Imm1_2_out <= Imm1[(head + 1) % BUFFER_SIZE];
                    Imm2_2_out <= Imm2[(head + 1) % BUFFER_SIZE];
                    SEI1_2_out <= SEI1[(head + 1) % BUFFER_SIZE];
                    SEI2_2_out <= SEI2[(head + 1) % BUFFER_SIZE];
                    branch_predict2_out <= branch_predict[(head + 1) % BUFFER_SIZE];
                    IA2_out <= IA[head + 1];
                    spec_tag2_out <= spec_tag[head + 1];
                    {valid_out1, valid_out2} <= 2'b11;
                end
                else if (Busy[head] & !Busy[head + 3'd1]) begin
                    op1_out <= op[head];
                    RA1_out <= RA[head];
                    RB1_out <= RB[head];
                    RC1_out <= RC[head];
                    comp1_out <= comp[head];
                    CZ1_out <= CZ[head];
                    Imm1_1_out <= Imm1[head];
                    Imm2_1_out <= Imm2[head];
                    SEI1_1_out <= SEI1[head];
                    SEI2_1_out <= SEI2[head];
                    branch_predict1_out <= branch_predict[head];
                    IA1_out <= IA[head];
                    spec_tag1_out <= spec_tag[head];
                    {valid_out1, valid_out2} <= 2'b10;
                end
                else begin
                    {valid_out1, valid_out2} <= 2'b00;
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
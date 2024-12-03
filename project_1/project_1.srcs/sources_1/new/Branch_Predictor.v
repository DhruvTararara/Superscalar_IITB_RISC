module Branch_Predictor(PC, branch_predict1, branch_predict_PC1, branch_predict2, branch_predict_PC2);
    input [15:0] PC;
    output branch_predict1, branch_predict2;
    output [15:0] branch_predict_PC1, branch_predict_PC2;
    wire [15:0] PC_plus_2;
    wire hit1, hit2;
    wire [2:0] BHSR_bits1, BHSR_bits2;
    reg [1:0] state1, state2;
    assign PC_plus_2 = PC +16'd2; 
    
    BTB btb(PC, PC_plus_2, hit1, hit2, branch_predict_PC1, branch_predict_PC2);
    BHT bht(PC[3:1], PC_plus_2[3:1], BHSR_bits1, BHSR_bits2);
    PHT pht(BHSR_bits1, BHSR_bits2, PC[3:1], PC_plus_2[3:1], state1, state2);
    //FSM Logic
    assign branch_predict1 = state1[1] | state1[0];
    assign branch_predict2 = state2[1] | state2[0];
    
endmodule

module BTB(clk, rst, address_in1, address_in2, hit1, hit2, address_out1, address_out2);
    input clk, rst;
    input [15:0] address_in1, address_in2;
    output hit1, hit2;
    output [15:0] address_out1, address_out2;
    reg [15:0] BIA [7:0];
    reg [15:0] BTA [7:0];
    
    assign address_out1 = (address_in1 == BIA[0])? BTA[0]:
                          (address_in1 == BIA[1])? BTA[1]:
                          (address_in1 == BIA[2])? BTA[2]:
                          (address_in1 == BIA[3])? BTA[3]:
                          (address_in1 == BIA[4])? BTA[4]:
                          (address_in1 == BIA[5])? BTA[5]:
                          (address_in1 == BIA[6])? BTA[6]:
                          (address_in1 == BIA[7])? BTA[7]:16'd0;
    assign hit1 = (address_in1 == BIA[0])? 1'b1:
                  (address_in1 == BIA[1])? 1'b1:
                  (address_in1 == BIA[2])? 1'b1:
                  (address_in1 == BIA[3])? 1'b1:
                  (address_in1 == BIA[4])? 1'b1:
                  (address_in1 == BIA[5])? 1'b1:
                  (address_in1 == BIA[6])? 1'b1:
                  (address_in1 == BIA[7])? 1'b1:1'd0;
                  
    assign address_out2 = (address_in2 == BIA[0])? BTA[0]:
                          (address_in2 == BIA[1])? BTA[1]:
                          (address_in2 == BIA[2])? BTA[2]:
                          (address_in2 == BIA[3])? BTA[3]:
                          (address_in2 == BIA[4])? BTA[4]:
                          (address_in2 == BIA[5])? BTA[5]:
                          (address_in2 == BIA[6])? BTA[6]:
                          (address_in2 == BIA[7])? BTA[7]:16'd0;
    assign hit2 = (address_in2 == BIA[0])? 1'b1:
                  (address_in2 == BIA[1])? 1'b1:
                  (address_in2 == BIA[2])? 1'b1:
                  (address_in2 == BIA[3])? 1'b1:
                  (address_in2 == BIA[4])? 1'b1:
                  (address_in2 == BIA[5])? 1'b1:
                  (address_in2 == BIA[6])? 1'b1:
                  (address_in2 == BIA[7])? 1'b1:1'd0;
    //Writing BTB
    integer i;
    always @ (posedge clk) begin
        if (rst) begin
            for (i = 0; i < 8; i = i + 1) begin
                BIA[i] <= 16'd0;
                BTA[i] <= 16'd0;
            end
        end
    end
endmodule

module BHT(clk, rst, address_in1_LSB3, address_in2_LSB3, BHSR_bits1, BHSR_bits2);
    input clk, rst;
    input [2:0] address_in1_LSB3, address_in2_LSB3;
    output [2:0] BHSR_bits1, BHSR_bits2;
    reg [2:0] BHSR [7:0];
    
    assign BHSR_bits1 = BHSR[address_in1_LSB3];
    assign BHSR_bits2 = BHSR[address_in2_LSB3];
    //Updating BHT of BHSRs
    integer i;
    always @ (posedge clk) begin
        if (rst) begin
            for (i = 0; i < 8; i = i + 1) begin
                BHSR[i] <= 3'd0;
            end
        end
    end
endmodule

module PHT(clk, rst, BHSR_bits1, address_in1_LSB3, BHSR_bits2, address_in2_LSB3, state1, state2);
    input clk, rst;
    input [2:0] BHSR_bits1,BHSR_bits2;
    input [2:0] address_in1_LSB3, address_in2_LSB3;
    output [1:0] state1, state2;
    reg [1:0] PHT [2:0][2:0];
    
    assign state1 = PHT[address_in1_LSB3][BHSR_bits1];
    assign state2 = PHT[address_in2_LSB3][BHSR_bits2];
    //Updating PHT
    integer i, j;
    always @ (posedge clk) begin
        if (rst) begin
            for (i = 0; i < 8; i = i + 1) begin
                for (j = 0; j < 8; j = j + 1) begin
                    PHT[i][j] <= 3'd0;
                end
            end
        end
    end
endmodule
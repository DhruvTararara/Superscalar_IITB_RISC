module Control_Unit(
    input [15:0] op1, op2,
    input RegWrite1, RegWrite2,
    input Comp1, Comp2,
    input [1:0] CZ1, CZ2,
    output reg [2:0] b_ctrl1, b_ctrl2,
    output reg [5:0] a_ctrl1, a_ctrl2,
    output reg [2:0] ls_ctrl1, ls_ctrl2,
    output reg [1:0] FU_bits1, FU_bits2);
    
    always @ (*) begin
        case (op1)
            4'b1101, 4'b1100, 4'b1111, 4'b1000, 4'b1001, 4'b1010: FU_bits1 <= 2'b01;
            4'b0000, 4'b0001, 4'b0010: FU_bits1 <= 2'b10;
            4'b0100, 4'b0101, 4'b0011: FU_bits1 <= 2'b11;
            default: FU_bits1 <= 2'b00;
        endcase
        case (op2)
            4'b1101, 4'b1100, 4'b1111, 4'b1000, 4'b1001, 4'b1010: FU_bits2 <= 2'b01;
            4'b0000, 4'b0001, 4'b0010: FU_bits2 <= 2'b10;
            4'b0100, 4'b0101, 4'b0011: FU_bits2 <= 2'b11;
            default: FU_bits1 <= 2'b00;
        endcase
    end
    
    always @ (*) begin
        case (op1)
            4'b1101: b_ctrl1 <= 3'b000;
            4'b1100: b_ctrl1 <= 3'b101;
            4'b1111: b_ctrl1 <= 3'b111;
            4'b1000: b_ctrl1 <= 3'b001;
            4'b1001: b_ctrl1 <= 3'b001;
            4'b1010: b_ctrl1 <= 3'b001;
            default: b_ctrl1 <= 3'b000;
        endcase
        case (op1)
            4'b0000: a_ctrl1 <= {Comp1, 1'b1, 2'b00, 1'b0, 1'b0};//Add without carry with no condition on C and Z
            4'b0001: a_ctrl1 <= {Comp1, 1'b0, (CZ1[1] & CZ1[0]), CZ1[1], CZ1[0]};//Add with or wothout carry with condition may or may not on C and Z
            4'b0010: a_ctrl1 <= {Comp1, 1'b0, 2'b10, CZ1[1], CZ1[0]};//NAND with condition may or may not on C and Z
            default: a_ctrl1 <= {Comp1, 1'b1, 2'b00, 1'b0, 1'b0};
        endcase
        case (op1)
            4'b0100: ls_ctrl1 <= 3'b100;//{MemRead, MemWrite, Ctrl1}; Ctrl1 is 1 when op = LLI
            4'b0101: ls_ctrl1 <= 3'b010;
            4'b0011: ls_ctrl1 <= 3'b001;
            default: ls_ctrl1 <= 3'b000;
        endcase
    end
    
    always @ (*) begin
        case (op2)
            4'b1101: b_ctrl2 <= 3'b000;
            4'b1100: b_ctrl2 <= 3'b101;
            4'b1111: b_ctrl2 <= 3'b111;
            4'b1000: b_ctrl2 <= 3'b001;
            4'b1001: b_ctrl2 <= 3'b001;
            4'b1010: b_ctrl2 <= 3'b001;
            default: b_ctrl2 <= 3'b000;
        endcase
        case (op2)
            4'b0000: a_ctrl2 <= {Comp2, 1'b1, 2'b00, 1'b0, 1'b0};//Add without carry with no condition on C and Z
            4'b0001: a_ctrl2 <= {Comp2, 1'b0, (CZ2[1] & CZ2[0]), CZ2[1], CZ2[0]};//Add with or wothout carry with condition may or may not on C and Z
            4'b0010: a_ctrl2 <= {Comp2, 1'b0, 2'b10, CZ2[1], CZ2[0]};//NAND with condition may or may not on C and Z
            default: a_ctrl2 <= {Comp2, 1'b1, 2'b00, 1'b0, 1'b0};
        endcase
        case (op2)
            4'b0100: ls_ctrl2 <= 3'b100;//{MemRead, MemWrite, Ctrl1}; Ctrl1 is 1 when op = LLI
            4'b0101: ls_ctrl2 <= 3'b010;
            4'b0011: ls_ctrl2 <= 3'b001;
            default: ls_ctrl2 <= 3'b000;
        endcase
    end
    
endmodule

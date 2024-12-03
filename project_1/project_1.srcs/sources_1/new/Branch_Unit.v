module Branch_Unit(
    input [3:0] op,
    input [2:0] ROB_tag,
    input [15:0] PC, ra, rb,
    input v_ra, v_rb,
    input [15:0] SEI1, SEI2,
    input [1:0] spec_tag,
    input b_p,
    input [3:0] b_ctrl,
    input valid,
    output [2:0] ROB_tag_out,
    output [15:0] PC_out,
    output spec_tag_out,
    output branch_resolve_PC,
    output reg T_NT,
    output misprediction,
    output b_r,
    output [15:0] Reg_data,
    output valid_out);
    
    wire [2:0] S = b_ctrl[3:1];
    wire ET, LT;
    wire [15:0] a, b;
    
    assign ROB_tag_out = ROB_tag;
    assign PC_out = PC;
    assign ET = (ra == rb);
    assign LT = (ra < rb);
    assign a = (S[1])? ra: PC;
    assign b = (S[2])? ({SEI2[14:0], 1'b0}): ({SEI1[14:0], 1'b0});
    assign branch_resolve_PC = (!S[0])? rb: (a + b);
    assign misprediction = b_p ^ T_NT;
    assign valid_out = valid;
    assign b_r = !b_p;
    assign Reg_data = PC + 16'd2;
    assign spec_tag_out = spec_tag;
    
    always @ (*) begin
        case (op)
            4'b1000: begin
                if (ET) T_NT <= 1'b0;
                else T_NT <= 1'b1;
            end
            4'b1001: begin
                if (LT) T_NT <= 1'b0;
                else T_NT <= 1'b1;
            end
            4'b1010: begin
                if ( ET | LT ) T_NT <= 1'b1;
                else T_NT <= 1'b0;  
            end
            4'b1101: T_NT <= 1'b1;
            4'b1100: T_NT <= 1'b1;
            4'b1111: T_NT <= 1'b1;
            default: T_NT <= 1'b0;
        endcase
    end
    
endmodule
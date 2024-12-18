`timescale 1ns / 1ps
module ALU(
    input [2:0] ROB_tag,
    input [15:0] PC, ra, rb, rc,
    input c, z,
    input v_ra, v_rb, v_rc, v_c, v_z,
    input [1:0] spec_tag,
    input [5:0] a_ctrl,
    input [15:0] SEI1,
    input valid,
    output valid_out,
    output [2:0] ROB_tag_out,
    output reg [15:0] alu_out,
    output [15:0] PC_out);
    assign PC_out = PC;
    assign valid_out = valid;
    assign ROB_tag_out = ROB_tag;
    wire select = ((!c) & (a_ctrl[1])) | ((!z) & (a_ctrl[0]));
    wire [1:0] ALUOp = a_ctrl[3:2];
    wire [15:0] rb_comp = (a_ctrl[5])? ~rb: rb;
    wire [15:0] rb_final = (a_ctrl[4])? SEI1: rb_comp;
    always @ (*) begin
        if (select) begin
            alu_out <= rc;
        end
        else begin
            case (ALUOp)
                2'b00: alu_out <= ra + rb_final;
                2'b01: alu_out <= ra + rb_final + {15'b0, c};
                2'b10: alu_out <= ~(ra & rb_final);
                default: alu_out <= ra + rb_final;
            endcase
        end
    end
    
endmodule
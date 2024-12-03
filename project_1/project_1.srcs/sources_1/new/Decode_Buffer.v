module decode_buffer(clk, rst, PC_in, instr1_in, valid1_in, valid2_in, instr2_in, 
                    branch_predict1_in, branch_predict2_in, address_out1, address_out2,
                    instr1_out, instr2_out, branch_predict1_out, branch_predict2_out, 
                    valid1_out, valid2_out);
    input clk, rst;
    input [15:0] PC_in;
    input [15:0] instr1_in, instr2_in;
    input branch_predict1_in, branch_predict2_in, valid1_in, valid2_in;
    output reg [15:0] address_out1, address_out2;
    output reg instr1_out, instr2_out;
    output reg branch_predict1_out, branch_predict2_out;
    output reg valid1_out, valid2_out;
    reg [1:0] head, tail;
    reg [2:0] count;
    reg [15:0] address_queue [3:0];
    reg [15:0] instr_queue [3:0];
    reg [3:0] branch_prediction;
    reg [3:0] valid;
    wire full, empty;
    
    always @ (posedge clk) begin
        if (rst) begin
            head <= 2'b00;
            tail <= 2'b00;
            count <= 3'b000;
            valid <= 4'b0000;
        end
        else begin
            if (valid1_in & !full) begin
                address_queue[tail] <= PC_in; 
                instr_queue[tail] <= instr1_in;
                valid[tail] <= 1'b1;
                branch_prediction[tail] <= branch_predict1_in;
                tail <= tail + 2'b1;
                count <= count + 3'b1;
                if (valid2_in & !branch_predict1_in & count < 3'd3) begin
                    address_queue[tail+2'd1] <= PC_in + 2'd2;
                    instr_queue[tail+2'd1] <= instr2_in;
                    valid[tail+2'd1] <= 1'b1;
                    branch_prediction[tail+2'd1] <= branch_predict2_in;
                    tail <= tail + 2'd2;
                    count <= count + 3'd2;
                end
            end
            
            if (!empty) begin
                address_out1 <= address_queue[head];
                instr1_out <= instr_queue[head];
                branch_predict1_out <= branch_prediction[head];
                valid1_out <= valid[head];
                head <= (head + 2'd1);
                count <= count - 2'd1;
                if (count >= 2) begin
                    address_out2 <= address_queue[head+2'd1];
                    instr2_out <= instr_queue[head+2'd1];
                    branch_predict2_out <= branch_prediction[head+2'd1];
                    valid2_out <= valid[head+2'd1];
                    head <= head + 2'd2;
                    count <= count - 3'd2;
                end
                else begin
                    valid2_out <= 1'b0;
                end
            end
            else begin
                valid1_out <= 1'b0;
                valid2_out <= 1'b0;
            end
        end
    end
    assign full = (count >= 3);
    assign empty = (count == 3'd0);
    
endmodule
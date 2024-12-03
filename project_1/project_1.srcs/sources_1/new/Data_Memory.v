module Data_Memory(
    input clk, rst,
    input [15:0] addr,
    input [15:0] write_data,
    input MemRead, MemWrite,
    output [15:0] dm_data
    );
    parameter depth = 2**16;
    reg [7:0] mem [depth - 1: 0];
    
     assign dm_data = (MemRead)? {mem[addr+1], mem[addr]}: 16'h0;
    
    always @ (posedge clk) begin
        if (!rst & MemWrite) begin
            mem[addr] <= write_data[7:0];
            mem[addr+1] <= write_data[15:8];
        end
    end
    
endmodule

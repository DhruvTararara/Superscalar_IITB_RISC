module testbench();
    reg clk;
    reg rst;
    
    Superscalar_Processor_wrapper processor(clk, rst);
    
    initial begin
        clk = 1'b0;
        forever #10 clk = ~clk; 
    end
    initial begin
        rst = 1'b0;
        #11 rst = 1'b1;
        #20 rst = 1'b0;
    end
    initial begin
        //$readmemh("C:/Xilinx/IITB_RISC/memory.txt", processor.IITB_RISC_i.Instruction_Memory_0.inst.mem);
        //$readmemh("C:/Xilinx/IITB_RISC/memory.txt", processor.IITB_RISC_i.Data_memory_0.inst.mem);
    end
endmodule


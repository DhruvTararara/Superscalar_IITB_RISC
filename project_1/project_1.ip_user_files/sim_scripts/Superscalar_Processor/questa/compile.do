vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/xlconstant_v1_1_6

vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap xlconstant_v1_1_6 questa_lib/msim/xlconstant_v1_1_6

vlog -work xil_defaultlib -64 \
"../../../bd/Superscalar_Processor/ip/Superscalar_Processor_decode_buffer_0_0/sim/Superscalar_Processor_decode_buffer_0_0.v" \
"../../../bd/Superscalar_Processor/ip/Superscalar_Processor_PC_0_0/sim/Superscalar_Processor_PC_0_0.v" \
"../../../bd/Superscalar_Processor/ip/Superscalar_Processor_Instruction_Memory_0_0/sim/Superscalar_Processor_Instruction_Memory_0_0.v" \
"../../../bd/Superscalar_Processor/ip/Superscalar_Processor_Valid_instruction_ch_0_0/sim/Superscalar_Processor_Valid_instruction_ch_0_0.v" \
"../../../bd/Superscalar_Processor/ip/Superscalar_Processor_DispatchBuffer_0_0/sim/Superscalar_Processor_DispatchBuffer_0_0.v" \
"../../../bd/Superscalar_Processor/ip/Superscalar_Processor_Allocate_unit_0_0/sim/Superscalar_Processor_Allocate_unit_0_0.v" \
"../../../bd/Superscalar_Processor/ip/Superscalar_Processor_Reservation_Station_0_0/sim/Superscalar_Processor_Reservation_Station_0_0.v" \
"../../../bd/Superscalar_Processor/ip/Superscalar_Processor_Reorder_Buffer_0_0/sim/Superscalar_Processor_Reorder_Buffer_0_0.v" \
"../../../bd/Superscalar_Processor/ip/Superscalar_Processor_Register_Interdepend_0_0/sim/Superscalar_Processor_Register_Interdepend_0_0.v" \
"../../../bd/Superscalar_Processor/ip/Superscalar_Processor_Register_File_0_0/sim/Superscalar_Processor_Register_File_0_0.v" \
"../../../bd/Superscalar_Processor/ip/Superscalar_Processor_ALU_0_0/sim/Superscalar_Processor_ALU_0_0.v" \

vlog -work xlconstant_v1_1_6 -64 \
"../../../../project_1.srcs/sources_1/bd/Superscalar_Processor/ipshared/66e7/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 \
"../../../bd/Superscalar_Processor/ip/Superscalar_Processor_xlconstant_0_0/sim/Superscalar_Processor_xlconstant_0_0.v" \
"../../../bd/Superscalar_Processor/ip/Superscalar_Processor_decode_0_1/sim/Superscalar_Processor_decode_0_1.v" \
"../../../bd/Superscalar_Processor/ip/Superscalar_Processor_RegWrite_Ctrl_0_0/sim/Superscalar_Processor_RegWrite_Ctrl_0_0.v" \
"../../../bd/Superscalar_Processor/ip/Superscalar_Processor_Control_Unit_0_0/sim/Superscalar_Processor_Control_Unit_0_0.v" \
"../../../bd/Superscalar_Processor/ip/Superscalar_Processor_Issue_Unit_0_0/sim/Superscalar_Processor_Issue_Unit_0_0.v" \
"../../../bd/Superscalar_Processor/ip/Superscalar_Processor_Write_back_signals_0_0/sim/Superscalar_Processor_Write_back_signals_0_0.v" \
"../../../bd/Superscalar_Processor/ip/Superscalar_Processor_ALU_1_0/sim/Superscalar_Processor_ALU_1_0.v" \
"../../../bd/Superscalar_Processor/ip/Superscalar_Processor_xlconstant_1_0/sim/Superscalar_Processor_xlconstant_1_0.v" \
"../../../bd/Superscalar_Processor/sim/Superscalar_Processor.v" \

vlog -work xil_defaultlib \
"glbl.v"


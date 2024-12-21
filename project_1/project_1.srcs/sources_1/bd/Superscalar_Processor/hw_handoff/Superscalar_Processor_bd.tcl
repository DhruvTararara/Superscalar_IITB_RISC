
################################################################
# This is a generated script based on design: Superscalar_Processor
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2019.1
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source Superscalar_Processor_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# ALU, ALU, Allocate_unit, Control_Unit, DispatchBuffer, Instruction_Memory, Issue_Unit, PC, RegWrite_Ctrl, Register_File, Register_Interdependence, Reorder_Buffer, Reservation_Station, Valid_instruction_checker, Write_back_signals, decode, decode_buffer

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7k70tfbv676-1
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name Superscalar_Processor

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set Busy_0 [ create_bd_port -dir O -from 7 -to 0 Busy_0 ]
  set Imm1_1_out_0 [ create_bd_port -dir O -from 5 -to 0 Imm1_1_out_0 ]
  set Imm1_2_out_0 [ create_bd_port -dir O -from 5 -to 0 Imm1_2_out_0 ]
  set Imm2_l_0 [ create_bd_port -dir O -from 8 -to 0 Imm2_l_0 ]
  set PC_b_0 [ create_bd_port -dir O -from 15 -to 0 PC_b_0 ]
  set PC_l_0 [ create_bd_port -dir O -from 15 -to 0 PC_l_0 ]
  set ROB_tag_b_0 [ create_bd_port -dir O -from 2 -to 0 ROB_tag_b_0 ]
  set ROB_tag_l_0 [ create_bd_port -dir O -from 2 -to 0 ROB_tag_l_0 ]
  set SEI1_b_0 [ create_bd_port -dir O -from 15 -to 0 SEI1_b_0 ]
  set SEI1_l_0 [ create_bd_port -dir O -from 15 -to 0 SEI1_l_0 ]
  set SEI2_b_0 [ create_bd_port -dir O -from 15 -to 0 SEI2_b_0 ]
  set SEI2_l_0 [ create_bd_port -dir O -from 15 -to 0 SEI2_l_0 ]
  set b_ctrl_b_0 [ create_bd_port -dir O -from 3 -to 0 b_ctrl_b_0 ]
  set b_p_b_0 [ create_bd_port -dir O b_p_b_0 ]
  set clk_0 [ create_bd_port -dir I -type clk clk_0 ]
  set empty_0 [ create_bd_port -dir O empty_0 ]
  set full_0 [ create_bd_port -dir O full_0 ]
  set ls_ctrl_l_0 [ create_bd_port -dir O -from 2 -to 0 ls_ctrl_l_0 ]
  set op_b_0 [ create_bd_port -dir O -from 3 -to 0 op_b_0 ]
  set ra_b_0 [ create_bd_port -dir O -from 15 -to 0 ra_b_0 ]
  set ra_l_0 [ create_bd_port -dir O -from 15 -to 0 ra_l_0 ]
  set rb_b_0 [ create_bd_port -dir O -from 15 -to 0 rb_b_0 ]
  set rb_l_0 [ create_bd_port -dir O -from 15 -to 0 rb_l_0 ]
  set rst_0 [ create_bd_port -dir I -type rst rst_0 ]
  set spec_tag_b_0 [ create_bd_port -dir O -from 1 -to 0 spec_tag_b_0 ]
  set spec_tag_l_0 [ create_bd_port -dir O -from 1 -to 0 spec_tag_l_0 ]
  set stall_0 [ create_bd_port -dir O stall_0 ]
  set v_ra_b_0 [ create_bd_port -dir O v_ra_b_0 ]
  set v_ra_l_0 [ create_bd_port -dir O v_ra_l_0 ]
  set v_rb_b_0 [ create_bd_port -dir O v_rb_b_0 ]
  set v_rb_l_0 [ create_bd_port -dir O v_rb_l_0 ]
  set valid_b_0 [ create_bd_port -dir O valid_b_0 ]
  set valid_l_0 [ create_bd_port -dir O valid_l_0 ]
  set wC1_0 [ create_bd_port -dir O wC1_0 ]
  set wC2_0 [ create_bd_port -dir O wC2_0 ]
  set wZ1_0 [ create_bd_port -dir O wZ1_0 ]
  set wZ2_0 [ create_bd_port -dir O wZ2_0 ]

  # Create instance: ALU_0, and set properties
  set block_name ALU
  set block_cell_name ALU_0
  if { [catch {set ALU_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ALU_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: ALU_1, and set properties
  set block_name ALU
  set block_cell_name ALU_1
  if { [catch {set ALU_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $ALU_1 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: Allocate_unit_0, and set properties
  set block_name Allocate_unit
  set block_cell_name Allocate_unit_0
  if { [catch {set Allocate_unit_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $Allocate_unit_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: Control_Unit_0, and set properties
  set block_name Control_Unit
  set block_cell_name Control_Unit_0
  if { [catch {set Control_Unit_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $Control_Unit_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: DispatchBuffer_0, and set properties
  set block_name DispatchBuffer
  set block_cell_name DispatchBuffer_0
  if { [catch {set DispatchBuffer_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $DispatchBuffer_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: Instruction_Memory_0, and set properties
  set block_name Instruction_Memory
  set block_cell_name Instruction_Memory_0
  if { [catch {set Instruction_Memory_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $Instruction_Memory_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: Issue_Unit_0, and set properties
  set block_name Issue_Unit
  set block_cell_name Issue_Unit_0
  if { [catch {set Issue_Unit_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $Issue_Unit_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: PC_0, and set properties
  set block_name PC
  set block_cell_name PC_0
  if { [catch {set PC_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $PC_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: RegWrite_Ctrl_0, and set properties
  set block_name RegWrite_Ctrl
  set block_cell_name RegWrite_Ctrl_0
  if { [catch {set RegWrite_Ctrl_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $RegWrite_Ctrl_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: Register_File_1, and set properties
  set block_name Register_File
  set block_cell_name Register_File_1
  if { [catch {set Register_File_1 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $Register_File_1 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: Register_Interdepend_0, and set properties
  set block_name Register_Interdependence
  set block_cell_name Register_Interdepend_0
  if { [catch {set Register_Interdepend_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $Register_Interdepend_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: Reorder_Buffer_0, and set properties
  set block_name Reorder_Buffer
  set block_cell_name Reorder_Buffer_0
  if { [catch {set Reorder_Buffer_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $Reorder_Buffer_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: Reservation_Station_0, and set properties
  set block_name Reservation_Station
  set block_cell_name Reservation_Station_0
  if { [catch {set Reservation_Station_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $Reservation_Station_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: Valid_instruction_ch_0, and set properties
  set block_name Valid_instruction_checker
  set block_cell_name Valid_instruction_ch_0
  if { [catch {set Valid_instruction_ch_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $Valid_instruction_ch_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: Write_back_signals_0, and set properties
  set block_name Write_back_signals
  set block_cell_name Write_back_signals_0
  if { [catch {set Write_back_signals_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $Write_back_signals_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: decode_0, and set properties
  set block_name decode
  set block_cell_name decode_0
  if { [catch {set decode_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $decode_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: decode_buffer_0, and set properties
  set block_name decode_buffer
  set block_cell_name decode_buffer_0
  if { [catch {set decode_buffer_0 [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $decode_buffer_0 eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {0} \
 ] $xlconstant_0

  # Create instance: xlconstant_1, and set properties
  set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1 ]

  # Create port connections
  connect_bd_net -net ALU_0_PC_out [get_bd_pins ALU_0/PC_out] [get_bd_pins Reorder_Buffer_0/PC_a_cdb]
  connect_bd_net -net ALU_0_ROB_tag_out [get_bd_pins ALU_0/ROB_tag_out] [get_bd_pins Register_File_1/ROB_a_cdb] [get_bd_pins Reorder_Buffer_0/ROB_a_cdb] [get_bd_pins Reservation_Station_0/ROB_a_cdb]
  connect_bd_net -net ALU_0_alu_out [get_bd_pins ALU_0/alu_out] [get_bd_pins Register_File_1/alu_out] [get_bd_pins Reorder_Buffer_0/alu_out] [get_bd_pins Reservation_Station_0/alu_out]
  connect_bd_net -net ALU_0_valid_out [get_bd_pins ALU_0/valid_out] [get_bd_pins Register_File_1/valid_a_cdb] [get_bd_pins Reorder_Buffer_0/valid_a_cdb] [get_bd_pins Reservation_Station_0/valid_a_cdb]
  connect_bd_net -net ALU_1_PC_out [get_bd_pins ALU_1/PC_out] [get_bd_pins Reorder_Buffer_0/PC_a2_cdb]
  connect_bd_net -net ALU_1_ROB_tag_out [get_bd_pins ALU_1/ROB_tag_out] [get_bd_pins Register_File_1/ROB_a2_cdb] [get_bd_pins Reorder_Buffer_0/ROB_a2_cdb] [get_bd_pins Reservation_Station_0/ROB_a2_cdb]
  connect_bd_net -net ALU_1_alu_out [get_bd_pins ALU_1/alu_out] [get_bd_pins Register_File_1/alu2_out] [get_bd_pins Reorder_Buffer_0/alu2_out] [get_bd_pins Reservation_Station_0/alu2_out]
  connect_bd_net -net ALU_1_valid_out [get_bd_pins ALU_1/valid_out] [get_bd_pins Register_File_1/valid_a2_cdb] [get_bd_pins Reorder_Buffer_0/valid_a2_cdb] [get_bd_pins Reservation_Station_0/valid_a2_cdb]
  connect_bd_net -net Allocate_unit_0_FU_bits1_out [get_bd_pins Allocate_unit_0/FU_bits1_out] [get_bd_pins Register_File_1/FU_bits1]
  connect_bd_net -net Allocate_unit_0_FU_bits2_out [get_bd_pins Allocate_unit_0/FU_bits2_out] [get_bd_pins Register_File_1/FU_bits2]
  connect_bd_net -net Allocate_unit_0_RA1_out [get_bd_pins Allocate_unit_0/RA1_out] [get_bd_pins Register_File_1/RAA1]
  connect_bd_net -net Allocate_unit_0_RA2_out [get_bd_pins Allocate_unit_0/RA2_out] [get_bd_pins Register_File_1/RAA2]
  connect_bd_net -net Allocate_unit_0_RB1_out [get_bd_pins Allocate_unit_0/RB1_out] [get_bd_pins Register_File_1/RBB1]
  connect_bd_net -net Allocate_unit_0_RB2_out [get_bd_pins Allocate_unit_0/RB2_out] [get_bd_pins Register_File_1/RBB2]
  connect_bd_net -net Allocate_unit_0_RC1_out [get_bd_pins Allocate_unit_0/RC1_out] [get_bd_pins Register_File_1/RCC1]
  connect_bd_net -net Allocate_unit_0_RC2_out [get_bd_pins Allocate_unit_0/RC2_out] [get_bd_pins Register_File_1/RCC2]
  connect_bd_net -net Allocate_unit_0_ROB_input1 [get_bd_pins Allocate_unit_0/ROB_input1] [get_bd_pins Reorder_Buffer_0/ROB_input1]
  connect_bd_net -net Allocate_unit_0_ROB_input2 [get_bd_pins Allocate_unit_0/ROB_input2] [get_bd_pins Reorder_Buffer_0/ROB_input2]
  connect_bd_net -net Allocate_unit_0_ROB_tag1 [get_bd_pins Allocate_unit_0/ROB_tag1] [get_bd_pins Register_File_1/ROB_tag1] [get_bd_pins Reorder_Buffer_0/ROB_tag1]
  connect_bd_net -net Allocate_unit_0_ROB_tag2 [get_bd_pins Allocate_unit_0/ROB_tag2] [get_bd_pins Register_File_1/ROB_tag2] [get_bd_pins Reorder_Buffer_0/ROB_tag2]
  connect_bd_net -net Allocate_unit_0_RS_input1 [get_bd_pins Allocate_unit_0/RS_input1] [get_bd_pins Reservation_Station_0/RS_input1]
  connect_bd_net -net Allocate_unit_0_RS_input2 [get_bd_pins Allocate_unit_0/RS_input2] [get_bd_pins Reservation_Station_0/RS_input2]
  connect_bd_net -net Allocate_unit_0_RS_tag1 [get_bd_pins Allocate_unit_0/RS_tag1] [get_bd_pins Reservation_Station_0/RS_tag1]
  connect_bd_net -net Allocate_unit_0_RS_tag2 [get_bd_pins Allocate_unit_0/RS_tag2] [get_bd_pins Reservation_Station_0/RS_tag2]
  connect_bd_net -net Allocate_unit_0_RegWrite1_out [get_bd_pins Allocate_unit_0/RegWrite1_out] [get_bd_pins Register_File_1/RegWrite1]
  connect_bd_net -net Allocate_unit_0_RegWrite2_out [get_bd_pins Allocate_unit_0/RegWrite2_out] [get_bd_pins Register_File_1/RegWrite2]
  connect_bd_net -net Allocate_unit_0_op1_out [get_bd_pins Allocate_unit_0/op1_out] [get_bd_pins Register_File_1/op1]
  connect_bd_net -net Allocate_unit_0_op2_out [get_bd_pins Allocate_unit_0/op2_out] [get_bd_pins Register_File_1/op2]
  connect_bd_net -net Allocate_unit_0_stall [get_bd_ports stall_0] [get_bd_pins Allocate_unit_0/stall]
  connect_bd_net -net Allocate_unit_0_valid1_out [get_bd_pins Allocate_unit_0/valid1_out] [get_bd_pins Register_File_1/valid1] [get_bd_pins Reorder_Buffer_0/valid1] [get_bd_pins Reservation_Station_0/valid1]
  connect_bd_net -net Allocate_unit_0_valid2_out [get_bd_pins Allocate_unit_0/valid2_out] [get_bd_pins Register_File_1/valid2] [get_bd_pins Reorder_Buffer_0/valid2] [get_bd_pins Reservation_Station_0/valid2]
  connect_bd_net -net Control_Unit_0_FU_bits1 [get_bd_pins Allocate_unit_0/FU_bits1] [get_bd_pins Control_Unit_0/FU_bits1] [get_bd_pins Register_Interdepend_0/FU_bits1]
  connect_bd_net -net Control_Unit_0_FU_bits2 [get_bd_pins Allocate_unit_0/FU_bits2] [get_bd_pins Control_Unit_0/FU_bits2] [get_bd_pins Register_Interdepend_0/FU_bits2]
  connect_bd_net -net Control_Unit_0_a_ctrl1 [get_bd_pins Allocate_unit_0/a_ctrl1] [get_bd_pins Control_Unit_0/a_ctrl1]
  connect_bd_net -net Control_Unit_0_a_ctrl2 [get_bd_pins Allocate_unit_0/a_ctrl2] [get_bd_pins Control_Unit_0/a_ctrl2]
  connect_bd_net -net Control_Unit_0_b_ctrl1 [get_bd_pins Allocate_unit_0/b_ctrl1] [get_bd_pins Control_Unit_0/b_ctrl1]
  connect_bd_net -net Control_Unit_0_b_ctrl2 [get_bd_pins Allocate_unit_0/b_ctrl2] [get_bd_pins Control_Unit_0/b_ctrl2]
  connect_bd_net -net Control_Unit_0_ls_ctrl1 [get_bd_pins Allocate_unit_0/ls_ctrl1] [get_bd_pins Control_Unit_0/ls_ctrl1]
  connect_bd_net -net Control_Unit_0_ls_ctrl2 [get_bd_pins Allocate_unit_0/ls_ctrl2] [get_bd_pins Control_Unit_0/ls_ctrl2]
  connect_bd_net -net DispatchBuffer_0_CZ1_out [get_bd_pins Control_Unit_0/CZ1] [get_bd_pins DispatchBuffer_0/CZ1_out]
  connect_bd_net -net DispatchBuffer_0_CZ2_out [get_bd_pins Control_Unit_0/CZ2] [get_bd_pins DispatchBuffer_0/CZ2_out]
  connect_bd_net -net DispatchBuffer_0_IA1_out [get_bd_pins Allocate_unit_0/PC1] [get_bd_pins DispatchBuffer_0/IA1_out]
  connect_bd_net -net DispatchBuffer_0_IA2_out [get_bd_pins Allocate_unit_0/PC2] [get_bd_pins DispatchBuffer_0/IA2_out]
  connect_bd_net -net DispatchBuffer_0_Imm1_1_out [get_bd_ports Imm1_1_out_0] [get_bd_pins DispatchBuffer_0/Imm1_1_out]
  connect_bd_net -net DispatchBuffer_0_Imm1_2_out [get_bd_ports Imm1_2_out_0] [get_bd_pins DispatchBuffer_0/Imm1_2_out]
  connect_bd_net -net DispatchBuffer_0_Imm2_1_out [get_bd_pins Allocate_unit_0/Imm2_1] [get_bd_pins DispatchBuffer_0/Imm2_1_out]
  connect_bd_net -net DispatchBuffer_0_Imm2_2_out [get_bd_pins Allocate_unit_0/Imm2_2] [get_bd_pins DispatchBuffer_0/Imm2_2_out]
  connect_bd_net -net DispatchBuffer_0_RA1_out [get_bd_pins Allocate_unit_0/RAA1] [get_bd_pins DispatchBuffer_0/RA1_out] [get_bd_pins Register_Interdepend_0/RA1]
  connect_bd_net -net DispatchBuffer_0_RA2_out [get_bd_pins Allocate_unit_0/RAA2] [get_bd_pins DispatchBuffer_0/RA2_out] [get_bd_pins Register_Interdepend_0/RA2]
  connect_bd_net -net DispatchBuffer_0_RB1_out [get_bd_pins Allocate_unit_0/RBB1] [get_bd_pins DispatchBuffer_0/RB1_out] [get_bd_pins Register_Interdepend_0/RB1]
  connect_bd_net -net DispatchBuffer_0_RB2_out [get_bd_pins Allocate_unit_0/RBB2] [get_bd_pins DispatchBuffer_0/RB2_out] [get_bd_pins Register_Interdepend_0/RB2]
  connect_bd_net -net DispatchBuffer_0_RC1_out [get_bd_pins Allocate_unit_0/RCC1] [get_bd_pins DispatchBuffer_0/RC1_out] [get_bd_pins Register_Interdepend_0/RC1]
  connect_bd_net -net DispatchBuffer_0_RC2_out [get_bd_pins Allocate_unit_0/RCC2] [get_bd_pins DispatchBuffer_0/RC2_out] [get_bd_pins Register_Interdepend_0/RC2]
  connect_bd_net -net DispatchBuffer_0_SEI1_1_out [get_bd_pins Allocate_unit_0/SEI1_1] [get_bd_pins DispatchBuffer_0/SEI1_1_out]
  connect_bd_net -net DispatchBuffer_0_SEI1_2_out [get_bd_pins Allocate_unit_0/SEI1_2] [get_bd_pins DispatchBuffer_0/SEI1_2_out]
  connect_bd_net -net DispatchBuffer_0_SEI2_1_out [get_bd_pins Allocate_unit_0/SEI2_1] [get_bd_pins DispatchBuffer_0/SEI2_1_out]
  connect_bd_net -net DispatchBuffer_0_SEI2_2_out [get_bd_pins Allocate_unit_0/SEI2_2] [get_bd_pins DispatchBuffer_0/SEI2_2_out]
  connect_bd_net -net DispatchBuffer_0_branch_predict1_out [get_bd_pins Allocate_unit_0/branch_predict1] [get_bd_pins DispatchBuffer_0/branch_predict1_out]
  connect_bd_net -net DispatchBuffer_0_branch_predict2_out [get_bd_pins Allocate_unit_0/branch_predict2] [get_bd_pins DispatchBuffer_0/branch_predict2_out]
  connect_bd_net -net DispatchBuffer_0_comp1_out [get_bd_pins Control_Unit_0/Comp1] [get_bd_pins DispatchBuffer_0/comp1_out]
  connect_bd_net -net DispatchBuffer_0_comp2_out [get_bd_pins Control_Unit_0/Comp2] [get_bd_pins DispatchBuffer_0/comp2_out]
  connect_bd_net -net DispatchBuffer_0_empty [get_bd_ports empty_0] [get_bd_pins DispatchBuffer_0/empty]
  connect_bd_net -net DispatchBuffer_0_full [get_bd_ports full_0] [get_bd_pins DispatchBuffer_0/full]
  connect_bd_net -net DispatchBuffer_0_op1_out [get_bd_pins Allocate_unit_0/op1] [get_bd_pins Control_Unit_0/op1] [get_bd_pins DispatchBuffer_0/op1_out] [get_bd_pins RegWrite_Ctrl_0/op1]
  connect_bd_net -net DispatchBuffer_0_op2_out [get_bd_pins Allocate_unit_0/op2] [get_bd_pins Control_Unit_0/op2] [get_bd_pins DispatchBuffer_0/op2_out] [get_bd_pins RegWrite_Ctrl_0/op2]
  connect_bd_net -net DispatchBuffer_0_spec_tag1_out [get_bd_pins Allocate_unit_0/spec_tag1] [get_bd_pins DispatchBuffer_0/spec_tag1_out]
  connect_bd_net -net DispatchBuffer_0_spec_tag2_out [get_bd_pins Allocate_unit_0/spec_tag2] [get_bd_pins DispatchBuffer_0/spec_tag2_out]
  connect_bd_net -net DispatchBuffer_0_valid_out1 [get_bd_pins Allocate_unit_0/valid1] [get_bd_pins DispatchBuffer_0/valid_out1] [get_bd_pins RegWrite_Ctrl_0/valid1]
  connect_bd_net -net DispatchBuffer_0_valid_out2 [get_bd_pins Allocate_unit_0/valid2] [get_bd_pins DispatchBuffer_0/valid_out2] [get_bd_pins RegWrite_Ctrl_0/valid2]
  connect_bd_net -net Instruction_Memory_0_instr1 [get_bd_pins Instruction_Memory_0/instr1] [get_bd_pins Valid_instruction_ch_0/instr1] [get_bd_pins decode_buffer_0/instr1_in]
  connect_bd_net -net Instruction_Memory_0_instr2 [get_bd_pins Instruction_Memory_0/instr2] [get_bd_pins Valid_instruction_ch_0/instr2] [get_bd_pins decode_buffer_0/instr2_in]
  connect_bd_net -net Issue_Unit_0_Issue_RS_a [get_bd_pins Issue_Unit_0/Issue_RS_a] [get_bd_pins Reservation_Station_0/issue_RS_a]
  connect_bd_net -net Issue_Unit_0_Issue_RS_a2 [get_bd_pins Issue_Unit_0/Issue_RS_a2] [get_bd_pins Reservation_Station_0/issue_RS_a2]
  connect_bd_net -net Issue_Unit_0_Issue_RS_b [get_bd_pins Issue_Unit_0/Issue_RS_b] [get_bd_pins Reservation_Station_0/issue_RS_b]
  connect_bd_net -net Issue_Unit_0_Issue_RS_ls [get_bd_pins Issue_Unit_0/Issue_RS_ls] [get_bd_pins Reservation_Station_0/issue_RS_ls]
  connect_bd_net -net Issue_Unit_0_PC_a2i [get_bd_pins Issue_Unit_0/PC_a2i] [get_bd_pins Reorder_Buffer_0/PC_a2i]
  connect_bd_net -net Issue_Unit_0_PC_ai [get_bd_pins Issue_Unit_0/PC_ai] [get_bd_pins Reorder_Buffer_0/PC_ai]
  connect_bd_net -net Issue_Unit_0_PC_bi [get_bd_pins Issue_Unit_0/PC_bi] [get_bd_pins Reorder_Buffer_0/PC_bi]
  connect_bd_net -net Issue_Unit_0_PC_lsi [get_bd_pins Issue_Unit_0/PC_lsi] [get_bd_pins Reorder_Buffer_0/PC_lsi]
  connect_bd_net -net Issue_Unit_0_valid_issue_a [get_bd_pins Issue_Unit_0/valid_issue_a] [get_bd_pins Reorder_Buffer_0/valid_ai] [get_bd_pins Reservation_Station_0/valid_issue_a]
  connect_bd_net -net Issue_Unit_0_valid_issue_a2 [get_bd_pins Issue_Unit_0/valid_issue_a2] [get_bd_pins Reorder_Buffer_0/valid_a2i] [get_bd_pins Reservation_Station_0/valid_issue_a2]
  connect_bd_net -net Issue_Unit_0_valid_issue_b [get_bd_pins Issue_Unit_0/valid_issue_b] [get_bd_pins Reorder_Buffer_0/valid_bi] [get_bd_pins Reservation_Station_0/valid_issue_b]
  connect_bd_net -net Issue_Unit_0_valid_issue_ls [get_bd_pins Issue_Unit_0/valid_issue_ls] [get_bd_pins Reorder_Buffer_0/valid_lsi] [get_bd_pins Reservation_Station_0/valid_issue_ls]
  connect_bd_net -net PC_0_PC_out [get_bd_pins Instruction_Memory_0/PC] [get_bd_pins PC_0/PC_in] [get_bd_pins PC_0/PC_out] [get_bd_pins decode_buffer_0/PC_in]
  connect_bd_net -net RegWrite_Ctrl_0_RegWrite1 [get_bd_pins Allocate_unit_0/RegWrite1] [get_bd_pins Control_Unit_0/RegWrite1] [get_bd_pins RegWrite_Ctrl_0/RegWrite1] [get_bd_pins Register_Interdepend_0/RW1]
  connect_bd_net -net RegWrite_Ctrl_0_RegWrite2 [get_bd_pins Allocate_unit_0/RegWrite2] [get_bd_pins Control_Unit_0/RegWrite2] [get_bd_pins RegWrite_Ctrl_0/RegWrite2] [get_bd_pins Register_Interdepend_0/RW2]
  connect_bd_net -net Register_File_1_RDD1_out [get_bd_pins Allocate_unit_0/Rd1] [get_bd_pins Register_File_1/RDD1_out] [get_bd_pins Register_Interdepend_0/Rd1]
  connect_bd_net -net Register_File_1_RDD2_out [get_bd_pins Allocate_unit_0/Rd2] [get_bd_pins Register_File_1/RDD2_out] [get_bd_pins Register_Interdepend_0/Rd2]
  connect_bd_net -net Register_File_1_ra1 [get_bd_pins Allocate_unit_0/ra1] [get_bd_pins Register_File_1/ra1]
  connect_bd_net -net Register_File_1_ra2 [get_bd_pins Allocate_unit_0/ra2] [get_bd_pins Register_File_1/ra2]
  connect_bd_net -net Register_File_1_rb1 [get_bd_pins Allocate_unit_0/rb1] [get_bd_pins Register_File_1/rb1]
  connect_bd_net -net Register_File_1_rb2 [get_bd_pins Allocate_unit_0/rb2] [get_bd_pins Register_File_1/rb2]
  connect_bd_net -net Register_File_1_rc1 [get_bd_pins Allocate_unit_0/rc1] [get_bd_pins Register_File_1/rc1]
  connect_bd_net -net Register_File_1_rc2 [get_bd_pins Allocate_unit_0/rc2] [get_bd_pins Register_File_1/rc2]
  connect_bd_net -net Register_File_1_v_ra1 [get_bd_pins Allocate_unit_0/v_ra1] [get_bd_pins Register_File_1/v_ra1]
  connect_bd_net -net Register_File_1_v_ra2 [get_bd_pins Allocate_unit_0/v_ra2] [get_bd_pins Register_File_1/v_ra2]
  connect_bd_net -net Register_File_1_v_rb1 [get_bd_pins Allocate_unit_0/v_rb1] [get_bd_pins Register_File_1/v_rb1]
  connect_bd_net -net Register_File_1_v_rb2 [get_bd_pins Allocate_unit_0/v_rb2] [get_bd_pins Register_File_1/v_rb2]
  connect_bd_net -net Register_File_1_v_rc1 [get_bd_pins Allocate_unit_0/v_rc1] [get_bd_pins Register_File_1/v_rc1]
  connect_bd_net -net Register_File_1_v_rc2 [get_bd_pins Allocate_unit_0/v_rc2] [get_bd_pins Register_File_1/v_rc2]
  connect_bd_net -net Register_Interdepend_0_RAW [get_bd_pins Register_File_1/RAW] [get_bd_pins Register_Interdepend_0/RAW]
  connect_bd_net -net Register_Interdepend_0_WAR [get_bd_pins Register_File_1/WAR] [get_bd_pins Register_Interdepend_0/WAR]
  connect_bd_net -net Register_Interdepend_0_WAW [get_bd_pins Register_File_1/WAW] [get_bd_pins Register_Interdepend_0/WAW]
  connect_bd_net -net Reorder_Buffer_0_Busy [get_bd_ports Busy_0] [get_bd_pins Reorder_Buffer_0/Busy]
  connect_bd_net -net Reorder_Buffer_0_RD1 [get_bd_pins Register_File_1/RD1] [get_bd_pins Reorder_Buffer_0/RD1]
  connect_bd_net -net Reorder_Buffer_0_RD2 [get_bd_pins Register_File_1/RD2] [get_bd_pins Reorder_Buffer_0/RD2]
  connect_bd_net -net Reorder_Buffer_0_ROB1 [get_bd_pins Register_File_1/ROB1] [get_bd_pins Reorder_Buffer_0/ROB1] [get_bd_pins Reservation_Station_0/ROB1]
  connect_bd_net -net Reorder_Buffer_0_ROB2 [get_bd_pins Register_File_1/ROB2] [get_bd_pins Reorder_Buffer_0/ROB2] [get_bd_pins Reservation_Station_0/ROB2]
  connect_bd_net -net Reorder_Buffer_0_head [get_bd_pins Allocate_unit_0/ROB_head] [get_bd_pins Reorder_Buffer_0/head]
  connect_bd_net -net Reorder_Buffer_0_reg_data1 [get_bd_pins Register_File_1/reg_data1] [get_bd_pins Reorder_Buffer_0/reg_data1] [get_bd_pins Reservation_Station_0/reg_data1]
  connect_bd_net -net Reorder_Buffer_0_reg_data2 [get_bd_pins Register_File_1/reg_data2] [get_bd_pins Reorder_Buffer_0/reg_data2] [get_bd_pins Reservation_Station_0/reg_data2]
  connect_bd_net -net Reorder_Buffer_0_tail [get_bd_pins Allocate_unit_0/ROB_tail] [get_bd_pins Reorder_Buffer_0/tail]
  connect_bd_net -net Reorder_Buffer_0_wb1 [get_bd_pins Reorder_Buffer_0/wb1] [get_bd_pins Write_back_signals_0/wb1]
  connect_bd_net -net Reorder_Buffer_0_wb2 [get_bd_pins Reorder_Buffer_0/wb2] [get_bd_pins Write_back_signals_0/wb2]
  connect_bd_net -net Reservation_Station_0_Busy [get_bd_pins Allocate_unit_0/RS_free_bitmap] [get_bd_pins Reservation_Station_0/Busy]
  connect_bd_net -net Reservation_Station_0_FU_bits0 [get_bd_pins Issue_Unit_0/FU0] [get_bd_pins Reservation_Station_0/FU_bits0]
  connect_bd_net -net Reservation_Station_0_FU_bits1 [get_bd_pins Issue_Unit_0/FU1] [get_bd_pins Reservation_Station_0/FU_bits1]
  connect_bd_net -net Reservation_Station_0_FU_bits2 [get_bd_pins Issue_Unit_0/FU2] [get_bd_pins Reservation_Station_0/FU_bits2]
  connect_bd_net -net Reservation_Station_0_FU_bits3 [get_bd_pins Issue_Unit_0/FU3] [get_bd_pins Reservation_Station_0/FU_bits3]
  connect_bd_net -net Reservation_Station_0_FU_bits4 [get_bd_pins Issue_Unit_0/FU4] [get_bd_pins Reservation_Station_0/FU_bits4]
  connect_bd_net -net Reservation_Station_0_FU_bits5 [get_bd_pins Issue_Unit_0/FU5] [get_bd_pins Reservation_Station_0/FU_bits5]
  connect_bd_net -net Reservation_Station_0_FU_bits6 [get_bd_pins Issue_Unit_0/FU6] [get_bd_pins Reservation_Station_0/FU_bits6]
  connect_bd_net -net Reservation_Station_0_FU_bits7 [get_bd_pins Issue_Unit_0/FU7] [get_bd_pins Reservation_Station_0/FU_bits7]
  connect_bd_net -net Reservation_Station_0_Imm2_l [get_bd_ports Imm2_l_0] [get_bd_pins Reservation_Station_0/Imm2_l]
  connect_bd_net -net Reservation_Station_0_PC0 [get_bd_pins Issue_Unit_0/PC0] [get_bd_pins Reservation_Station_0/PC0]
  connect_bd_net -net Reservation_Station_0_PC1 [get_bd_pins Issue_Unit_0/PC1] [get_bd_pins Reservation_Station_0/PC1]
  connect_bd_net -net Reservation_Station_0_PC2 [get_bd_pins Issue_Unit_0/PC2] [get_bd_pins Reservation_Station_0/PC2]
  connect_bd_net -net Reservation_Station_0_PC3 [get_bd_pins Issue_Unit_0/PC3] [get_bd_pins Reservation_Station_0/PC3]
  connect_bd_net -net Reservation_Station_0_PC4 [get_bd_pins Issue_Unit_0/PC4] [get_bd_pins Reservation_Station_0/PC4]
  connect_bd_net -net Reservation_Station_0_PC5 [get_bd_pins Issue_Unit_0/PC5] [get_bd_pins Reservation_Station_0/PC5]
  connect_bd_net -net Reservation_Station_0_PC6 [get_bd_pins Issue_Unit_0/PC6] [get_bd_pins Reservation_Station_0/PC6]
  connect_bd_net -net Reservation_Station_0_PC7 [get_bd_pins Issue_Unit_0/PC7] [get_bd_pins Reservation_Station_0/PC7]
  connect_bd_net -net Reservation_Station_0_PC_a [get_bd_pins ALU_0/PC] [get_bd_pins Reservation_Station_0/PC_a]
  connect_bd_net -net Reservation_Station_0_PC_a2 [get_bd_pins ALU_1/PC] [get_bd_pins Reservation_Station_0/PC_a2]
  connect_bd_net -net Reservation_Station_0_PC_b [get_bd_ports PC_b_0] [get_bd_pins Reservation_Station_0/PC_b]
  connect_bd_net -net Reservation_Station_0_PC_l [get_bd_ports PC_l_0] [get_bd_pins Reservation_Station_0/PC_l]
  connect_bd_net -net Reservation_Station_0_ROB_tag_a [get_bd_pins ALU_0/ROB_tag] [get_bd_pins Reservation_Station_0/ROB_tag_a]
  connect_bd_net -net Reservation_Station_0_ROB_tag_a2 [get_bd_pins ALU_1/ROB_tag] [get_bd_pins Reservation_Station_0/ROB_tag_a2]
  connect_bd_net -net Reservation_Station_0_ROB_tag_b [get_bd_ports ROB_tag_b_0] [get_bd_pins Reservation_Station_0/ROB_tag_b]
  connect_bd_net -net Reservation_Station_0_ROB_tag_l [get_bd_ports ROB_tag_l_0] [get_bd_pins Reservation_Station_0/ROB_tag_l]
  connect_bd_net -net Reservation_Station_0_Ready [get_bd_pins Issue_Unit_0/Ready_bits] [get_bd_pins Reservation_Station_0/Ready]
  connect_bd_net -net Reservation_Station_0_SEI1_a [get_bd_pins ALU_0/SEI1] [get_bd_pins Reservation_Station_0/SEI1_a]
  connect_bd_net -net Reservation_Station_0_SEI1_a2 [get_bd_pins ALU_1/SEI1] [get_bd_pins Reservation_Station_0/SEI1_a2]
  connect_bd_net -net Reservation_Station_0_SEI1_b [get_bd_ports SEI1_b_0] [get_bd_pins Reservation_Station_0/SEI1_b]
  connect_bd_net -net Reservation_Station_0_SEI1_l [get_bd_ports SEI1_l_0] [get_bd_pins Reservation_Station_0/SEI1_l]
  connect_bd_net -net Reservation_Station_0_SEI2_b [get_bd_ports SEI2_b_0] [get_bd_pins Reservation_Station_0/SEI2_b]
  connect_bd_net -net Reservation_Station_0_SEI2_l [get_bd_ports SEI2_l_0] [get_bd_pins Reservation_Station_0/SEI2_l]
  connect_bd_net -net Reservation_Station_0_a_ctrl_a [get_bd_pins ALU_0/a_ctrl] [get_bd_pins Reservation_Station_0/a_ctrl_a]
  connect_bd_net -net Reservation_Station_0_a_ctrl_a2 [get_bd_pins ALU_1/a_ctrl] [get_bd_pins Reservation_Station_0/a_ctrl_a2]
  connect_bd_net -net Reservation_Station_0_b_ctrl_b [get_bd_ports b_ctrl_b_0] [get_bd_pins Reservation_Station_0/b_ctrl_b]
  connect_bd_net -net Reservation_Station_0_b_p_b [get_bd_ports b_p_b_0] [get_bd_pins Reservation_Station_0/b_p_b]
  connect_bd_net -net Reservation_Station_0_c_a [get_bd_pins ALU_0/c] [get_bd_pins Reservation_Station_0/c_a]
  connect_bd_net -net Reservation_Station_0_c_a2 [get_bd_pins ALU_1/c] [get_bd_pins Reservation_Station_0/c_a2]
  connect_bd_net -net Reservation_Station_0_ls_ctrl_l [get_bd_ports ls_ctrl_l_0] [get_bd_pins Reservation_Station_0/ls_ctrl_l]
  connect_bd_net -net Reservation_Station_0_op_b [get_bd_ports op_b_0] [get_bd_pins Reservation_Station_0/op_b]
  connect_bd_net -net Reservation_Station_0_ra_a [get_bd_pins ALU_0/ra] [get_bd_pins Reservation_Station_0/ra_a]
  connect_bd_net -net Reservation_Station_0_ra_a2 [get_bd_pins ALU_1/ra] [get_bd_pins Reservation_Station_0/ra_a2]
  connect_bd_net -net Reservation_Station_0_ra_b [get_bd_ports ra_b_0] [get_bd_pins Reservation_Station_0/ra_b]
  connect_bd_net -net Reservation_Station_0_ra_l [get_bd_ports ra_l_0] [get_bd_pins Reservation_Station_0/ra_l]
  connect_bd_net -net Reservation_Station_0_rb_a [get_bd_pins ALU_0/rb] [get_bd_pins Reservation_Station_0/rb_a]
  connect_bd_net -net Reservation_Station_0_rb_a2 [get_bd_pins ALU_1/rb] [get_bd_pins Reservation_Station_0/rb_a2]
  connect_bd_net -net Reservation_Station_0_rb_b [get_bd_ports rb_b_0] [get_bd_pins Reservation_Station_0/rb_b]
  connect_bd_net -net Reservation_Station_0_rb_l [get_bd_ports rb_l_0] [get_bd_pins Reservation_Station_0/rb_l]
  connect_bd_net -net Reservation_Station_0_rc_a [get_bd_pins ALU_0/rc] [get_bd_pins Reservation_Station_0/rc_a]
  connect_bd_net -net Reservation_Station_0_rc_a2 [get_bd_pins ALU_1/rc] [get_bd_pins Reservation_Station_0/rc_a2]
  connect_bd_net -net Reservation_Station_0_spec_tag_a [get_bd_pins ALU_0/spec_tag] [get_bd_pins Reservation_Station_0/spec_tag_a]
  connect_bd_net -net Reservation_Station_0_spec_tag_a2 [get_bd_pins ALU_1/spec_tag] [get_bd_pins Reservation_Station_0/spec_tag_a2]
  connect_bd_net -net Reservation_Station_0_spec_tag_b [get_bd_ports spec_tag_b_0] [get_bd_pins Reservation_Station_0/spec_tag_b]
  connect_bd_net -net Reservation_Station_0_spec_tag_l [get_bd_ports spec_tag_l_0] [get_bd_pins Reservation_Station_0/spec_tag_l]
  connect_bd_net -net Reservation_Station_0_v_c_a [get_bd_pins ALU_0/v_c] [get_bd_pins Reservation_Station_0/v_c_a]
  connect_bd_net -net Reservation_Station_0_v_c_a2 [get_bd_pins ALU_1/v_c] [get_bd_pins Reservation_Station_0/v_c_a2]
  connect_bd_net -net Reservation_Station_0_v_ra_a [get_bd_pins ALU_0/v_ra] [get_bd_pins Reservation_Station_0/v_ra_a]
  connect_bd_net -net Reservation_Station_0_v_ra_a2 [get_bd_pins ALU_1/v_ra] [get_bd_pins Reservation_Station_0/v_ra_a2]
  connect_bd_net -net Reservation_Station_0_v_ra_b [get_bd_ports v_ra_b_0] [get_bd_pins Reservation_Station_0/v_ra_b]
  connect_bd_net -net Reservation_Station_0_v_ra_l [get_bd_ports v_ra_l_0] [get_bd_pins Reservation_Station_0/v_ra_l]
  connect_bd_net -net Reservation_Station_0_v_rb_a [get_bd_pins ALU_0/v_rb] [get_bd_pins Reservation_Station_0/v_rb_a]
  connect_bd_net -net Reservation_Station_0_v_rb_a2 [get_bd_pins ALU_1/v_rb] [get_bd_pins Reservation_Station_0/v_rb_a2]
  connect_bd_net -net Reservation_Station_0_v_rb_b [get_bd_ports v_rb_b_0] [get_bd_pins Reservation_Station_0/v_rb_b]
  connect_bd_net -net Reservation_Station_0_v_rb_l [get_bd_ports v_rb_l_0] [get_bd_pins Reservation_Station_0/v_rb_l]
  connect_bd_net -net Reservation_Station_0_v_rc_a [get_bd_pins ALU_0/v_rc] [get_bd_pins Reservation_Station_0/v_rc_a]
  connect_bd_net -net Reservation_Station_0_v_rc_a2 [get_bd_pins ALU_1/v_rc] [get_bd_pins Reservation_Station_0/v_rc_a2]
  connect_bd_net -net Reservation_Station_0_v_z_a [get_bd_pins ALU_0/v_z] [get_bd_pins Reservation_Station_0/v_z_a]
  connect_bd_net -net Reservation_Station_0_v_z_a2 [get_bd_pins ALU_1/v_z] [get_bd_pins Reservation_Station_0/v_z_a2]
  connect_bd_net -net Reservation_Station_0_valid_a [get_bd_pins ALU_0/valid] [get_bd_pins Reservation_Station_0/valid_a]
  connect_bd_net -net Reservation_Station_0_valid_a2 [get_bd_pins ALU_1/valid] [get_bd_pins Reservation_Station_0/valid_a2]
  connect_bd_net -net Reservation_Station_0_valid_b [get_bd_ports valid_b_0] [get_bd_pins Reservation_Station_0/valid_b]
  connect_bd_net -net Reservation_Station_0_valid_l [get_bd_ports valid_l_0] [get_bd_pins Reservation_Station_0/valid_l]
  connect_bd_net -net Reservation_Station_0_z_a [get_bd_pins ALU_0/z] [get_bd_pins Reservation_Station_0/z_a]
  connect_bd_net -net Reservation_Station_0_z_a2 [get_bd_pins ALU_1/z] [get_bd_pins Reservation_Station_0/z_a2]
  connect_bd_net -net Valid_instruction_ch_0_valid1 [get_bd_pins Valid_instruction_ch_0/valid1] [get_bd_pins decode_buffer_0/valid1_in]
  connect_bd_net -net Valid_instruction_ch_0_valid2 [get_bd_pins Valid_instruction_ch_0/valid2] [get_bd_pins decode_buffer_0/valid2_in]
  connect_bd_net -net Write_back_signals_0_wC1 [get_bd_ports wC1_0] [get_bd_pins Write_back_signals_0/wC1]
  connect_bd_net -net Write_back_signals_0_wC2 [get_bd_ports wC2_0] [get_bd_pins Write_back_signals_0/wC2]
  connect_bd_net -net Write_back_signals_0_wR1 [get_bd_pins Register_File_1/wb1] [get_bd_pins Reservation_Station_0/wb1] [get_bd_pins Write_back_signals_0/wR1]
  connect_bd_net -net Write_back_signals_0_wR2 [get_bd_pins Register_File_1/wb2] [get_bd_pins Reservation_Station_0/wb2] [get_bd_pins Write_back_signals_0/wR2]
  connect_bd_net -net Write_back_signals_0_wZ1 [get_bd_ports wZ1_0] [get_bd_pins Write_back_signals_0/wZ1]
  connect_bd_net -net Write_back_signals_0_wZ2 [get_bd_ports wZ2_0] [get_bd_pins Write_back_signals_0/wZ2]
  connect_bd_net -net clk_0_1 [get_bd_ports clk_0] [get_bd_pins DispatchBuffer_0/clk] [get_bd_pins PC_0/clk] [get_bd_pins Register_File_1/clk] [get_bd_pins Reorder_Buffer_0/clk] [get_bd_pins Reservation_Station_0/clk] [get_bd_pins decode_0/clk] [get_bd_pins decode_buffer_0/clk]
  connect_bd_net -net decode_0_CZ1 [get_bd_pins DispatchBuffer_0/CZ1_in] [get_bd_pins decode_0/CZ1]
  connect_bd_net -net decode_0_CZ2 [get_bd_pins DispatchBuffer_0/CZ2_in] [get_bd_pins decode_0/CZ2]
  connect_bd_net -net decode_0_IA1_out [get_bd_pins DispatchBuffer_0/IA1_in] [get_bd_pins decode_0/IA1_out]
  connect_bd_net -net decode_0_IA2_out [get_bd_pins DispatchBuffer_0/IA2_in] [get_bd_pins decode_0/IA2_out]
  connect_bd_net -net decode_0_Imm1_1 [get_bd_pins DispatchBuffer_0/Imm1_1_in] [get_bd_pins decode_0/Imm1_1]
  connect_bd_net -net decode_0_Imm1_2 [get_bd_pins DispatchBuffer_0/Imm1_2_in] [get_bd_pins decode_0/Imm1_2]
  connect_bd_net -net decode_0_Imm2_1 [get_bd_pins DispatchBuffer_0/Imm2_1_in] [get_bd_pins decode_0/Imm2_1]
  connect_bd_net -net decode_0_Imm2_2 [get_bd_pins DispatchBuffer_0/Imm2_2_in] [get_bd_pins decode_0/Imm2_2]
  connect_bd_net -net decode_0_RA1 [get_bd_pins DispatchBuffer_0/RA1_in] [get_bd_pins decode_0/RA1]
  connect_bd_net -net decode_0_RA2 [get_bd_pins DispatchBuffer_0/RA2_in] [get_bd_pins decode_0/RA2]
  connect_bd_net -net decode_0_RB1 [get_bd_pins DispatchBuffer_0/RB1_in] [get_bd_pins decode_0/RB1]
  connect_bd_net -net decode_0_RB2 [get_bd_pins DispatchBuffer_0/RB2_in] [get_bd_pins decode_0/RB2]
  connect_bd_net -net decode_0_RC1 [get_bd_pins DispatchBuffer_0/RC1_in] [get_bd_pins decode_0/RC1]
  connect_bd_net -net decode_0_RC2 [get_bd_pins DispatchBuffer_0/RC2_in] [get_bd_pins decode_0/RC2]
  connect_bd_net -net decode_0_SEI1_1 [get_bd_pins DispatchBuffer_0/SEI1_1_in] [get_bd_pins decode_0/SEI1_1]
  connect_bd_net -net decode_0_SEI1_2 [get_bd_pins DispatchBuffer_0/SEI1_2_in] [get_bd_pins decode_0/SEI1_2]
  connect_bd_net -net decode_0_SEI2_1 [get_bd_pins DispatchBuffer_0/SEI2_1_in] [get_bd_pins decode_0/SEI2_1]
  connect_bd_net -net decode_0_SEI2_2 [get_bd_pins DispatchBuffer_0/SEI2_2_in] [get_bd_pins decode_0/SEI2_2]
  connect_bd_net -net decode_0_branch_predict1_out [get_bd_pins DispatchBuffer_0/branch_predict1_in] [get_bd_pins decode_0/branch_predict1_out]
  connect_bd_net -net decode_0_branch_predict2_out [get_bd_pins DispatchBuffer_0/branch_predict2_in] [get_bd_pins decode_0/branch_predict2_out]
  connect_bd_net -net decode_0_comp1 [get_bd_pins DispatchBuffer_0/comp1_in] [get_bd_pins decode_0/comp1]
  connect_bd_net -net decode_0_comp2 [get_bd_pins DispatchBuffer_0/comp2_in] [get_bd_pins decode_0/comp2]
  connect_bd_net -net decode_0_op1 [get_bd_pins DispatchBuffer_0/op1_in] [get_bd_pins decode_0/op1]
  connect_bd_net -net decode_0_op2 [get_bd_pins DispatchBuffer_0/op2_in] [get_bd_pins decode_0/op2]
  connect_bd_net -net decode_0_spec_tag1 [get_bd_pins DispatchBuffer_0/spec_tag1_in] [get_bd_pins decode_0/spec_tag1]
  connect_bd_net -net decode_0_spec_tag2 [get_bd_pins DispatchBuffer_0/spec_tag2_in] [get_bd_pins decode_0/spec_tag2]
  connect_bd_net -net decode_0_valid1_out [get_bd_pins DispatchBuffer_0/valid_in1] [get_bd_pins decode_0/valid1_out]
  connect_bd_net -net decode_0_valid2_out [get_bd_pins DispatchBuffer_0/valid_in2] [get_bd_pins decode_0/valid2_out]
  connect_bd_net -net decode_buffer_0_address_out1 [get_bd_pins decode_0/IA1] [get_bd_pins decode_buffer_0/address_out1]
  connect_bd_net -net decode_buffer_0_address_out2 [get_bd_pins decode_0/IA2] [get_bd_pins decode_buffer_0/address_out2]
  connect_bd_net -net decode_buffer_0_branch_predict1_out [get_bd_pins decode_0/branch_predict1] [get_bd_pins decode_buffer_0/branch_predict1_out]
  connect_bd_net -net decode_buffer_0_branch_predict2_out [get_bd_pins decode_0/branch_predict2] [get_bd_pins decode_buffer_0/branch_predict2_out]
  connect_bd_net -net decode_buffer_0_instr1_out [get_bd_pins decode_0/instr1] [get_bd_pins decode_buffer_0/instr1_out]
  connect_bd_net -net decode_buffer_0_instr2_out [get_bd_pins decode_0/instr2] [get_bd_pins decode_buffer_0/instr2_out]
  connect_bd_net -net decode_buffer_0_valid1_out [get_bd_pins decode_0/valid1] [get_bd_pins decode_buffer_0/valid1_out]
  connect_bd_net -net decode_buffer_0_valid2_out [get_bd_pins decode_0/valid2] [get_bd_pins decode_buffer_0/valid2_out]
  connect_bd_net -net rst_0_1 [get_bd_ports rst_0] [get_bd_pins DispatchBuffer_0/rst] [get_bd_pins Instruction_Memory_0/rst] [get_bd_pins PC_0/rst] [get_bd_pins Register_File_1/rst] [get_bd_pins Reorder_Buffer_0/rst] [get_bd_pins Reservation_Station_0/rst] [get_bd_pins Valid_instruction_ch_0/rst] [get_bd_pins decode_0/rst] [get_bd_pins decode_buffer_0/rst]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins Allocate_unit_0/RR_stall] [get_bd_pins DispatchBuffer_0/stall] [get_bd_pins PC_0/branch_predict1] [get_bd_pins PC_0/branch_predict2] [get_bd_pins PC_0/branch_predict_PC1] [get_bd_pins PC_0/branch_predict_PC2] [get_bd_pins PC_0/branch_resolve] [get_bd_pins PC_0/branch_resolve_PC] [get_bd_pins RegWrite_Ctrl_0/stall] [get_bd_pins Register_File_1/ROB_b_cdb] [get_bd_pins Register_File_1/ROB_ls_cdb] [get_bd_pins Register_File_1/dm_data] [get_bd_pins Register_File_1/reg_data_b] [get_bd_pins Register_File_1/valid_b_cdb] [get_bd_pins Register_File_1/valid_ls_cdb] [get_bd_pins Reorder_Buffer_0/misprediction] [get_bd_pins Reorder_Buffer_0/valid_b_cdb] [get_bd_pins Reorder_Buffer_0/valid_ls_cdb] [get_bd_pins Reservation_Station_0/ROB_b_cdb] [get_bd_pins Reservation_Station_0/ROB_ls_cdb] [get_bd_pins Reservation_Station_0/dm_data] [get_bd_pins Reservation_Station_0/reg_data_b] [get_bd_pins Reservation_Station_0/valid_b_cdb] [get_bd_pins Reservation_Station_0/valid_ls_cdb] [get_bd_pins Valid_instruction_ch_0/branch_predict1] [get_bd_pins decode_buffer_0/branch_predict1_in] [get_bd_pins decode_buffer_0/branch_predict2_in] [get_bd_pins decode_buffer_0/stall] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins Allocate_unit_0/CWrite1] [get_bd_pins Allocate_unit_0/CWrite2] [get_bd_pins Allocate_unit_0/ZWrite1] [get_bd_pins Allocate_unit_0/ZWrite2] [get_bd_pins Allocate_unit_0/c1] [get_bd_pins Allocate_unit_0/c2] [get_bd_pins Allocate_unit_0/v_c1] [get_bd_pins Allocate_unit_0/v_c2] [get_bd_pins Allocate_unit_0/v_z1] [get_bd_pins Allocate_unit_0/v_z2] [get_bd_pins Allocate_unit_0/z1] [get_bd_pins Allocate_unit_0/z2] [get_bd_pins DispatchBuffer_0/issue1] [get_bd_pins DispatchBuffer_0/issue2] [get_bd_pins PC_0/PC_Write] [get_bd_pins Reorder_Buffer_0/PC_b_cdb] [get_bd_pins Reorder_Buffer_0/PC_ls_cdb] [get_bd_pins Reorder_Buffer_0/ROB_b_cdb] [get_bd_pins Reorder_Buffer_0/ROB_ls_cdb] [get_bd_pins Reorder_Buffer_0/dm_data] [get_bd_pins Reorder_Buffer_0/reg_data_b] [get_bd_pins Reorder_Buffer_0/spec_tag_b] [get_bd_pins xlconstant_1/dout]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""



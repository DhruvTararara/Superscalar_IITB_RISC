# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "BUFFER_SIZE" -parent ${Page_0}
  ipgui::add_param $IPINST -name "IMM1_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "IMM2_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "OP_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "REG_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "SEI1_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "SEI2_WIDTH" -parent ${Page_0}


}

proc update_PARAM_VALUE.BUFFER_SIZE { PARAM_VALUE.BUFFER_SIZE } {
	# Procedure called to update BUFFER_SIZE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BUFFER_SIZE { PARAM_VALUE.BUFFER_SIZE } {
	# Procedure called to validate BUFFER_SIZE
	return true
}

proc update_PARAM_VALUE.IMM1_WIDTH { PARAM_VALUE.IMM1_WIDTH } {
	# Procedure called to update IMM1_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IMM1_WIDTH { PARAM_VALUE.IMM1_WIDTH } {
	# Procedure called to validate IMM1_WIDTH
	return true
}

proc update_PARAM_VALUE.IMM2_WIDTH { PARAM_VALUE.IMM2_WIDTH } {
	# Procedure called to update IMM2_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.IMM2_WIDTH { PARAM_VALUE.IMM2_WIDTH } {
	# Procedure called to validate IMM2_WIDTH
	return true
}

proc update_PARAM_VALUE.OP_WIDTH { PARAM_VALUE.OP_WIDTH } {
	# Procedure called to update OP_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OP_WIDTH { PARAM_VALUE.OP_WIDTH } {
	# Procedure called to validate OP_WIDTH
	return true
}

proc update_PARAM_VALUE.REG_ADDR_WIDTH { PARAM_VALUE.REG_ADDR_WIDTH } {
	# Procedure called to update REG_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.REG_ADDR_WIDTH { PARAM_VALUE.REG_ADDR_WIDTH } {
	# Procedure called to validate REG_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.SEI1_WIDTH { PARAM_VALUE.SEI1_WIDTH } {
	# Procedure called to update SEI1_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SEI1_WIDTH { PARAM_VALUE.SEI1_WIDTH } {
	# Procedure called to validate SEI1_WIDTH
	return true
}

proc update_PARAM_VALUE.SEI2_WIDTH { PARAM_VALUE.SEI2_WIDTH } {
	# Procedure called to update SEI2_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.SEI2_WIDTH { PARAM_VALUE.SEI2_WIDTH } {
	# Procedure called to validate SEI2_WIDTH
	return true
}


proc update_MODELPARAM_VALUE.BUFFER_SIZE { MODELPARAM_VALUE.BUFFER_SIZE PARAM_VALUE.BUFFER_SIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BUFFER_SIZE}] ${MODELPARAM_VALUE.BUFFER_SIZE}
}

proc update_MODELPARAM_VALUE.OP_WIDTH { MODELPARAM_VALUE.OP_WIDTH PARAM_VALUE.OP_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OP_WIDTH}] ${MODELPARAM_VALUE.OP_WIDTH}
}

proc update_MODELPARAM_VALUE.REG_ADDR_WIDTH { MODELPARAM_VALUE.REG_ADDR_WIDTH PARAM_VALUE.REG_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.REG_ADDR_WIDTH}] ${MODELPARAM_VALUE.REG_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.IMM1_WIDTH { MODELPARAM_VALUE.IMM1_WIDTH PARAM_VALUE.IMM1_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IMM1_WIDTH}] ${MODELPARAM_VALUE.IMM1_WIDTH}
}

proc update_MODELPARAM_VALUE.IMM2_WIDTH { MODELPARAM_VALUE.IMM2_WIDTH PARAM_VALUE.IMM2_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.IMM2_WIDTH}] ${MODELPARAM_VALUE.IMM2_WIDTH}
}

proc update_MODELPARAM_VALUE.SEI1_WIDTH { MODELPARAM_VALUE.SEI1_WIDTH PARAM_VALUE.SEI1_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SEI1_WIDTH}] ${MODELPARAM_VALUE.SEI1_WIDTH}
}

proc update_MODELPARAM_VALUE.SEI2_WIDTH { MODELPARAM_VALUE.SEI2_WIDTH PARAM_VALUE.SEI2_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.SEI2_WIDTH}] ${MODELPARAM_VALUE.SEI2_WIDTH}
}


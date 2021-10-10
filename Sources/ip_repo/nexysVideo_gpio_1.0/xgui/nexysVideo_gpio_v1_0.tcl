# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0" -display_name {Configurations}]
  set_property tooltip {Configuration Parameters} ${Page_0}
  ipgui::add_param $IPINST -name "BTN_COUNTER_SIZE" -parent ${Page_0}

  #Adding Page
  set Register_Map [ipgui::add_page $IPINST -name "Register Map"]
  set_property tooltip {Offsets of Registers} ${Register_Map}
  set OFFSET_CONFIG [ipgui::add_param $IPINST -name "OFFSET_CONFIG" -parent ${Register_Map} -widget comboBox]
  set_property tooltip {Dynamic Configurations} ${OFFSET_CONFIG}
  set OFFSET_LED [ipgui::add_param $IPINST -name "OFFSET_LED" -parent ${Register_Map} -widget comboBox]
  set_property tooltip {LEDS} ${OFFSET_LED}
  ipgui::add_param $IPINST -name "OFFSET_SW" -parent ${Register_Map} -widget comboBox
  set OFFSET_BTNC [ipgui::add_param $IPINST -name "OFFSET_BTNC" -parent ${Register_Map} -widget comboBox]
  set_property tooltip {Central button counter} ${OFFSET_BTNC}
  set OFFSET_BTND [ipgui::add_param $IPINST -name "OFFSET_BTND" -parent ${Register_Map} -widget comboBox]
  set_property tooltip {Down button counter} ${OFFSET_BTND}
  set OFFSET_BTNL [ipgui::add_param $IPINST -name "OFFSET_BTNL" -parent ${Register_Map} -widget comboBox]
  set_property tooltip {Left button counter} ${OFFSET_BTNL}
  set OFFSET_BTNU [ipgui::add_param $IPINST -name "OFFSET_BTNU" -parent ${Register_Map} -widget comboBox]
  set_property tooltip {Up button counter} ${OFFSET_BTNU}
  set OFFSET_BTNR [ipgui::add_param $IPINST -name "OFFSET_BTNR" -parent ${Register_Map} -widget comboBox]
  set_property tooltip {Right button counter} ${OFFSET_BTNR}


}

proc update_PARAM_VALUE.BTN_COUNTER_SIZE { PARAM_VALUE.BTN_COUNTER_SIZE } {
	# Procedure called to update BTN_COUNTER_SIZE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BTN_COUNTER_SIZE { PARAM_VALUE.BTN_COUNTER_SIZE } {
	# Procedure called to validate BTN_COUNTER_SIZE
	return true
}

proc update_PARAM_VALUE.OFFSET_BTNC { PARAM_VALUE.OFFSET_BTNC } {
	# Procedure called to update OFFSET_BTNC when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OFFSET_BTNC { PARAM_VALUE.OFFSET_BTNC } {
	# Procedure called to validate OFFSET_BTNC
	return true
}

proc update_PARAM_VALUE.OFFSET_BTND { PARAM_VALUE.OFFSET_BTND } {
	# Procedure called to update OFFSET_BTND when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OFFSET_BTND { PARAM_VALUE.OFFSET_BTND } {
	# Procedure called to validate OFFSET_BTND
	return true
}

proc update_PARAM_VALUE.OFFSET_BTNL { PARAM_VALUE.OFFSET_BTNL } {
	# Procedure called to update OFFSET_BTNL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OFFSET_BTNL { PARAM_VALUE.OFFSET_BTNL } {
	# Procedure called to validate OFFSET_BTNL
	return true
}

proc update_PARAM_VALUE.OFFSET_BTNR { PARAM_VALUE.OFFSET_BTNR } {
	# Procedure called to update OFFSET_BTNR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OFFSET_BTNR { PARAM_VALUE.OFFSET_BTNR } {
	# Procedure called to validate OFFSET_BTNR
	return true
}

proc update_PARAM_VALUE.OFFSET_BTNU { PARAM_VALUE.OFFSET_BTNU } {
	# Procedure called to update OFFSET_BTNU when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OFFSET_BTNU { PARAM_VALUE.OFFSET_BTNU } {
	# Procedure called to validate OFFSET_BTNU
	return true
}

proc update_PARAM_VALUE.OFFSET_CONFIG { PARAM_VALUE.OFFSET_CONFIG } {
	# Procedure called to update OFFSET_CONFIG when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OFFSET_CONFIG { PARAM_VALUE.OFFSET_CONFIG } {
	# Procedure called to validate OFFSET_CONFIG
	return true
}

proc update_PARAM_VALUE.OFFSET_LED { PARAM_VALUE.OFFSET_LED } {
	# Procedure called to update OFFSET_LED when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OFFSET_LED { PARAM_VALUE.OFFSET_LED } {
	# Procedure called to validate OFFSET_LED
	return true
}

proc update_PARAM_VALUE.OFFSET_SW { PARAM_VALUE.OFFSET_SW } {
	# Procedure called to update OFFSET_SW when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OFFSET_SW { PARAM_VALUE.OFFSET_SW } {
	# Procedure called to validate OFFSET_SW
	return true
}

proc update_PARAM_VALUE.C_S_AXI_DATA_WIDTH { PARAM_VALUE.C_S_AXI_DATA_WIDTH } {
	# Procedure called to update C_S_AXI_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_DATA_WIDTH { PARAM_VALUE.C_S_AXI_DATA_WIDTH } {
	# Procedure called to validate C_S_AXI_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_AXI_ADDR_WIDTH { PARAM_VALUE.C_S_AXI_ADDR_WIDTH } {
	# Procedure called to update C_S_AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_ADDR_WIDTH { PARAM_VALUE.C_S_AXI_ADDR_WIDTH } {
	# Procedure called to validate C_S_AXI_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_AXI_BASEADDR { PARAM_VALUE.C_S_AXI_BASEADDR } {
	# Procedure called to update C_S_AXI_BASEADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_BASEADDR { PARAM_VALUE.C_S_AXI_BASEADDR } {
	# Procedure called to validate C_S_AXI_BASEADDR
	return true
}

proc update_PARAM_VALUE.C_S_AXI_HIGHADDR { PARAM_VALUE.C_S_AXI_HIGHADDR } {
	# Procedure called to update C_S_AXI_HIGHADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_HIGHADDR { PARAM_VALUE.C_S_AXI_HIGHADDR } {
	# Procedure called to validate C_S_AXI_HIGHADDR
	return true
}


proc update_MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH PARAM_VALUE.C_S_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH PARAM_VALUE.C_S_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.BTN_COUNTER_SIZE { MODELPARAM_VALUE.BTN_COUNTER_SIZE PARAM_VALUE.BTN_COUNTER_SIZE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.BTN_COUNTER_SIZE}] ${MODELPARAM_VALUE.BTN_COUNTER_SIZE}
}

proc update_MODELPARAM_VALUE.OFFSET_CONFIG { MODELPARAM_VALUE.OFFSET_CONFIG PARAM_VALUE.OFFSET_CONFIG } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OFFSET_CONFIG}] ${MODELPARAM_VALUE.OFFSET_CONFIG}
}

proc update_MODELPARAM_VALUE.OFFSET_LED { MODELPARAM_VALUE.OFFSET_LED PARAM_VALUE.OFFSET_LED } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OFFSET_LED}] ${MODELPARAM_VALUE.OFFSET_LED}
}

proc update_MODELPARAM_VALUE.OFFSET_SW { MODELPARAM_VALUE.OFFSET_SW PARAM_VALUE.OFFSET_SW } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OFFSET_SW}] ${MODELPARAM_VALUE.OFFSET_SW}
}

proc update_MODELPARAM_VALUE.OFFSET_BTNC { MODELPARAM_VALUE.OFFSET_BTNC PARAM_VALUE.OFFSET_BTNC } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OFFSET_BTNC}] ${MODELPARAM_VALUE.OFFSET_BTNC}
}

proc update_MODELPARAM_VALUE.OFFSET_BTND { MODELPARAM_VALUE.OFFSET_BTND PARAM_VALUE.OFFSET_BTND } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OFFSET_BTND}] ${MODELPARAM_VALUE.OFFSET_BTND}
}

proc update_MODELPARAM_VALUE.OFFSET_BTNL { MODELPARAM_VALUE.OFFSET_BTNL PARAM_VALUE.OFFSET_BTNL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OFFSET_BTNL}] ${MODELPARAM_VALUE.OFFSET_BTNL}
}

proc update_MODELPARAM_VALUE.OFFSET_BTNU { MODELPARAM_VALUE.OFFSET_BTNU PARAM_VALUE.OFFSET_BTNU } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OFFSET_BTNU}] ${MODELPARAM_VALUE.OFFSET_BTNU}
}

proc update_MODELPARAM_VALUE.OFFSET_BTNR { MODELPARAM_VALUE.OFFSET_BTNR PARAM_VALUE.OFFSET_BTNR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OFFSET_BTNR}] ${MODELPARAM_VALUE.OFFSET_BTNR}
}

proc update_MODELPARAM_VALUE.C_S_AXI_BASEADDR { MODELPARAM_VALUE.C_S_AXI_BASEADDR PARAM_VALUE.C_S_AXI_BASEADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_BASEADDR}] ${MODELPARAM_VALUE.C_S_AXI_BASEADDR}
}

proc update_MODELPARAM_VALUE.C_S_AXI_HIGHADDR { MODELPARAM_VALUE.C_S_AXI_HIGHADDR PARAM_VALUE.C_S_AXI_HIGHADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_HIGHADDR}] ${MODELPARAM_VALUE.C_S_AXI_HIGHADDR}
}


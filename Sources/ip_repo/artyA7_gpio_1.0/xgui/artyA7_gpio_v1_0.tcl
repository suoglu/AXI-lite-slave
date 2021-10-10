# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0" -display_name {Configuration}]
  set_property tooltip {Configuration} ${Page_0}
  set BTN_COUNTER_SIZE [ipgui::add_param $IPINST -name "BTN_COUNTER_SIZE" -parent ${Page_0}]
  set_property tooltip {Size of the button counters} ${BTN_COUNTER_SIZE}

  #Adding Page
  set Register_Map [ipgui::add_page $IPINST -name "Register Map"]
  set_property tooltip {Contains registers with their offsets} ${Register_Map}
  ipgui::add_static_text $IPINST -name "Important!" -parent ${Register_Map} -text {Offsets should be diffrent for all registers!}
  set OFFSET_CONFIG [ipgui::add_param $IPINST -name "OFFSET_CONFIG" -parent ${Register_Map} -widget comboBox]
  set_property tooltip {Configurations for IP} ${OFFSET_CONFIG}
  set OFFSET_LED_PWM [ipgui::add_param $IPINST -name "OFFSET_LED_PWM" -parent ${Register_Map} -widget comboBox]
  set_property tooltip {Phase Width Modulated LEDs} ${OFFSET_LED_PWM}
  set OFFSET_LED [ipgui::add_param $IPINST -name "OFFSET_LED" -parent ${Register_Map} -widget comboBox]
  set_property tooltip {LEDs with only toggle function} ${OFFSET_LED}
  ipgui::add_param $IPINST -name "OFFSET_SW" -parent ${Register_Map} -widget comboBox
  ipgui::add_param $IPINST -name "OFFSET_RGB0" -parent ${Register_Map} -widget comboBox
  ipgui::add_param $IPINST -name "OFFSET_RGB1" -parent ${Register_Map} -widget comboBox
  ipgui::add_param $IPINST -name "OFFSET_RGB2" -parent ${Register_Map} -widget comboBox
  ipgui::add_param $IPINST -name "OFFSET_RGB3" -parent ${Register_Map} -widget comboBox
  ipgui::add_param $IPINST -name "OFFSET_BTN0" -parent ${Register_Map} -widget comboBox
  ipgui::add_param $IPINST -name "OFFSET_BTN1" -parent ${Register_Map} -widget comboBox
  ipgui::add_param $IPINST -name "OFFSET_BTN2" -parent ${Register_Map} -widget comboBox
  ipgui::add_param $IPINST -name "OFFSET_BTN3" -parent ${Register_Map} -widget comboBox
  set OFFSET_BTN_ALL [ipgui::add_param $IPINST -name "OFFSET_BTN_ALL" -parent ${Register_Map} -widget comboBox]
  set_property tooltip {Least Significant bits of all button counters combined} ${OFFSET_BTN_ALL}


}

proc update_PARAM_VALUE.BTN_COUNTER_SIZE { PARAM_VALUE.BTN_COUNTER_SIZE } {
	# Procedure called to update BTN_COUNTER_SIZE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.BTN_COUNTER_SIZE { PARAM_VALUE.BTN_COUNTER_SIZE } {
	# Procedure called to validate BTN_COUNTER_SIZE
	return true
}

proc update_PARAM_VALUE.OFFSET_BTN0 { PARAM_VALUE.OFFSET_BTN0 } {
	# Procedure called to update OFFSET_BTN0 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OFFSET_BTN0 { PARAM_VALUE.OFFSET_BTN0 } {
	# Procedure called to validate OFFSET_BTN0
	return true
}

proc update_PARAM_VALUE.OFFSET_BTN1 { PARAM_VALUE.OFFSET_BTN1 } {
	# Procedure called to update OFFSET_BTN1 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OFFSET_BTN1 { PARAM_VALUE.OFFSET_BTN1 } {
	# Procedure called to validate OFFSET_BTN1
	return true
}

proc update_PARAM_VALUE.OFFSET_BTN2 { PARAM_VALUE.OFFSET_BTN2 } {
	# Procedure called to update OFFSET_BTN2 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OFFSET_BTN2 { PARAM_VALUE.OFFSET_BTN2 } {
	# Procedure called to validate OFFSET_BTN2
	return true
}

proc update_PARAM_VALUE.OFFSET_BTN3 { PARAM_VALUE.OFFSET_BTN3 } {
	# Procedure called to update OFFSET_BTN3 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OFFSET_BTN3 { PARAM_VALUE.OFFSET_BTN3 } {
	# Procedure called to validate OFFSET_BTN3
	return true
}

proc update_PARAM_VALUE.OFFSET_BTN_ALL { PARAM_VALUE.OFFSET_BTN_ALL } {
	# Procedure called to update OFFSET_BTN_ALL when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OFFSET_BTN_ALL { PARAM_VALUE.OFFSET_BTN_ALL } {
	# Procedure called to validate OFFSET_BTN_ALL
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

proc update_PARAM_VALUE.OFFSET_LED_PWM { PARAM_VALUE.OFFSET_LED_PWM } {
	# Procedure called to update OFFSET_LED_PWM when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OFFSET_LED_PWM { PARAM_VALUE.OFFSET_LED_PWM } {
	# Procedure called to validate OFFSET_LED_PWM
	return true
}

proc update_PARAM_VALUE.OFFSET_RGB0 { PARAM_VALUE.OFFSET_RGB0 } {
	# Procedure called to update OFFSET_RGB0 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OFFSET_RGB0 { PARAM_VALUE.OFFSET_RGB0 } {
	# Procedure called to validate OFFSET_RGB0
	return true
}

proc update_PARAM_VALUE.OFFSET_RGB1 { PARAM_VALUE.OFFSET_RGB1 } {
	# Procedure called to update OFFSET_RGB1 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OFFSET_RGB1 { PARAM_VALUE.OFFSET_RGB1 } {
	# Procedure called to validate OFFSET_RGB1
	return true
}

proc update_PARAM_VALUE.OFFSET_RGB2 { PARAM_VALUE.OFFSET_RGB2 } {
	# Procedure called to update OFFSET_RGB2 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OFFSET_RGB2 { PARAM_VALUE.OFFSET_RGB2 } {
	# Procedure called to validate OFFSET_RGB2
	return true
}

proc update_PARAM_VALUE.OFFSET_RGB3 { PARAM_VALUE.OFFSET_RGB3 } {
	# Procedure called to update OFFSET_RGB3 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.OFFSET_RGB3 { PARAM_VALUE.OFFSET_RGB3 } {
	# Procedure called to validate OFFSET_RGB3
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

proc update_MODELPARAM_VALUE.OFFSET_LED_PWM { MODELPARAM_VALUE.OFFSET_LED_PWM PARAM_VALUE.OFFSET_LED_PWM } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OFFSET_LED_PWM}] ${MODELPARAM_VALUE.OFFSET_LED_PWM}
}

proc update_MODELPARAM_VALUE.OFFSET_LED { MODELPARAM_VALUE.OFFSET_LED PARAM_VALUE.OFFSET_LED } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OFFSET_LED}] ${MODELPARAM_VALUE.OFFSET_LED}
}

proc update_MODELPARAM_VALUE.OFFSET_SW { MODELPARAM_VALUE.OFFSET_SW PARAM_VALUE.OFFSET_SW } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OFFSET_SW}] ${MODELPARAM_VALUE.OFFSET_SW}
}

proc update_MODELPARAM_VALUE.OFFSET_RGB0 { MODELPARAM_VALUE.OFFSET_RGB0 PARAM_VALUE.OFFSET_RGB0 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OFFSET_RGB0}] ${MODELPARAM_VALUE.OFFSET_RGB0}
}

proc update_MODELPARAM_VALUE.OFFSET_RGB1 { MODELPARAM_VALUE.OFFSET_RGB1 PARAM_VALUE.OFFSET_RGB1 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OFFSET_RGB1}] ${MODELPARAM_VALUE.OFFSET_RGB1}
}

proc update_MODELPARAM_VALUE.OFFSET_RGB2 { MODELPARAM_VALUE.OFFSET_RGB2 PARAM_VALUE.OFFSET_RGB2 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OFFSET_RGB2}] ${MODELPARAM_VALUE.OFFSET_RGB2}
}

proc update_MODELPARAM_VALUE.OFFSET_RGB3 { MODELPARAM_VALUE.OFFSET_RGB3 PARAM_VALUE.OFFSET_RGB3 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OFFSET_RGB3}] ${MODELPARAM_VALUE.OFFSET_RGB3}
}

proc update_MODELPARAM_VALUE.OFFSET_BTN0 { MODELPARAM_VALUE.OFFSET_BTN0 PARAM_VALUE.OFFSET_BTN0 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OFFSET_BTN0}] ${MODELPARAM_VALUE.OFFSET_BTN0}
}

proc update_MODELPARAM_VALUE.OFFSET_BTN1 { MODELPARAM_VALUE.OFFSET_BTN1 PARAM_VALUE.OFFSET_BTN1 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OFFSET_BTN1}] ${MODELPARAM_VALUE.OFFSET_BTN1}
}

proc update_MODELPARAM_VALUE.OFFSET_BTN2 { MODELPARAM_VALUE.OFFSET_BTN2 PARAM_VALUE.OFFSET_BTN2 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OFFSET_BTN2}] ${MODELPARAM_VALUE.OFFSET_BTN2}
}

proc update_MODELPARAM_VALUE.OFFSET_BTN3 { MODELPARAM_VALUE.OFFSET_BTN3 PARAM_VALUE.OFFSET_BTN3 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OFFSET_BTN3}] ${MODELPARAM_VALUE.OFFSET_BTN3}
}

proc update_MODELPARAM_VALUE.OFFSET_BTN_ALL { MODELPARAM_VALUE.OFFSET_BTN_ALL PARAM_VALUE.OFFSET_BTN_ALL } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.OFFSET_BTN_ALL}] ${MODELPARAM_VALUE.OFFSET_BTN_ALL}
}

proc update_MODELPARAM_VALUE.C_S_AXI_BASEADDR { MODELPARAM_VALUE.C_S_AXI_BASEADDR PARAM_VALUE.C_S_AXI_BASEADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_BASEADDR}] ${MODELPARAM_VALUE.C_S_AXI_BASEADDR}
}

proc update_MODELPARAM_VALUE.C_S_AXI_HIGHADDR { MODELPARAM_VALUE.C_S_AXI_HIGHADDR PARAM_VALUE.C_S_AXI_HIGHADDR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_HIGHADDR}] ${MODELPARAM_VALUE.C_S_AXI_HIGHADDR}
}


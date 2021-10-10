

proc generate {drv_handle} {
	xdefine_include_file $drv_handle "xparameters.h" "nexysVideo_gpio" "NUM_INSTANCES" "DEVICE_ID"  "C_S_AXI_BASEADDR" "C_S_AXI_HIGHADDR" "OFFSET_CONFIG" "OFFSET_LED" "OFFSET_SW" "OFFSET_BTNC" "OFFSET_BTND" "OFFSET_BTNL" "OFFSET_BTNU" "OFFSET_BTNR"
}

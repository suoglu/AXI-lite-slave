# AXI-Lite Slaves

## Contents of Readme

1. About
2. GPIO IPs
   - Basys 3 GPIO
       1. Description
       2. Register Map
       3. Utilization
       4. Status Information
   - Arty A7 GPIO
       1. Description
       2. Register Map
       3. Utilization
       4. Status Information
   - Nexys Video GPIO
       1. Description
       2. Register Map
       3. Utilization
       4. Status Information
3. Custom AXI4-Lite
   1. Description
   2. Utilization
   3. Status Information
4. Licence

[![Repo on GitLab](https://img.shields.io/badge/repo-GitLab-6C488A.svg)](https://gitlab.com/suoglu/axi-lite-slave)
[![Repo on GitHub](https://img.shields.io/badge/repo-GitHub-3D76C2.svg)](https://github.com/suoglu/AXI-lite-slave)

---

## About

This repository contains simple AXI-Lite slaves for GPIOs of some FPGA boards as well as a generic AXI-Lite slave.

## Basys 3 GPIO

### Basys 3 Description

Gives access to the basic GPIO ports (seven segment display, buttons, switches and LEDs) of the [Digilent Basys 3](https://digilent.com/reference/programmable-logic/basys-3/start) FPGA board. Register mapping can be changed via GUI or parameters. Included driver will work regardless of the mapping.

### Basys 3 Register Map

| Name | Default Offset | Access | Description |
|:---:|:---:|:---:|---|
|Config|*0x00*|R/W|Configurations for IP|
|led|*0x04*|R/W|LEDs|
|sw|*0x08*|R|Switches|
|ssd|*0x0C*|R/W|Seven Segment Display|
|btn all|*0x10*|R|Combined Button Counter|
|btnL|*0x14*|R|Left Button Counter|
|btnU|*0x18*|R|Up Button Counter|
|btnR|*0x1C*|R|Right Button Counter|
|btnD|*0x20*|R|Down Button Counter|

**Configuration Register:**
| 31:6 | 5:2 | 1 | 0 |
|:---:|:---:|:---:|:---:|
|Reserved |Enable digits|Overwrite SSD config.|Keep Button Values|

- Reserved: Don't Care
- Enable digits: Enable seven segment digits
- Overwrite SSD config: Use seven segment digits configurations from configurations register instead of seven segment digit register.
- Keep Button Values: Do not reset button counters after read.

**Combined Button Counter:**
| 31:24 | 23:16 | 15:8 | 7:0 |
|:---:|:---:|:---:|:---:|
|Left Button|Up Button|Right Button|Down Button|

### Basys 3 (Synthesized)  Utilization

- Slice LUTs: 145 (as Logic)
- Slice Registers: 168 (as Flip Flop)
- F7 Muxes: 1

### Basys 3 Status Information

**Last Simulation:** 18 October 2021, with [Vivado Simulator](https://www.xilinx.com/products/design-tools/vivado/simulator.html).

**Last Test:** 09 October 2021, on [Digilent Basys 3](https://reference.digilentinc.com/reference/programmable-logic/basys-3/reference-manual).

## Arty A7 GPIO

### Arty A7 Description

Gives access to the basic GPIO ports (buttons, switches and LEDs) of the [Digilent Arty A7](https://reference.digilentinc.com/reference/programmable-logic/arty-a7/reference-manual) FPGA board. Register mapping can be changed via GUI or parameters. Included driver will work regardless of the mapping.

### Arty A7 Register Map

| Name | Default Offset | Access | Description |
|:---:|:---:|:---:|---|
|Config|*0x00*|R/W|Configurations for IP|
|PWM led|*0x04*|R/W|Phase Width Modulated LED control|
|Toggle led|*0x08*|R/W|Toggle LED control|
|sw|*0x0C*|R|Switches|
|rgb0|*0x10*|R/W|RGB LED 0|
|rgb1|*0x14*|R/W|RGB LED 1|
|rgb2|*0x18*|R/W|RGB LED 2|
|rgb3|*0x1C*|R/W|RGB LED 3|
|btn0|*0x20*|R|Button 0 Counter|
|btn1|*0x24*|R|Button 1 Counter|
|btn2|*0x28*|R|Button 2 Counter|
|btn3|*0x2C*|R|Button 3 Counter|
|btn all|*0x30*|R|Combined Button Counter|

**Configuration Register:**
| 31:10 | 9:2 | 1 | 0 |
|:---:|:---:|:---:|:---:|
|Reserved |Toggle Brightness|Enable Toggle Mode|Keep Button Values|

- Reserved: Don't Care
- Toggle Brightness: Brightness for Toggle LEDs
- Enable Toggle Mode: Normal LEDs are controlled by toggle register
- Keep Button Values: Do not reset button counters after read.

In combined registers, GPIO with higher number has higher address.

### Arty A7 (Synthesized) Utilization

- Slice LUTs: 1000 (as Logic)
- Slice Registers: 714 as Flip Flop and 128 as Latch
- F7 Muxes: 4

### Arty A7 Status Information

**Last Simulation:** 18 October 2021, with [Vivado Simulator](https://www.xilinx.com/products/design-tools/vivado/simulator.html).

**Last Test:** 10 October 2021, on [Digilent Arty A7](https://reference.digilentinc.com/reference/programmable-logic/arty-a7/reference-manual).

## Nexys Video GPIO

### Nexys Video Description

Gives access to the basic GPIO ports (buttons, switches and LEDs) of the [Digilent Nexys Video](https://digilent.com/reference/programmable-logic/nexys-video/start) FPGA board. Register mapping can be changed via GUI or parameters. Included driver will work regardless of the mapping.

### Nexys Video Register Map

| Name | Default Offset | Access | Description |
|:---:|:---:|:---:|---|
|Config|*0x00*|R/W|Configurations for IP|
|led|*0x04*|R/W|LEDs|
|sw|*0x08*|R|Switches|
|btnC|*0x0C*|R|Center Button Counter|
|btnD|*0x10*|R|Down Button Counter|
|btnL|*0x14*|R|Left Button Counter|
|btnU|*0x18*|R|Up Button Counter|
|btnR|*0x1C*|R|Right Button Counter|

**Configuration Register:**
| 31:1 | 0 |
|:---:|:---:|
|Reserved|Keep Button Values|

- Reserved: Don't Care
- Keep Button Values: Do not reset button counters after read.

### Nexys Video (Synthesized) Utilization

- Slice LUTs: 104 (as Logic)
- Slice Registers: 215 (as Flip Flop)

### Nexys Video Status Information

**Last Simulation:** 10 October 2021, with [Vivado Simulator](https://www.xilinx.com/products/design-tools/vivado/simulator.html).

**Last Test:** 10 October 2021, on [Digilent Nexys Video](https://reference.digilentinc.com/reference/programmable-logic/nexys-video/reference-manual).

## Custom AXI4-Lite Slave

### Description

This IP provides a simpler interface for AXI4-Lite protocol. IP handles all signalling for AXI lite interface with a simpler interface with only two channels. Both, read and write, channels use the same signals and naming convention (except a passthrough `write_strobe` signal).

- `write` and `read` signals indicate a new request and kept high until `*_done` signal is set.
- `*_done` signals indicates that the operation will be completed at the next positive edge, same as AXI protocol.
- `*_data` signals contains the operation data.
- `*_addrs` signals contains the address for the operation.
- `*_error` signals indicate and error in the operation.
- Parameter `GP_ADDR_WIDTH` is used to determine the width of `*_addrs` signals.

Write and read channels work independently. Interface passes signals at the same cycle as they are issued, and holds them until the handshake.

### (Synthesized) Utilization on Artix 7

- Slice LUTs: 49 (as Logic)
- Slice Registers: 83 (as Flip Flop)

### Status Information

**Last Simulation:** 10 October 2021, with [Vivado Simulator](https://www.xilinx.com/products/design-tools/vivado/simulator.html).

## Licence

CERN Open Hardware Licence Version 2 - Weakly Reciprocal

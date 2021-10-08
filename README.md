# AXI-Lite Slaves

## Contents of Readme

1. About
2. IPs
   - Basys 3 GPIO
       1. Description
       2. Register Map
       3. Utilization
       4. Status Information

[![Repo on GitLab](https://img.shields.io/badge/repo-GitLab-6C488A.svg)](https://gitlab.com/suoglu/axi-lite-slave)
[![Repo on GitHub](https://img.shields.io/badge/repo-GitHub-3D76C2.svg)](https://github.com/suoglu/AXI-lite-slave)

---

## About

!!! WORK IN PROGRESS !!!

This repository contains simple AXI-Lite slaves for GPIOs of some FPGA boards as well as a generic AXI-Lite slave.

## Basys 3 GPIO

### Description

Gives access to the basic GPIO ports (seven segment display, buttons, switches and LEDs) of the [Digilent Basys 3](https://digilent.com/reference/programmable-logic/basys-3/start) FPGA board. Register mapping can be changed via GUI or parameters. Included driver will work regardless of the mapping.

### Register Map

| Name | Default Offset | Access | Description |
|:---:|:---:|:---:|---|
|Config|*0x0*|R/W|Configurations for IP|
|led|*0x4*|R/W|LEDs|
|sw|*0x8*|R|Switches|
|ssd|*0xC*|R/W|Seven Segment Display|
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

### (Synthesized)  Utilization

- Slice LUTs: 146 (as Logic)
- Slice Registers: 168 (as Flip Flop)
- F7 Muxes: 1

### Status Information

**Last Simulation:** 06 October, with [Vivado Simulator](https://www.xilinx.com/products/design-tools/vivado/simulator.html).

**Last Test:** 09 October 2021, on [Digilent Basys 3](https://reference.digilentinc.com/reference/programmable-logic/basys-3/reference-manual).

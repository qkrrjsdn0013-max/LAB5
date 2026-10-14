# LAB5 — STM32_1 and FPGA additional practice

This repository contains the LAB5 source projects and pre-lab evidence.

- `stm32_lab/`: STM32 project. The current `Core/Src/ece2_474_routine.c` is the STM32_1 PWM button task. Separate source snapshots and build screenshots for all three examples and both tasks are under `stm32_lab/evidence/STM32_1/`.
- `lab5_01_piano/`: FPGA piano RTL, testbench, constraints, and simulation evidence.
- `lab5_02_traffic/`: FPGA traffic light controller RTL, testbench, constraints, and simulation evidence.
- `lab5_03_adc/`: FPGA ADC serial interface RTL, testbench, constraints, and simulation evidence.

The STM32 examples and tasks have CMake Debug Build screenshots. The FPGA testbenches have PASS logs and saved waveforms. Physical board behavior has not yet been checked. Generated `build/` and `vivado/` files are omitted; each project keeps its source and evidence.

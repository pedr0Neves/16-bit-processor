# 16-Bit Processor - VHDL Implementation  

## Overview  
A fully functional **16-bit processor** implemented in VHDL, developed as part of the *Digital Systems for Computers* course at Universidade Federal do Ceará. The processor supports a custom instruction set and was synthesized/tested in **Xilinx Vivado**, demonstrating proficiency with industry-standard FPGA tools.

## Key Features  
- **16-bit architecture** with 8 registers.
- **Custom instruction set** (arithmetic, logic, stack, I/O, and control flow).
- **Vivado-optimized** design with synchronous control signals.
- **Testbenches** for functional verification. 

## Instruction Set
Full opcode tables available in [trabalho_T2.pdf](trabalho_T2.pdf) and [instructions_1.pdf](instructions_1.pdf).

---

## Development Environment  
- **Design & Simulation**: Xilinx Vivado (VHDL).
- **Target**: FPGA synthesis-ready (tested on Artix-7).

## Repository Structure
/ 
├── sim/                   # Testbenches (VHDL)
│   ├── ...
│   └── ... 
├── source/                # Core VHDL modules
│   ├── ...
│   └── ... 
├── docs/                  # Specifications
│   ├── trabalho_T2.pdf    # Project requirements
│   └── instructions_1.pdf # Full instruction set 
└─  README.md              # This file 

## Author

Pedro Emanuel Ferreira Paiva das Neves

- **Skills**: VHDL, FPGA design (Vivado), digital systems
- **Contact**: pedroneves05@alu.ufc.br 

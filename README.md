# TinyCPU RTL

A SystemVerilog implementation of my custom 8-bit TinyCPU architecture.

## Architecture

- 8-bit CPU
- 4 general-purpose registers (R0-R3)
- 256 bytes of memory
- 8-bit program counter
- 8-bit instructions

## Instruction Set

| Opcode | Instruction |
|--------|-------------|
| 000 | HALT |
| 001 | ADD |
| 010 | SUB |
| 011 | AND |
| 100 | OR |
| 101 | LOAD |
| 110 | STORE |
| 111 | JUMP |

## Project Status

Currently in development.

## Tools

- SystemVerilog
- Icarus Verilog
- GTKWave
- Ubuntu / WSL
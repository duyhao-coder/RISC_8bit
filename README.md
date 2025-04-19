# 🔧 VeriRISC - A Simple 8-bit RISC CPU (Verilog)

VeriRISC is a simple, modular 8-bit RISC CPU designed in Verilog. The project demonstrates fundamental computer architecture principles such as instruction fetch-decode-execute, memory management, ALU operations, and control logic design. The architecture is easily extendable to support advanced features like floating-point arithmetic and hazard control.

---

## 🚀 Features

- ✅ **Instruction Set**: 3-bit Opcode + 5-bit Operand (total 8-bit instruction)
- ✅ **Basic Instructions**: `LDA`, `ADD`, `AND`, `XOR`, `SKZ`, `STO`, `JMP`, `HLT`
- ✅ **Modular Design**: Clean separation of components: ALU, Control Unit, Registers, MUX, Program Counter, Memory
- ✅ **Float8 Extension (Optional)**: Support for simple 8-bit floating point arithmetic when `float_mode=1`
- ✅ **One-hot Phase Control**: CPU cycles through 8 phases using a dedicated phase counter
- ✅ **Tri-state Bus**: Shared data bus with bus enable signal
- ✅ **Fully Testable**: Includes multiple Verilog testbenches with memory preload and verification

---

## 📂 Project Structure

```bash
.
├── alu.v                  # ALU logic (integer + optional float8)
├── controller.v           # Control FSM generating internal control signals
├── counter.v              # Generic counter used for PC and phase
├── memory.v               # Unified or separate Instruction/Data RAM
├── register.v             # Generic Register (AC, IR)
├── multiplexor.v          # MUX to select between PC or operand address
├── tri_state_buffer.v     # Tri-state driver for shared bus
├── RISC_CPU.v             # Top-level module integrating all components
├── testbench.v            # Main testbench with preloaded programs
├── README.md              # This file
📜 Instruction Set Architecture (ISA)

Mnemonic	Opcode	Description
HLT	000	Halt execution
SKZ	001	Skip next instruction if AC==0
ADD	010	AC ← AC + M[addr]
AND	011	AC ← AC & M[addr]
XOR	100	AC ← AC ^ M[addr]
LDA	101	AC ← M[addr]
STO	110	M[addr] ← AC
JMP	111	PC ← addr
🧪 Sample Program
This sample loads values from memory, performs arithmetic, stores the result, and loops:

verilog
Sao chép
Chỉnh sửa
mem[0] = 8'b101_01010;  // LDA 10      ; AC = 3
mem[1] = 8'b010_01011;  // ADD 11      ; AC = 3 + 4 = 7
mem[2] = 8'b100_01100;  // XOR 12      ; AC = 7 ^ 1 = 6
mem[3] = 8'b011_01101;  // AND 13      ; AC = 6 & 255 = 6
mem[4] = 8'b110_01110;  // STO 14      ; Store result
mem[5] = 8'b111_00000;  // JMP 0       ; Loop
🧠 Design Notes
Phase Counter: CPU cycles through 8 predefined phases (Fetch → Decode → Execute)

Control Logic: Based on current opcode and phase, generates control signals

Memory: Supports both instruction and data memory; optionally can split into separate modules

Floating-Point: Optional 8-bit float format (1 sign bit, 3 exponent bits, 4 mantissa bits)

Expandability: Easily extend opcode width, data width, or instruction set

📦 Test Cases Included
✔️ Arithmetic loop

✔️ Conditional skip with SKZ

✔️ Store and load tests

✔️ Infinite loop with jump

✔️ Optional Float8 tests

🛠️ Tools
Vivado Simulator or any Verilog simulation environment

Written in SystemVerilog/Verilog 2001

Simulation waveforms viewable via Vivado, ModelSim, or online tools like EDA Playground

🧩 Potential Extensions
🧠 Add pipeline or hazard detection

📈 Add Multiply/Divide units

🌐 UART or VGA output integration

💾 Load instruction/data from external files

🧮 Enhanced ALU with signed ops, shifts, or Float8 mode selector

📬 Author
Duy – Designed as part of coursework in [Computer Architecture / Digital Design].
Open to suggestions and improvements via GitHub Issues or Pull Requests!

📘 License
This project is open source under the MIT License.

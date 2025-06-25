# ⚙️ RTL ALU + PWM FPGA Project

This project implements a structured digital system in Verilog RTL, targeting the Intel DE10-Standard FPGA board. The system includes a modular ALU (arithmetic, logic, shifter) and a PWM generator with three operating modes. It supports simulation, synthesis, and real hardware verification using industry-standard tools.

---

## 🧭 System Overview

- ✅ Modular ISA-driven ALU
- ✅ PWM Generator with 3 modes
- ✅ Unified control signal interface via `ALUFN[4:0]`
- ✅ Real hardware test on DE10-Standard FPGA
- ✅ RTL simulation in ModelSim
- ✅ SignalTap-based internal debugging

---

## 🔀 Functional Unit Control (`ALUFN[4:3]`)

The system selects between functional blocks using the high two bits of a 5-bit `ALUFN` control signal:

| ALUFN[4:3] | Selected Unit     | Function Description                     |
|------------|------------------|------------------------------------------|
| `00`       | PWM Generator     | Generates variable duty-cycle PWM signal |
| `01`       | Arithmetic Unit   | Add, subtract, increment, negate         |
| `10`       | Shifter Unit      | Logical/rotate left/right shift          |
| `11`       | Logical Unit      | AND, OR, XOR, NOT, NAND                  |

> 🛠 Only one unit is active at a time. All units share a unified input/output interface through hardware multiplexing.

---

## 🧩 Module Descriptions

### 🔷 ALU Subsystem

Split into three functional RTL modules:

- `alu_arithmetic.v` – signed/unsigned math operations
- `alu_logic.v` – basic boolean logic
- `alu_shifter.v` – logical and rotational shift operations

Output is determined based on `ALUFN[4:0]` and visible via LEDs and HEX displays.

---

### 🔶 PWM Generator

Implements 3 operating modes:

| Mode | Behavior Description                  |
|------|----------------------------------------|
| Mode 0 | Fixed duty cycle (manual)           |
| Mode 1 | Sweep (ramp up/down duty cycle)     |
| Mode 2 | Enable-controlled toggling          |

> Mode is selected using lower bits of `ALUFN`.

All PWM outputs are observable on LED pins and via SignalTap.

---

## 🛠 Tools & Hardware Used

| Tool               | Purpose                                           |
|--------------------|---------------------------------------------------|
| **ModelSim**       | RTL-level simulation and waveform viewing         |
| **Quartus Prime**  | Synthesis, place-and-route, timing analysis       |
| **SignalTap II**   | Internal FPGA logic probing (live debugging)      |
| **DE10-Standard**  | Target hardware for real FPGA deployment          |

📌 *Timing reports were generated automatically by Quartus. No manual slack/path optimizations were applied in this phase.*

---

## 🧪 Simulation & Test Instructions

### 🖥 Simulation (ModelSim)

1. Open ModelSim
2. Compile testbenches and RTL modules:
   ```bash
   vsim work.alu_tb
   vsim work.pwm_tb

# ⚙️ Karatsuba Multiplier in VHDL

## 📘 Overview

This project implements a **Karatsuba multiplier** in VHDL, optimized for high-bitwidth multiplication. It uses a traditional **shift-and-add** method for 32-bit multiplication and leverages the **Karatsuba algorithm** for 64-bit, 128-bit, and 256-bit multiplication. The project also includes a testbench for verifying the correctness of the 256-bit multiplier.

The code was written in the **Fall of 2022** as part of a project focused on optimizing multiplication operations in hardware using advanced algorithms.

## ✨ Features
- 📏 32-bit multiplication using **shift-and-add**.
- 🧠 64-bit, 128-bit, and 256-bit multiplication using **Karatsuba’s algorithm**.
- 🔬 Includes a testbench to validate the **256-bit multiplier**.

## 🔍 What is the Karatsuba Algorithm?

The **Karatsuba algorithm** is an efficient multiplication algorithm that reduces the complexity of multiplying large numbers. Unlike the traditional O(n²) approach, Karatsuba breaks down a large multiplication problem into smaller subproblems by splitting the operands, recursively solving them, and combining the results. This reduces the overall time complexity to approximately O(n^1.585), making it ideal for large bit-width multiplications in hardware.

## 🛠️ How It Works
- **Shift-and-Add (32-bit)**: Traditional bitwise addition is used for 32-bit operations.
- **Karatsuba Algorithm**: For 64-bit and larger numbers, the Karatsuba algorithm splits the multiplication problem into smaller parts, solving them recursively to reduce complexity and improve performance.

## 🔬 Testbench
- The testbench is designed to verify the functionality of the **256-bit multiplier** by checking the output against expected results for predefined input values.
- **Simulation environment**: Compatible with common HDL simulators like ModelSim or Vivado.

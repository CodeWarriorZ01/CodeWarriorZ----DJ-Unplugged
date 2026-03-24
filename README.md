# DJ Unplugged
## Method 2: Verilog / VHDL Implementation

## 👥 Team Name

CodeWarriorZ

## 🧑‍💻 Team Members
Prashant Sharma

Karan Mondal

Deepak Mehta

Suyash Shirsat

Vatsal Raval

Rishabh Dave


## 🌿 Problem Statement

In a wildlife conservation system, remote camera traps continuously capture fixed-size grayscale image blocks, where each pixel is represented by an 8-bit unsigned value.

Due to repeated triggers and environmental variations, a large number of captured images are visually similar or redundant. This leads to increased storage requirements and transmission overhead.

To address this challenge, the objective is to design a hardware-efficient solution using Verilog/VHDL.

## ⚙️ System Requirements

The proposed hardware module must:

🔹 Generate a 64-bit image signature based on the intensity characteristics of the input image.

🔹 Ensure that visually similar images produce similar signatures.

🔹 Compare two image signatures to identify similarity.

🔹 Output a duplicate detection signal when similarity exceeds a configurable threshold.

🔹 Be fully synthesizable and suitable for real-time embedded deployment.



## 🎯 Objective

Develop an efficient and scalable hardware-based image deduplication system that minimizes redundant data storage while maintaining high performance in real-time wildlife monitoring environments.

##DJ Unplugges

In a Wildlife conservation system, remote camera traps continuously capture fixed size grayscale image blocks (each pixel is represented by an 8-bit unsigned value). Due to repeated triggers and environmental variations, a significant lot of captured images are visually similar. Thus to reduce storage and transmission costs, design a Verilog hardware module that:
1. Generates a 64-bit image signature from the input image based on its intensity characteristics.
2. Ensures that visually similar images produce similar signatures.
3. Compares two signatures and determines whether the images should be treated as duplicates.
4. Outputs a duplicate signal when similarity exceeds a configurable threshold.
5. The design must be synthesizable and suitable for real-time embedded deployment.

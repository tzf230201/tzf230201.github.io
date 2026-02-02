---
title: Rear Cockpit Monitor (RCM) for Hawk 100 Aircraft
description: Reengineering avionics system for Hawk 100 aircraft with FPGA-based video processing and military-standard electronic design.
cover_image: /assets/images/projects/hudmon_1.jpg
tags: [FPGA, DSP, Avionics, DDR-SDRAM, Image Processing, Electronic Design]
featured: true
demo_url: 
repo_url: 
date: 2023-09-15
---

## Project Overview

The Rear Cockpit Monitor (RCM) on the Hawk 100 aircraft plays a crucial role as a co-pilot aid, enhancing situational awareness during flights. Serving as a Head-Up Display Monitor (HUDMON), the RCM displays video data from the aircraft's camera (CAM) and Head-Up Display (HUD) symbology.

![Hawk 100 RCM](/assets/images/projects/hudmon_1.jpg)

## System Design

The RCM enables the co-pilot in the rear cockpit to easily monitor critical flight information, including real-time video data and HUD symbology. Its integration into the Hawk 100 cockpit design reflects a commitment to operational efficiency and pilot coordination.

![System Architecture](/assets/images/projects/hudmon_2.png)

## Technical Implementation

My objective was to design a new reliable PCB circuit by considering several safety parameters and military standard requirements, and program the FPGA in VHDL language for digital video processing.

### Key Components

- **FPGA**: High-performance FPGA for real-time video processing
- **DDR-SDRAM**: High-speed memory for frame buffering
- **Video Processing**: Digital signal processing pipeline
- **Display Interface**: High-resolution cockpit display
- **Safety Systems**: Redundant systems meeting military standards

![PCB Design](/assets/images/projects/hudmon_3.jpg)

## Technical Achievements

### FPGA Programming

Programmed FPGA using VHDL for digital video processing, resulting in:
- **66% reduction in processing time**
- Real-time video frame processing
- HUD symbology overlay
- Multiple video input handling

### Electronic Design

- Designed schematics and PCB layout incorporating:
  - High-speed communication (DDR SDRAM)
  - Military-standard components
  - EMI/EMC compliance
  - Redundant power systems
  - Safety interlocks

## Testing & Validation

Built a comprehensive tester device for Hawk-100's Rear Cockpit Monitor (RCM) to ensure:
- Signal integrity testing
- Video quality verification
- Timing analysis
- Environmental testing
- Military standards compliance

## Technologies Used

- **FPGA**: Xilinx platform with VHDL programming
- **DSP**: Digital Signal Processing for video
- **Memory**: DDR-SDRAM high-speed interface
- **Tools**: KiCAD, Vivado, oscilloscope, logic analyzer
- **Standards**: Military avionics standards (MIL-STD)

## Results

Successfully delivered a modernized RCM system that:
- Meets all military specifications
- Provides enhanced situational awareness
- Reduces processing latency significantly
- Improves reliability and maintainability
- Supports future upgrades

## Skills Demonstrated

- FPGA design and programming (VHDL)
- High-speed PCB design (DDR-SDRAM interfaces)
- Digital video processing
- Military-standard electronics
- Avionics system integration
- Testing and validation procedures

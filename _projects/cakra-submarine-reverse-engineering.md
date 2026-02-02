---
title: Reverse Engineering CAKRA-401 Submarine Console
description: Modernizing the Command and Weapon-Control Console (CWCC) of CAKRA-401 Submarine through reverse engineering and FPGA implementation.
cover_image: /assets/images/projects/cakra_1.jpg
tags: [FPGA, Reverse Engineering, Analog Signal, Signal Processing, Vector Monitor]
featured: true
demo_url: 
repo_url: 
date: 2023-11-01
---

## Project Overview

KRI Cakra, a submarine of the 209/1300 type, was manufactured by Howaldtswerke in Kiel, Germany, in 1981. This type of submarine is widely utilized by navies around the world. The difficulty in sourcing spare parts for repairs poses a significant challenge. Therefore, it becomes essential to consider modernizing the submarine system.

![CAKRA Submarine](/assets/images/projects/cakra_1.jpg)

## Reverse Engineering Process

Reverse engineering an old device with fully analog signals requires deep understanding of its inner workings. Documentation plays a crucial role in the reverse engineering process, especially for an old device with fully analog signals. Any documentation or technical specifications related to the device can provide valuable insights.

We utilized tools like oscilloscopes to analyze signal characteristics, identifying electronic components, and tracing circuit paths on the PCB. Through this process, we recreated the schematic, unraveled the function of each component, and replicated the circuit for testing purposes.

![Circuit Analysis](/assets/images/projects/cakra_2.jpg)

## Technical Challenges

The main challenge of this project was that this submarine was built in the 1980s in Germany, using analog video signals that do not follow analog video standards of that time like PAL or NTSC. 

I needed to use a flexible Video ADC chip for signal processing and find the best settings for the signals by analyzing the signal characteristics.

![Signal Processing](/assets/images/projects/cakra_3.jpg)

## Technologies Used

- **FPGA Development**: Xilinx platform for digital signal processing
- **Signal Processing**: Custom Video ADC configuration
- **Display Technology**: CRT to LCD migration
- **Electronics Design**: PCB design for modern components
- **Tools**: Oscilloscope, logic analyzer, circuit tracing

## Results

The result looks the same as the old console but with newer technology:
- FPGA-based signal processing
- LCD display replacing CRT
- Lighter weight and smaller footprint
- Simplified design with improved reliability
- Easier maintenance and spare parts availability

## Impact

This modernization project successfully:
- Extended the operational life of the submarine
- Reduced maintenance costs
- Improved system reliability
- Made spare parts locally available
- Demonstrated capability in defense electronics

## Skills Demonstrated

- Analog signal analysis and processing
- FPGA programming and implementation
- Circuit reverse engineering
- PCB design and layout
- Video signal processing
- Military-grade electronics standards

---
title: Vehicle Control Unit (VCU) for Electric Bus
description: Embedded firmware development for PT. INKA's Merah Putih Electric Bus VCU using Texas Instruments Hercules microcontroller and CAN bus communication.
cover_image: /assets/images/projects/vcu_1.jpg
tags: [Embedded System, CAN-Bus, Electric Vehicle, Automotive, Firmware]
featured: true
demo_url: 
repo_url: 
date: 2022-07-01
---

## Project Background

To achieve a Domestic Component Level (TKDN) of more than 40%, **PT. INKA** is prioritizing the use of domestic components for the **Merah Putih Electric Bus** project. Given the multitude of components required and the tight deadline for the G20 Summit in 2022, PT. INKA collaborated with **PT. NSAD** for manufacturing the Vehicle Control Unit (VCU).

![Electric Bus](/assets/images/projects/vcu_1.jpg)

## Project Overview

I worked on the **Vehicle Control Unit (VCU)** firmware that utilizes the main microcontroller from **Texas Instruments Hercules series**. The VCU serves as the brain of the electric bus, managing all vehicle subsystems and ensuring safe operation.

![VCU Hardware](/assets/images/projects/vcu_2.jpg)

## Technical Implementation

### Software Development

- **Configuration**: I/O setup using **HalCoGen** application
- **Programming**: State machine and interlock logic in **C language**
- **IDE**: Code Composer Studio (CCS)
- **Communication**: CAN bus protocol for inter-component communication
- **Testing**: Signal quality verification and troubleshooting

### System Architecture

The VCU communicates with multiple components via **CAN bus**:
- Motor controllers
- Battery Management System (BMS)
- Dashboard and displays
- Charging system
- Safety systems
- Sensors and actuators

![System Architecture](/assets/images/projects/vcu_3.png)

## VCU Test Jig Development

During the firmware development phase, directly testing on the electric bus would be highly risky. Therefore, I developed a **VCU Test Jig** to simulate all components connected to the VCU.

### Test Jig Features

- Simulates all input devices (gas pedal, brake, key switch, etc.)
- Emulates CAN bus communication from other components
- Provides real-time monitoring and debugging
- Enables safe algorithm testing
- Supports automated testing procedures

![Test Jig](/assets/images/projects/vcu_4.png)

## Development Workflow

### 1. Requirements Analysis
- Studied electric vehicle architecture
- Defined safety requirements
- Established communication protocols

### 2. Firmware Development
- Designed state machine logic
- Implemented safety interlocks
- Developed CAN communication handlers
- Created error handling routines

### 3. Testing & Validation
- Unit testing with test jig
- Integration testing with actual components
- Road testing and validation
- Performance optimization

### 4. Documentation
- Comprehensive firmware documentation
- User manuals and technical specifications
- Maintenance procedures
- Daily progress reports

## Technologies Used

- **Microcontroller**: Texas Instruments Hercules series
- **IDE**: Code Composer Studio (CCS)
- **Configuration Tool**: HalCoGen
- **Programming**: Embedded C
- **Protocol**: CAN bus (Controller Area Network)
- **Testing Tools**: Vector CANalyzer, oscilloscope
- **Design**: KiCAD for test jig schematics
- **Version Control**: Git

## Achievements

### Highest Score in Program
Attained the **highest score** in the Certified Internship and Independent Study Program Batch II

### Complete Development Cycle
Successfully devised and developed the VCU firmware from **concept to road testing**

### Quality Documentation
Created comprehensive documentation covering:
- System architecture
- Firmware design
- Communication protocols
- Testing procedures
- Troubleshooting guides

### Project Management
- Consistently delivered daily activity reports
- Maintained project progress tracking
- Met all deadlines including G20 Summit deployment

## Results & Impact

The VCU successfully:
- Controls all electric bus subsystems
- Ensures safe vehicle operation
- Manages power distribution efficiently
- Handles emergency situations properly
- Supports diagnostics and maintenance

The Merah Putih Electric Bus was successfully deployed and operated during the **G20 Summit 2022**, showcasing Indonesian capability in electric vehicle technology.

## Skills Demonstrated

- Embedded systems programming
- CAN bus protocol implementation
- Automotive safety systems
- State machine design
- Hardware-software integration
- Real-time systems
- Testing and validation
- Technical documentation
- Project management
- Problem-solving under tight deadlines

## Future Improvements

- [ ] Add over-the-air (OTA) update capability
- [ ] Implement advanced diagnostics
- [ ] Integrate with fleet management systems
- [ ] Add predictive maintenance features
- [ ] Optimize power management algorithms

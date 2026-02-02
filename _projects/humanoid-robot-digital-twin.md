---
title: Humanoid Robot Digital Twin - Center of Mass Projection
description: Real-time Center of Mass (CoM) projection for 20 DoF humanoid robot using ROS, URDF, and RViz with 68% error reduction.
cover_image: /assets/images/projects/dynamic_walking_1.png
tags: [ROS, Humanoid, URDF, Robotics, Digital Twin, Kinematics]
featured: true
demo_url: 
repo_url: 
date: 2022-12-01
---

## Project Overview

A humanoid robot model is needed to record all Center of Mass (CoM) locations of each link connected to the robot body so that a single point position can be calculated that represents the entire body of the humanoid robot.

![Humanoid Robot Model](/assets/images/projects/dynamic_walking_1.png)

## Technical Implementation

I used **URDF (Universal Robot Description Format)** and presented the robot in **RViz (Robot Visualization)** under the **ROS (Robot Operating System)** framework.

### Balance Calculation

The Humanoid Robot can be said to be in a balanced position if the position of the **Ground Projection Center of Mass (GCoM)** is in the support polygon area. The support polygon is calculated using the **convex hull** with the **Jarvis March method**.

### Mathematical Approach

This project involved extensive use of linear algebra. The exciting part for me was applying mathematical concepts through programming and finding the most effective computational methods. I used a **recursive style** proposed by Mr. Shuuji Kajita in his book "Introduction to Humanoid Robot".

## Robot Specifications

The humanoid robot designed in this project has:
- **Height**: ±590 mm
- **Weight**: ±4.9 kg
- **Degrees of Freedom**: 20 DoF
- **Actuation**: Dynamixel servo motors

## Key Features

### Real-time CoM Calculation
- Recursive algorithm for efficient computation
- Real-time visualization in RViz
- Dynamic balance monitoring

### Support Polygon Detection
- Convex hull computation using Jarvis March
- Stability margin calculation
- Visual feedback of support area

### Digital Twin Synchronization
- Real-time joint state monitoring
- Accurate physics simulation
- Sensor data integration

## Technologies Used

- **Framework**: ROS (Robot Operating System)
- **Visualization**: RViz
- **Robot Description**: URDF/Xacro
- **Programming**: C++, Python
- **Mathematics**: Linear algebra, kinematics
- **Hardware**: Dynamixel servos, IMU sensors

## Results

### Performance Improvements

Successfully achieved:
- **68% reduction in CoM error** from ZMP reference
- Real-time balance calculation and visualization
- Accurate support polygon computation
- Stable walking gait generation

### System Capabilities

The system can:
- Calculate CoM position in real-time
- Determine balance stability
- Generate support polygon dynamically
- Provide visual feedback for debugging
- Support multiple gait patterns

## Demo Video

<video width="100%" controls>
    <source src="/video/pa_clip_1.mp4" type="video/mp4">
    Your browser does not support the video tag.
</video>

## Applications

This digital twin system is valuable for:
- Gait planning and optimization
- Balance control development
- Walking pattern verification
- Safety testing before hardware deployment
- Research and education in humanoid robotics

## Research Impact

This work contributed to:
- Improved walking stability algorithms
- Better understanding of humanoid balance
- Foundation for advanced gait controllers
- Digital twin methodology for robotics

## Future Enhancements

- [ ] Implement Zero Moment Point (ZMP) preview control
- [ ] Add terrain adaptation capabilities
- [ ] Integrate machine learning for gait optimization
- [ ] Develop push recovery strategies
- [ ] Extend to whole-body motion planning

## Skills Demonstrated

- Robot kinematics and dynamics
- URDF/Xacro robot modeling
- ROS framework proficiency
- Linear algebra implementation
- Real-time systems programming
- 3D visualization
- Control theory application
- Research methodology

---
title: Model Predictive Control (MPC) on Ackermann Drive Robot
description: Implementing MPC for autonomous vehicle simulation on ROS Gazebo with Lidar-based navigation in dynamic environments.
cover_image: /assets/images/projects/ackermann_mpc_1.png
tags: [ROS, Autonomous Vehicle, MPC, Gazebo, URDF, Path Planning]
featured: true
demo_url: 
repo_url: 
date: 2024-01-15
---

## Overview

I've implemented Model Predictive Control (MPC) on a simulated Ackermann drive robot described in URDF (Universal Robot Description Format). This allows the robot to predict future states and adjust its path accordingly. Utilizing the Robot Operating System (ROS), the robot navigates through dynamic environments using Gazebo for 3D simulation and RViz for visualization.

## Key Features

The robot relies on a Lidar sensor to understand its surroundings, spotting obstacles and other simulation vehicles. It also uses odometry through dead reckoning to know its exact location amidst the chaos.

![Ackermann MPC Simulation](/assets/images/projects/ackermann_mpc_1.png)

Through this project, I aim to show that autonomous navigation in dynamic environments is achievable. With keen perception, smart planning, and accurate modeling, I'm paving the way for a future where autonomous vehicles can navigate the world around them effortlessly.

## Technical Implementation

### Technologies Used

- **Robot Framework**: ROS (Robot Operating System)
- **Simulation**: Gazebo, RViz
- **Robot Description**: URDF (Universal Robot Description Format)
- **Control Algorithm**: Model Predictive Control (MPC)
- **Sensors**: Lidar, Odometry
- **Path Planning**: Dynamic obstacle avoidance

### Control System

The MPC controller predicts future states of the vehicle and optimizes the control inputs to follow the desired trajectory while avoiding obstacles. The system processes Lidar data in real-time to detect dynamic obstacles and adjusts the path accordingly.

## Results

The implementation successfully demonstrates autonomous navigation capabilities with:
- Real-time obstacle detection and avoidance
- Smooth trajectory tracking using MPC
- Accurate localization through sensor fusion
- Robust performance in dynamic environments

## Demo Video

<video width="100%" controls>
    <source src="/video/mpc_ackermann_clip_1.mp4" type="video/mp4">
    Your browser does not support the video tag.
</video>

## Future Improvements

- [ ] Implement multi-vehicle coordination
- [ ] Add machine learning for adaptive behavior
- [ ] Optimize computational efficiency
- [ ] Test in more complex environments

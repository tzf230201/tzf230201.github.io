---
title: Sound Recognition for Motor Fault Detection
description: CNN-based sound recognition system on microcontroller for detecting broken motors using TensorFlow Lite with 88.3% accuracy.
cover_image: /assets/images/projects/sound_recognition_4.jpg
tags: [CNN, TensorFlow-Lite, Embedded System, Deep Learning, STM32]
featured: false
demo_url: 
repo_url: 
date: 2023-06-15
---

## Project Overview

Neural network training requires high computing hardware. In this project, I implemented a sound recognition system on a microcontroller to detect broken motors through audio analysis. The system uses TensorFlow Lite for edge deployment, enabling real-time fault detection without cloud connectivity.

![System Architecture](/assets/images/projects/sound_recognition_1.jpg)

## Technical Implementation

### Model Development

The neural network is trained on a generic TensorFlow model. The model is then converted using **TensorFlow Lite** so that it can be applied to the microcontroller for edge inference.

### Audio Processing Pipeline

The model doesn't take in raw audio sample data. Instead, it works with **spectrograms** - two-dimensional arrays made up of slices of frequency information, each taken from a different time window.

![Spectrogram Processing](/assets/images/projects/sound_recognition_2.png)

The recipe for creating spectrogram data:
- Each frequency slice is created by running an **FFT** across a **30ms window** of audio sample data
- Multiple slices are combined to form a time-frequency representation
- This representation is fed into the CNN for classification

## Hardware Platform

Using **STM32F746NG Discovery Board** featuring:
- Internal MEMS digital microphone for audio recording
- SD card storage for `.wav` file recording
- Sufficient processing power for real-time inference
- LCD display for visualization

![Hardware Setup](/assets/images/projects/sound_recognition_3_1.jpg)

### Data Collection

The datasets were collected using the same hardware platform to ensure consistency between training and deployment environments.

![Data Collection](/assets/images/projects/sound_recognition_3_2.jpg)

## Results

The implementation achieved an **accuracy rate of 88.325%** in detecting motor faults through sound analysis.

![Results](/assets/images/projects/sound_recognition_4.jpg)

### Performance Metrics

- **Accuracy**: 88.3%
- **Inference Time**: Real-time on STM32
- **Model Size**: Optimized for embedded deployment
- **Power Consumption**: Low-power operation

## Technologies Used

- **Framework**: TensorFlow → TensorFlow Lite
- **Microcontroller**: STM32F746NG
- **IDE**: STM32CubeIDE
- **Audio Processing**: FFT, Spectrogram generation
- **Deep Learning**: CNN for classification
- **Storage**: MicroSD card interface

## Applications

This system can be used for:
- Predictive maintenance in industrial settings
- Early fault detection in motors
- Automated quality control
- Condition monitoring systems
- Reducing unexpected downtime

## Key Achievements

### Edge AI Implementation
Successfully deployed a deep learning model on a resource-constrained microcontroller

### Real-time Processing
Achieved real-time audio processing and classification

### Data Pipeline
Built complete pipeline from data collection to deployment

### Model Optimization
Optimized neural network for embedded systems

## Skills Demonstrated

- Embedded machine learning
- TensorFlow/TensorFlow Lite
- Digital signal processing (DSP)
- STM32 microcontroller programming
- Audio processing and FFT
- Edge AI deployment
- Firmware development
- Model optimization for embedded systems

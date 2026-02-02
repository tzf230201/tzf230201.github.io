---
title: Wave Run-up Measurement using CNN
description: Real-time wave height measurement using CNN image segmentation for coastal structure analysis with 94% accuracy.
cover_image: /assets/images/projects/wave_run_up_1.png
tags: [CNN, Deep Learning, Image Segmentation, Computer Vision, Python]
featured: false
demo_url: 
repo_url: 
date: 2023-08-01
---

## Project Overview

The objective is to measure the height of waves in real-time using CNN methods from a top-view perspective. This system is used for analyzing physical model testing of coastal structures, providing accurate measurements that are difficult to obtain manually.

![Wave Run-up System](/assets/images/projects/wave_run_up_1.png)

## Technical Approach

### CNN Architecture

The system uses **U-Net architecture** for image segmentation, achieving an impressive **accuracy rate of 94%**, even detecting waves that are difficult for the human eye to see.

### Image Processing Pipeline

I implemented additional image processing features to:
- Convert wave height measurements to standard units
- Draw real-time values on the output image
- Save data to CSV files for analysis
- Process video streams in real-time

![Results Visualization](/assets/images/projects/wave_run_up_2.png)

## Key Features

### Real-time Processing
- Live video feed analysis
- Instant wave height measurement
- Continuous data logging

### High Accuracy
- 94% segmentation accuracy
- Precise height calculation
- Reliable in varying lighting conditions

### Data Management
- CSV export for further analysis
- Visualization overlay
- Statistical processing capabilities

## Technologies Used

- **Deep Learning Framework**: TensorFlow/Keras
- **Architecture**: U-Net for semantic segmentation
- **Image Processing**: OpenCV
- **Programming**: Python
- **Data Analysis**: NumPy, Pandas
- **Visualization**: Matplotlib

## Demo Video

<video width="100%" controls>
    <source src="/video/wave_run_up_clip_1.mp4" type="video/mp4">
    Your browser does not support the video tag.
</video>

## Applications

This system is valuable for:
- Coastal engineering research
- Physical model testing
- Wave behavior analysis
- Coastal structure design validation
- Marine technology studies

## Results & Impact

The system successfully provides:
- Accurate wave height measurements
- Real-time data collection
- Automated analysis reducing human error
- Cost-effective alternative to expensive sensors
- Research support for marine technology faculty

## Future Enhancements

- [ ] Multi-camera setup for 3D reconstruction
- [ ] Integration with other environmental sensors
- [ ] Cloud-based data analysis
- [ ] Mobile deployment capabilities
- [ ] Extended weather condition support

## Skills Demonstrated

- Deep learning model development
- Computer vision implementation
- Image segmentation techniques
- Real-time video processing
- Scientific data analysis
- Research collaboration

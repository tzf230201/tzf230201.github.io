---
layout: resume
title: Resume
subtitle: "M.Eng Candidate at Tokyo Metropolitan University<br>Robotics &amp; Embedded Systems Engineer"
permalink: /resume/
---

<section class="cv-section cv-section--summary" markdown="1">

## Professional Summary

M.Eng candidate in Mechanical Systems Engineering at Tokyo Metropolitan University, specializing in robotics, embedded systems, FPGA-based edge intelligence, and control systems. Experienced in developing embedded firmware, FPGA-based video processing, ROS-based robotic systems, and industrial automation systems across avionics, electric vehicle, and robotics projects. Published in IEEE conferences and actively working on robotics research and embedded AI.

</section>

---

<section class="cv-section cv-section--education" markdown="1">

## Education

<div class="cv-timeline" markdown="1">

<div class="cv-entry" markdown="1">

### [Tokyo Metropolitan University](https://www.tmu.ac.jp/english/index.html) · <span class="cv-loc">Japan <img class="cv-flag" src="https://flagcdn.com/jp.svg" alt="Japan" width="20"></span>
Master of Engineering - Mechanical Systems Engineering
{: .cv-role}

[Intelligent Robotics Laboratory / Kubota Laboratory](https://kub-lab.jp/)  
Tokyo Global Partner (TGP) Scholarship recipient
{: .cv-detail}

*October 2025 – September 2027 (Expected)*
{: .cv-date}

</div>

<div class="cv-entry" markdown="1">

### [Politeknik Elektronika Negeri Surabaya (PENS)](https://www.pens.ac.id/) · <span class="cv-loc">Indonesia <img class="cv-flag" src="https://flagcdn.com/id.svg" alt="Indonesia" width="20"></span>
Bachelor of Applied Engineering - Electronics Engineering
{: .cv-role}

Industrial Robotics Laboratory
{: .cv-detail}

*May 2018 – August 2022* · [Graduation Certificate & Transcript](https://drive.google.com/file/d/1Zkzphf9Zs9DofBsya9QLxsumhvso7-r3/view){: .doc-link}
{: .cv-date}

</div>

</div>

</section>

---

{% assign pubs = site.data.publications.list %}{% if pubs and pubs.size > 0 %}
<section class="cv-section cv-section--publications" markdown="1">

## Publications

<div class="pub-list cv-timeline">
{% assign prev_year = "" %}{% for p in pubs %}
<article class="pub-item">
    <p class="pub-year{% if p.year == prev_year %} is-repeat{% endif %}">{{ p.year }}</p>{% assign prev_year = p.year %}
    <div class="pub-body">
        <p class="pub-type">{{ p.type | default: "Publication" }}</p>
        <h3 class="pub-title">{% if p.url and p.url != "" %}<a href="{{ p.url }}" target="_blank" rel="noopener">{{ p.title }}</a>{% else %}{{ p.title }}{% endif %}</h3>
        <p class="pub-authors">{{ p.authors | replace: "Fatahillah, T. Z.", "<strong>Fatahillah, T. Z.</strong>" | replace: "Teuku Zikri Fatahillah", "<strong>Teuku Zikri Fatahillah</strong>" }}</p>
        <p class="pub-venue">{{ p.venue }}{% if p.year %}<span class="pub-venue-year"> · {{ p.year }}</span>{% endif %}{% if p.award %} · <span class="pub-award">{{ p.award }}</span>{% endif %}</p>
        {%- assign has_proj = false -%}{%- if p.project and p.project != "" -%}{%- assign has_proj = true -%}{%- endif -%}
        {%- assign has_cert = false -%}{%- if p.certificate and p.certificate != "" -%}{%- assign has_cert = true -%}{%- endif %}
        {% if has_proj or has_cert %}<p class="pub-links">{% if has_proj %}<a class="pub-project" href="{{ p.project }}" target="_blank" rel="noopener">Project Page</a>{% endif %}{% if has_cert %}<a class="doc-link" href="{{ p.certificate }}" target="_blank" rel="noopener">View Certificate</a>{% endif %}</p>{% endif %}
    </div>
</article>
{% endfor %}
</div>

</section>

---

{% endif %}<section class="cv-section cv-section--experience" markdown="1">

## Professional Experience

<div class="cv-timeline" markdown="1">

<div class="cv-entry" markdown="1">

### PT. Reka Inovasi Cerdas
**Electronics & Embedded Systems Engineer**
{: .cv-role}

*April 2025 – August 2025* · [Certificate](https://drive.google.com/file/d/1xuFuP9mLMFbr0Iwdjz4QYN2PK9asUmbD/view?usp=sharing){: .doc-link}
{: .cv-date}

- Designed and developed CNC Laser Cutting system with precise motion control
- Engineered LoRa IoT device for long-range wireless communication and data monitoring
- Conducted reverse engineering of valve turbine components for system optimization
- Implemented embedded control systems for industrial automation
- Created technical documentation and system specifications

**Key Achievement:** Successfully delivered three major projects meeting client specifications and industrial standards
{: .cv-key}

</div>

<div class="cv-entry" markdown="1">

### PT. Genesis Technology Indonesia
**Production Maintenance Technician – Contract**
{: .cv-role}

*September 2024 – January 2025* · [Certificate](https://drive.google.com/file/d/1JECmoV8kVXku5UZdwmXYNTs507V_sAsk/view?usp=sharing){: .doc-link}
{: .cv-date}

- Led a team of machine operators in a high-volume production line
- Provided comprehensive training to new employees on machine operation, maintenance protocols, and safety procedures
- Coordinated machine installations based on technical drawings, directing forklift operations
- Managed maintenance schedules ensuring 99%+ uptime
- Troubleshot and resolved production machine issues, minimizing downtime
- Installed electrical panels and programmed PLCs (Siemens TIA Portal)
- Installed and maintained pneumatic systems
- Prepared detailed monthly reports for management review

**Key Achievement:** Successfully reduced machine downtime by 30% through proactive maintenance scheduling
{: .cv-key}

</div>

<div class="cv-entry cv-entry--break" markdown="1">

### Graduate School Preparation
**Career Break**
{: .cv-role}

*April 2024 – September 2024*
{: .cv-date}

- Prepared applications for graduate study (M.Eng) in Japan
- Studied the Japanese language

</div>

<div class="cv-entry" markdown="1">

### PT. Infoglobal Teknologi Semesta
**Electronic Engineer – Contract**
{: .cv-role}

*October 2022 – April 2024* · [Certificate](https://drive.google.com/file/d/1f5H_25XOcWxXqd87NUN5z3seU22ZcZC5/view){: .doc-link}
{: .cv-date}

#### Key Projects & Achievements:

**Hawk-100 Rear Cockpit Monitor (RCM)**
{: .cv-sub}

- Designed schematics and PCB layout for military-grade avionics display system
- Implemented high-speed DDR-SDRAM interface for video processing
- Programmed FPGA using VHDL for digital video processing
- {: .cv-hl} **Achievement:** 66% reduction in video processing time
- Built comprehensive test equipment for quality assurance
- Met all military standards (MIL-STD) compliance requirements

**CAKRA-401 Submarine Electronic Data Display (EDD)**
{: .cv-sub}

- Conducted reverse engineering of 1980s German analog video system
- Analyzed non-standard analog video signals using oscilloscopes
- Designed modern replacement using FPGA and LCD technology
- Successfully replicated functionality while reducing size and weight by 40%
- Ensured compatibility with existing submarine systems

**CN235-220 Aircraft Component Maintenance**
{: .cv-sub}

- Diagnosed and repaired avionics components
- Provided technical documentation and specifications for system discussions
- Upgraded avionics features through prototyping and testing

**Technical Contributions:**
{: .cv-sub}

- Managed version control for multiple projects using GitLab
- Created comprehensive technical documentation
- Collaborated with cross-functional teams for system integration

</div>

<div class="cv-entry" markdown="1">

### PT. Industri Kereta Api (Persero) - INKA
**Embedded Programmer – Intern**
{: .cv-role}

*February 2022 – July 2022* · [Certificate](https://drive.google.com/file/d/1dEjMEYla6MItw9q3Akhxx56kID7jGwfx/view){: .doc-link}
{: .cv-date}

**Merah Putih Electric Bus - Vehicle Control Unit (VCU)**
{: .cv-sub}

- Developed complete VCU firmware from concept to deployment
- Configured I/O using HalCoGen, programmed state machines in C
- Implemented CAN bus communication protocol for vehicle subsystems
- Designed and built VCU test jig for safe algorithm validation
- Created comprehensive firmware documentation

<div class="cv-key" markdown="1">

**Key Achievements:**

- **Highest score** in Certified Internship and Independent Study Program Batch II
- Successfully deployed system for **G20 Summit 2022**
- Contributed to achieving 40%+ Domestic Component Level (TKDN)
- Completed project from design phase to road testing within tight deadline

</div>

</div>

</div>

</section>

---

<section class="cv-section cv-section--awards" markdown="1">

## Awards

<div class="cv-groups" markdown="1">

<div class="cv-entry cv-entry--group" markdown="1">

**Scholarship**
{: .cv-label}

- <span class="cv-item">**Tokyo Global Partner (TGP) Scholarship** · Tokyo Metropolitan University · 2025&nbsp;–&nbsp;Present</span>

</div>

<div class="cv-entry cv-entry--group" markdown="1">

**Academic**
{: .cv-label}

- <span class="cv-item">**Excellence Award (Applied Technology Award)** · Research Project Seminar (3) (PBL) Final Presentation, Graduate School of Systems Design, Tokyo Metropolitan University (Team 4, with Yushin Engineering Co., Ltd.) · July 2026</span> [Certificate](https://drive.google.com/file/d/1YiiXtokLIAWIyZVxF7hHmrSTxVsaGQmy/view?usp=sharing){: .doc-link}
- <span class="cv-item">**Highest Score** · Certified Internship and Independent Study Program Batch II (PT. INKA) · 2022</span> [Certificate](https://drive.google.com/file/d/1dEjMEYla6MItw9q3Akhxx56kID7jGwfx/view){: .doc-link}

</div>

<div class="cv-entry cv-entry--group" markdown="1">

**Robotics Competitions** · EROS Humanoid Robot Team (PENS)
{: .cv-label}

- <span class="cv-item">**1st Place · Overall**, KRSBI-Humanoid · Kontes Robot Indonesia (KRI) 2021</span> [Certificate](https://drive.google.com/file/d/12G93wXLHL9m8xaeZVwWCW7ixxk9gPJGo/view?usp=sharing){: .doc-link}
- <span class="cv-item">**1st Place · Humanoid Sprint**, 2021</span> [Certificate](https://drive.google.com/file/d/1t5OZ1Qtv61nGQD8Ca01dXrgN3Mo3_X2-/view?usp=sharing){: .doc-link}
- <span class="cv-item">**2nd Place · Humanoid Ball Dribbling**, 2021</span> [Certificate](https://drive.google.com/file/d/15wXfL1nZ7qrEKdjAz2kUToiA5i1_b1ks/view?usp=sharing){: .doc-link}
- <span class="cv-item">**3rd Place · Humanoid Robot Cooperation**, 2021</span> [Certificate](https://drive.google.com/file/d/1IeBGSdQhzQAt1nw2beYOM0bFHLzK82IU/view?usp=sharing){: .doc-link}
- <span class="cv-item">**1st Place · Humanoid Ball Dribbling**, 2020</span> [Certificate](https://drive.google.com/file/d/1yWsQuFd0xY0ZyYOV_rGDnLX6WleSgD4W/view?usp=sharing){: .doc-link}
- <span class="cv-item">**Honorable Mention · Humanoid Sprint**, 2020</span> [Certificate](https://drive.google.com/file/d/1s5c62mNvQKXNdPCPEclWlJ_hXfpegGf9/view?usp=sharing){: .doc-link}

</div>

<div class="cv-entry cv-entry--group" markdown="1">

**ASEAN Skills Competition 2019 · Mobile Robotics**
{: .cv-label}

- <span class="cv-item">**1st Place** · Regional Selection (Seleksi Daerah), Mobile Robotics</span> [Certificate](https://drive.google.com/file/d/19-KrbkLAL8kFno8pT8F3oiR97kIbzUia/view?usp=sharing){: .doc-link}
- <span class="cv-item">**3rd Place** · National Selection (Seleksi Nasional), Mobile Robotics</span> [Certificate](https://drive.google.com/file/d/1jXcYniuPxPpEExFUY9R5FCgrNv0piZXi/view?usp=sharing){: .doc-link}
- <span class="cv-item">Selected for the National Training Team (Quarantine) representing the Mobile Robotics field</span>

</div>

</div>

</section>

---

<section class="cv-section cv-section--organizations" markdown="1">

## Organizational Experience

<div class="cv-timeline" markdown="1">

<div class="cv-entry" markdown="1">

### PPI TMU · Persatuan Pelajar Indonesia, Tokyo Metropolitan University
**Member**
{: .cv-role}

*2025 – Present*
{: .cv-date}

- Active member of the Indonesian Students Association at Tokyo Metropolitan University

</div>

<div class="cv-entry" markdown="1">

### EEPIS Robot Soccer (EROS)
**Humanoid Robot Team – Co-Leader, Programmer, Electrical Design**
{: .cv-role}

*November 2019 – November 2021*
{: .cv-date}

**Technical Contributions:**
{: .cv-sub}

- Developed 20 DoF humanoid robot with dynamic walking capability
- Programmed soccer strategy algorithms in ROS framework
- Designed PCB schematics and layouts for sub-controllers (STM32)
- Implemented kinematics and dynamics analysis for walking system
- Developed URDF model for digital twin simulation

<div class="cv-key" markdown="1">

**Key Achievements:**

- **68% reduction** in Center of Mass (CoM) error from ZMP reference
- Improved maneuver system by implementing footstep planner
- Applied control methods for humanoid robot reflex systems
- Analyzed and optimized walking gait patterns

</div>

**Skills Developed:**
{: .cv-sub}

- ROS/ROS2, OpenCV, C++, Python
- URDF modeling and Gazebo simulation
- TCP/IP, UDP communication
- Docker containerization
- STM32 embedded programming

</div>

<div class="cv-entry" markdown="1">

### HIMA ELKA PENS
**Electronics Engineering Student Association – Research and Technology Staff**
{: .cv-role}

*October 2019 – December 2020* · [Certificate](https://drive.google.com/file/d/1JQiV3lSoq9-BeyalGl2yK8bX2Yxvq7mY/view){: .doc-link}
{: .cv-date}

- Organized training, workshops, and seminars for student development
- Prepared laboratories and facilitated student participation in competitions
- Coordinated with faculty for ongoing research projects
- Managed project timelines using Trello

</div>

</div>

</section>

---

<section class="cv-section cv-section--skills" markdown="1">

## Technical Skills

<div class="cv-groups" markdown="1">

<div class="cv-entry cv-entry--group" markdown="1">

### Programming & Development
{: .cv-label}

**Languages:** C/C++, Python, Embedded C, C#, VHDL/Verilog, MATLAB, Shell Scripting  
**Robotics:** ROS/ROS2, URDF/Xacro, Gazebo, CoppeliaSim  
**Web & IoT:** HTML, CSS, JavaScript, Node.js, RESTful API, MQTT, PyQT
{: .cv-kv}

</div>

<div class="cv-entry cv-entry--group" markdown="1">

### Embedded & Hardware
{: .cv-label}

**FPGA Tools:** Xilinx ISE, Vivado, Vitis, Gowin EDA  
**Microcontrollers:** STM32, Texas Instruments Hercules, National Instruments MyRio  
**IDEs:** STM32CubeIDE, Code Composer Studio, ArduinoIDE, PlatformIO  
**Protocols:** CAN Bus, I2C, I2S, SPI, UART, USB
{: .cv-kv}

</div>

<div class="cv-entry cv-entry--group" markdown="1">

### Electronics & PCB Design
{: .cv-label}

**ECAD Tools:** KiCAD, EasyEDA, Autodesk Eagle, LTSpice, PSpice, Proteus  
**CAD/3D:** Autodesk Inventor, FreeCAD, SolidWorks, CURA
{: .cv-kv}

</div>

<div class="cv-entry cv-entry--group" markdown="1">

### AI & Computer Vision
{: .cv-label}

**Frameworks:** TensorFlow, TensorFlow Lite, Keras, CUDA  
**Libraries:** OpenCV, PCL (Point Cloud Library)  
**Specialization:** CNN, Image Segmentation, Edge AI, Edge Unsupervised Learning
{: .cv-kv}

</div>

<div class="cv-entry cv-entry--group" markdown="1">

### Industrial Automation
{: .cv-label}

**PLC:** Omron, Siemens (Ladder Diagram)  
**Simulation:** Festo Fluidsim, Siemens TIA Portal  
**HMI:** LabVIEW
{: .cv-kv}

</div>

<div class="cv-entry cv-entry--group" markdown="1">

### Development Tools
{: .cv-label}

**Version Control:** Git, GitHub, GitLab  
**Containerization:** Docker  
**Testing:** Oscilloscope, Logic Analyzer, Vector CANalyzer, Wireshark  
**Project Management:** Trello, Hoddo
{: .cv-kv}

</div>

</div>

</section>

---

<section class="cv-section cv-section--projects" markdown="1">

## Key Projects

<div class="cv-groups" markdown="1">

<div class="cv-entry cv-entry--group" markdown="1">

### 2024
{: .cv-label}

- **MPC on Ackermann Drive Robot** - Autonomous navigation with Lidar-based obstacle avoidance

</div>

<div class="cv-entry cv-entry--group" markdown="1">

### 2023
{: .cv-label}

- **CAKRA-401 Submarine Console** - Reverse engineering military submarine display system
- **Hawk-100 RCM** - Military-grade cockpit display with FPGA processing (66% faster)
- **Wave Run-up CNN** - Real-time measurement system with 94% accuracy
- **Sound Recognition System** - Motor fault detection on STM32 (88.3% accuracy)

</div>

<div class="cv-entry cv-entry--group" markdown="1">

### 2022
{: .cv-label}

- **Humanoid Robot Digital Twin** - Real-time CoM projection (68% error reduction)
- **Electric Bus VCU** - Complete firmware for G20 Summit deployment

</div>

<div class="cv-entry cv-entry--group" markdown="1">

### 2021
{: .cv-label}

- **3D Tracking Lidar** - Perception system using ROS and PCL

</div>

</div>

</section>

---

<section class="cv-section cv-section--list" markdown="1">

## Certifications

- <span class="cv-item">**Robot Operating System (ROS)**</span> [Certificate](https://drive.google.com/file/d/1LM8hsLIXTGnpNHXLcgbOVcnnWag0LxZK/view?usp=sharing){: .doc-link}
- <span class="cv-item">**CoppeliaSim / V-REP**</span> [Certificate](https://drive.google.com/file/d/19XatatfVS4H4B0ARhDy1Ca2_XALR_KIi/view?usp=sharing){: .doc-link}
- <span class="cv-item">**Autodesk Inventor**</span> [Certificate](https://drive.google.com/file/d/1a_00ngwbrEVT2FfVWGpNtntYzX5hZO9P/view?usp=sharing){: .doc-link}
- <span class="cv-item">**Embedded Systems and Data Acquisition** (2021)</span> [Certificate](https://drive.google.com/file/d/13Xv3cw4rMbddr5dr_QXpSMCCHodCf_wS/view?usp=sharing){: .doc-link}
- <span class="cv-item">**Nature Masterclasses** · *Getting Published: Effectively Communicating Your Research* (Expert Trainer-led workshop)</span> [Certificate](https://drive.google.com/file/d/1wZqS2FHIkRcvL9hELS3fHMuLNpHDSvhn/view?usp=sharing){: .doc-link}

</section>

---

<section class="cv-section cv-section--list" markdown="1">

## Activities

- <span class="cv-item">**Robotics Workshop Speaker / Instructor**</span> [Certificates](https://drive.google.com/drive/folders/1jC2G61Z253U08smOECb1QE_vJEKeILxf){: .doc-link}
- <span class="cv-item">**Committee Member · Java Robot Contest X** (2018–2019)</span> [Certificate](https://drive.google.com/file/d/1z2y2tYTTZwQREU7dWf3LJCxSkeJ87j4Q/view?usp=sharing){: .doc-link}
- <span class="cv-item">Multiple national robotics competition participations</span>

</section>

---

<section class="cv-section cv-section--list" markdown="1">

## Languages

- <span class="cv-item">**English** - Professional Working Proficiency</span> [EF SET Certificate](https://cert.efset.org/en/ui9fgu){: .doc-link}
- <span class="cv-item">**Japanese** - Currently Learning (N4 Level)</span>
- <span class="cv-item">**Indonesian** - Native</span>

</section>

---

<section class="cv-section cv-section--download no-print" markdown="1">

## Download CV
{: .toc-skip}

<div class="cv-download">
    <p>Download my full CV in PDF format:</p>
    <button type="button" class="btn btn-primary" onclick="window.print()">
        <svg width="16" height="16" fill="currentColor" viewBox="0 0 16 16" aria-hidden="true">
            <path d="M.5 9.9a.5.5 0 0 1 .5.5v2.5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2.5a.5.5 0 0 1 1 0v2.5a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2v-2.5a.5.5 0 0 1 .5-.5z"/>
            <path d="M7.646 11.854a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V1.5a.5.5 0 0 0-1 0v8.793L5.354 8.146a.5.5 0 1 0-.708.708l3 3z"/>
        </svg>
        Save as PDF / Print
    </button>
    <p class="cv-download-hint">Opens your browser’s print dialog. Choose “Save as PDF” as the destination for a clean A4 copy.</p>
</div>

</section>

---

*Last Updated: October 2026*
{: .cv-updated}

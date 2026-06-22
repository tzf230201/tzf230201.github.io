---
layout: page
title: Resume
subtitle: Electronics Engineer | Robotics Specialist | Embedded Systems Developer
permalink: /resume/
---

<nav class="resume-toc" id="resume-toc" aria-label="Resume sections"></nav>

## Professional Summary

A highly motivated electronics engineer with 3+ years of experience in robotics, embedded systems, and FPGA development. Proven track record in avionics, automotive, and marine technology sectors with expertise in ROS/ROS2, computer vision, and control systems. Successfully delivered critical projects for military applications and electric vehicle systems.

---

## Education

**[Tokyo Metropolitan University](https://www.tmu.ac.jp/english/index.html)**  
Master of Engineering - Mechanical Systems Engineering  
[Kubota Laboratory](https://kub-lab.jp/)  
*October 2025 – September 2027 (Expected)*

**[Politeknik Elektronika Negeri Surabaya (PENS)](https://www.pens.ac.id/)**  
Bachelor of Applied Engineering - Electronics Engineering  
*May 2018 – August 2022* · [📄 Graduation Certificate & Transcript](https://drive.google.com/file/d/1Zkzphf9Zs9DofBsya9QLxsumhvso7-r3/view)

---

{% assign pubs = site.data.publications.list %}{% if pubs and pubs.size > 0 %}
## Publications

<div class="pub-list">
{% for p in pubs %}
<div class="pub-item">
    <span class="pub-type">{{ p.type | default: "Publication" }}</span>
    <div class="pub-body">
        <h3 class="pub-title">{% if p.url and p.url != "" %}<a href="{{ p.url }}" target="_blank" rel="noopener">{{ p.title }}</a>{% else %}{{ p.title }}{% endif %}</h3>
        <p class="pub-authors">{{ p.authors | replace: "Fatahillah, T. Z.", "<strong>Fatahillah, T. Z.</strong>" | replace: "Teuku Zikri Fatahillah", "<strong>Teuku Zikri Fatahillah</strong>" }}</p>
        <p class="pub-venue">{{ p.venue }}{% if p.year %} · {{ p.year }}{% endif %}{% if p.award %} · <span class="pub-award">🏆 {{ p.award }}</span>{% endif %}</p>
        {% if p.certificate and p.certificate != "" %}<p class="pub-links"><a href="{{ p.certificate }}" target="_blank" rel="noopener">📄 View Certificate</a></p>{% endif %}
    </div>
</div>
{% endfor %}
</div>

---

{% endif %}## Professional Experience

### PT. Reka Inovasi Cerdas
**Electronics & Embedded Systems Engineer**  
*April 2025 – August 2025* · [📄 Certificate](https://drive.google.com/file/d/1xuFuP9mLMFbr0Iwdjz4QYN2PK9asUmbD/view?usp=sharing)

- Designed and developed CNC Laser Cutting system with precise motion control
- Engineered LoRa IoT device for long-range wireless communication and data monitoring
- Conducted reverse engineering of valve turbine components for system optimization
- Implemented embedded control systems for industrial automation
- Created technical documentation and system specifications

**Key Achievement:** Successfully delivered three major projects meeting client specifications and industrial standards

---

### PT. Genesis Technology Indonesia
**Production Maintenance Technician – Contract**  
*September 2024 – January 2025* · [📄 Certificate](https://drive.google.com/file/d/1JECmoV8kVXku5UZdwmXYNTs507V_sAsk/view?usp=sharing)

- Led a team of machine operators in a high-volume production line
- Provided comprehensive training to new employees on machine operation, maintenance protocols, and safety procedures
- Coordinated machine installations based on technical drawings, directing forklift operations
- Managed maintenance schedules ensuring 99%+ uptime
- Troubleshot and resolved production machine issues, minimizing downtime
- Installed electrical panels and programmed PLCs (Siemens TIA Portal)
- Installed and maintained pneumatic systems
- Prepared detailed monthly reports for management review

**Key Achievement:** Successfully reduced machine downtime by 30% through proactive maintenance scheduling

---

### PT. Infoglobal Teknologi Semesta
**Electronic Engineer – Contract**  
*October 2022 – April 2024* · [📄 Certificate](https://drive.google.com/file/d/1f5H_25XOcWxXqd87NUN5z3seU22ZcZC5/view)

#### Key Projects & Achievements:

**Hawk-100 Rear Cockpit Monitor (RCM)**
- Designed schematics and PCB layout for military-grade avionics display system
- Implemented high-speed DDR-SDRAM interface for video processing
- Programmed FPGA using VHDL for digital video processing
- **Achievement:** 66% reduction in video processing time
- Built comprehensive test equipment for quality assurance
- Met all military standards (MIL-STD) compliance requirements

**CAKRA-401 Submarine Electronic Data Display (EDD)**
- Conducted reverse engineering of 1980s German analog video system
- Analyzed non-standard analog video signals using oscilloscopes
- Designed modern replacement using FPGA and LCD technology
- Successfully replicated functionality while reducing size and weight by 40%
- Ensured compatibility with existing submarine systems

**CN235-220 Aircraft Component Maintenance**
- Diagnosed and repaired avionics components
- Provided technical documentation and specifications for system discussions
- Upgraded avionics features through prototyping and testing

**Technical Contributions:**
- Managed version control for multiple projects using GitLab
- Created comprehensive technical documentation
- Collaborated with cross-functional teams for system integration

---

### PT. Industri Kereta Api (Persero) - INKA
**Embedded Programmer – Intern**  
*February 2022 – July 2022* · [📄 Certificate](https://drive.google.com/file/d/1dEjMEYla6MItw9q3Akhxx56kID7jGwfx/view)

**Merah Putih Electric Bus - Vehicle Control Unit (VCU)**
- Developed complete VCU firmware from concept to deployment
- Configured I/O using HalCoGen, programmed state machines in C
- Implemented CAN bus communication protocol for vehicle subsystems
- Designed and built VCU test jig for safe algorithm validation
- Created comprehensive firmware documentation

**Key Achievements:**
- **Highest score** in Certified Internship and Independent Study Program Batch II
- Successfully deployed system for **G20 Summit 2022**
- Contributed to achieving 40%+ Domestic Component Level (TKDN)
- Completed project from design phase to road testing within tight deadline

---

## Organizational Experience

### PPI TMU — Persatuan Pelajar Indonesia, Tokyo Metropolitan University
**Member**  
*2025 – Present*

- Active member of the Indonesian Students Association at Tokyo Metropolitan University

---

### EEPIS Robot Soccer (EROS)
**Humanoid Robot Team – Co-Leader, Programmer, Electrical Design**  
*November 2019 – November 2021*

**Competition Awards:**

- **1st Place — Overall**, KRSBI-Humanoid · Kontes Robot Indonesia (KRI) 2021 — [📄 Certificate](https://drive.google.com/file/d/12G93wXLHL9m8xaeZVwWCW7ixxk9gPJGo/view?usp=sharing)
- **1st Place — Humanoid Sprint**, 2021 — [📄 Certificate](https://drive.google.com/file/d/1t5OZ1Qtv61nGQD8Ca01dXrgN3Mo3_X2-/view?usp=sharing)
- **2nd Place — Humanoid Ball Dribbling**, 2021 — [📄 Certificate](https://drive.google.com/file/d/15wXfL1nZ7qrEKdjAz2kUToiA5i1_b1ks/view?usp=sharing)
- **3rd Place — Humanoid Robot Cooperation**, 2021 — [📄 Certificate](https://drive.google.com/file/d/1IeBGSdQhzQAt1nw2beYOM0bFHLzK82IU/view?usp=sharing)
- **1st Place — Humanoid Ball Dribbling**, 2020 — [📄 Certificate](https://drive.google.com/file/d/1yWsQuFd0xY0ZyYOV_rGDnLX6WleSgD4W/view?usp=sharing)
- **Honorable Mention — Humanoid Sprint**, 2020 — [📄 Certificate](https://drive.google.com/file/d/1s5c62mNvQKXNdPCPEclWlJ_hXfpegGf9/view?usp=sharing)

**Technical Contributions:**
- Developed 20 DoF humanoid robot with dynamic walking capability
- Programmed soccer strategy algorithms in ROS framework
- Designed PCB schematics and layouts for sub-controllers (STM32)
- Implemented kinematics and dynamics analysis for walking system
- Developed URDF model for digital twin simulation

**Key Achievements:**
- **68% reduction** in Center of Mass (CoM) error from ZMP reference
- Improved maneuver system by implementing footstep planner
- Applied control methods for humanoid robot reflex systems
- Analyzed and optimized walking gait patterns

**Skills Developed:**
- ROS/ROS2, OpenCV, C++, Python
- URDF modeling and Gazebo simulation
- TCP/IP, UDP communication
- Docker containerization
- STM32 embedded programming

---

### ASEAN Skills Competition 2019 — Mobile Robotics
**National Training Team (Quarantine) – Competitor**  
*2019*

- **1st Place** — Regional Selection (Seleksi Daerah), Mobile Robotics — [📄 Certificate](https://drive.google.com/file/d/19-KrbkLAL8kFno8pT8F3oiR97kIbzUia/view?usp=sharing)
- **3rd Place** — National Selection (Seleksi Nasional), Mobile Robotics — [📄 Certificate](https://drive.google.com/file/d/1jXcYniuPxPpEExFUY9R5FCgrNv0piZXi/view?usp=sharing)
- Selected for the national training team representing the Mobile Robotics field

---

### HIMA ELKA PENS
**Electronics Engineering Student Association – Research and Technology Staff**  
*October 2019 – December 2020* · [📄 Certificate](https://drive.google.com/file/d/1JQiV3lSoq9-BeyalGl2yK8bX2Yxvq7mY/view)

- Organized training, workshops, and seminars for student development
- Prepared laboratories and facilitated student participation in competitions
- Coordinated with faculty for ongoing research projects
- Managed project timelines using Trello

---

## Technical Skills

### Programming & Development
**Languages:** C/C++, Python, Embedded C, C#, VHDL/Verilog, MATLAB, Shell Scripting  
**Robotics:** ROS/ROS2, URDF/Xacro, Gazebo, CoppeliaSim  
**Web & IoT:** HTML, CSS, JavaScript, Node.js, RESTful API, MQTT, PyQT

### Embedded & Hardware
**FPGA Tools:** Xilinx ISE, Vivado, Vitis, Gowin EDA  
**Microcontrollers:** STM32, Texas Instruments Hercules, National Instruments MyRio  
**IDEs:** STM32CubeIDE, Code Composer Studio, ArduinoIDE, PlatformIO  
**Protocols:** CAN Bus, I2C, I2S, SPI, UART, USB

### Electronics & PCB Design
**ECAD Tools:** KiCAD, EasyEDA, Autodesk Eagle, LTSpice, PSpice, Proteus  
**CAD/3D:** Autodesk Inventor, FreeCAD, SolidWorks, CURA

### AI & Computer Vision
**Frameworks:** TensorFlow, TensorFlow Lite, Keras, CUDA  
**Libraries:** OpenCV, PCL (Point Cloud Library)  
**Specialization:** CNN, Image Segmentation, Edge AI, Edge Unsupervised Learning

### Industrial Automation
**PLC:** Omron, Siemens (Ladder Diagram)  
**Simulation:** Festo Fluidsim, Siemens TIA Portal  
**HMI:** LabVIEW

### Development Tools
**Version Control:** Git, GitHub, GitLab  
**Containerization:** Docker  
**Testing:** Oscilloscope, Logic Analyzer, Vector CANalyzer, Wireshark  
**Project Management:** Trello, Hoddo

---

## Key Projects

### 2024
- **MPC on Ackermann Drive Robot** - Autonomous navigation with Lidar-based obstacle avoidance

### 2023
- **CAKRA-401 Submarine Console** - Reverse engineering military submarine display system
- **Hawk-100 RCM** - Military-grade cockpit display with FPGA processing (66% faster)
- **Wave Run-up CNN** - Real-time measurement system with 94% accuracy
- **Sound Recognition System** - Motor fault detection on STM32 (88.3% accuracy)

### 2022
- **Humanoid Robot Digital Twin** - Real-time CoM projection (68% error reduction)
- **Electric Bus VCU** - Complete firmware for G20 Summit deployment

### 2021
- **3D Tracking Lidar** - Perception system using ROS and PCL

---

## Certifications

- **Robot Operating System (ROS)** — [📄 Certificate](https://drive.google.com/file/d/1LM8hsLIXTGnpNHXLcgbOVcnnWag0LxZK/view?usp=sharing)
- **CoppeliaSim / V-REP** — [📄 Certificate](https://drive.google.com/file/d/19XatatfVS4H4B0ARhDy1Ca2_XALR_KIi/view?usp=sharing)
- **Autodesk Inventor** — [📄 Certificate](https://drive.google.com/file/d/1a_00ngwbrEVT2FfVWGpNtntYzX5hZO9P/view?usp=sharing)
- **Embedded Systems and Data Acquisition** (2021) — [📄 Certificate](https://drive.google.com/file/d/13Xv3cw4rMbddr5dr_QXpSMCCHodCf_wS/view?usp=sharing)
- **Nature Masterclasses** — *Getting Published: Effectively Communicating Your Research* (Expert Trainer-led workshop) — [📄 Certificate](https://drive.google.com/file/d/1wZqS2FHIkRcvL9hELS3fHMuLNpHDSvhn/view?usp=sharing)

---

## Achievements & Activities

- **Highest Score** — Certified Internship Program Batch II (PT. INKA)
- **Robotics Workshop Speaker / Instructor** — [📄 Certificates](https://drive.google.com/drive/folders/1jC2G61Z253U08smOECb1QE_vJEKeILxf)
- **Committee Member — Java Robot Contest X** (2018–2019) — [📄 Certificate](https://drive.google.com/file/d/1z2y2tYTTZwQREU7dWf3LJCxSkeJ87j4Q/view?usp=sharing)
- Multiple national robotics competition participations

---

## Languages

- **English** - Professional Working Proficiency · [EF SET Certificate](https://cert.efset.org/en/ui9fgu)
- **Japanese** - Currently Learning (N4 Level)
- **Indonesian** - Native

---

## Download CV

<div class="cv-download">
    <p>Download my full CV in PDF format:</p>
    <a href="#" class="btn btn-primary" onclick="alert('PDF will be available soon'); return false;">
        <svg width="16" height="16" fill="currentColor" viewBox="0 0 16 16">
            <path d="M.5 9.9a.5.5 0 0 1 .5.5v2.5a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1v-2.5a.5.5 0 0 1 1 0v2.5a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2v-2.5a.5.5 0 0 1 .5-.5z"/>
            <path d="M7.646 11.854a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V1.5a.5.5 0 0 0-1 0v8.793L5.354 8.146a.5.5 0 1 0-.708.708l3 3z"/>
        </svg>
        Download CV (PDF)
    </a>
</div>

---

*Last Updated: February 2026*

<script>
(function () {
    function init() {
        var content = document.querySelector('.page-content');
        var toc = document.getElementById('resume-toc');
        if (!content || !toc) return;
        var heads = [].slice.call(content.querySelectorAll('h2'));
        if (!heads.length) { toc.remove(); return; }

        function slug(t) {
            return t.toLowerCase().trim().replace(/[^\w]+/g, '-').replace(/^-+|-+$/g, '');
        }

        var byId = {};
        heads.forEach(function (h) {
            if (!h.id) h.id = slug(h.textContent);
            var a = document.createElement('a');
            a.href = '#' + h.id;
            a.textContent = h.textContent;
            a.addEventListener('click', function (e) {
                e.preventDefault();
                history.replaceState(null, '', '#' + h.id);
                h.scrollIntoView({ behavior: 'smooth', block: 'start' });
            });
            toc.appendChild(a);
            byId[h.id] = a;
        });

        // Keep the sticky bar just below the main navbar
        var navbar = document.querySelector('.navbar');
        function setTop() { if (navbar) toc.style.top = navbar.offsetHeight + 'px'; }
        setTop();
        window.addEventListener('resize', setTop);

        // Scrollspy: highlight the section currently in view
        var current = null;
        var observer = new IntersectionObserver(function (entries) {
            entries.forEach(function (entry) {
                if (entry.isIntersecting) current = entry.target.id;
            });
            if (current && byId[current]) {
                Object.keys(byId).forEach(function (id) { byId[id].classList.remove('active'); });
                var link = byId[current];
                link.classList.add('active');
                toc.scrollLeft = link.offsetLeft - (toc.offsetWidth / 2) + (link.offsetWidth / 2);
            }
        }, { rootMargin: '-120px 0px -65% 0px', threshold: 0 });

        heads.forEach(function (h) { observer.observe(h); });
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
})();
</script>

---
layout: default
title: Home
---

<section class="hero">
    <div class="container">
        <span class="hero-eyebrow"><span class="pulse"></span> Available for robotics & embedded roles</span>
        <h1 class="hero-title">Hi, I'm <span class="highlight">Teuku Zikri Fatahillah</span></h1>
        <p class="hero-subtitle">&lt;robotics /&gt; &middot; embedded systems &middot; computer vision</p>
        <p class="hero-description">
            I build intelligent machines — from FPGA-based avionics and electric-vehicle firmware to humanoid robots and Lidar perception. Turning hard engineering problems into systems that actually ship.
        </p>
        <div class="hero-actions">
            <a href="{{ '/projects/' | relative_url }}" class="btn btn-primary">View My Projects</a>
            <a href="{{ '/contact/' | relative_url }}" class="btn btn-secondary">Get in Touch</a>
        </div>
        <div class="hero-stats">
            <div class="hero-stat">
                <div class="num">3+</div>
                <div class="label">Years Experience</div>
            </div>
            <div class="hero-stat">
                <div class="num">{{ site.projects.size }}+</div>
                <div class="label">Projects Shipped</div>
            </div>
            <div class="hero-stat">
                <div class="num">G20</div>
                <div class="label">Summit Deployment</div>
            </div>
        </div>
    </div>
</section>

<section class="section">
    <div class="container">
        <div class="section-head">
            <span class="section-kicker">// about me</span>
            <h2 class="section-title">Engineer across the full robotics stack</h2>
        </div>
        <div class="about-content">
            <p>
                A highly motivated engineer with expertise across the robotics stack — Embedded Systems, Automation, Electronics Design, IoT, DSP, FPGA, Computer Vision, and the Robot Operating System (ROS/ROS2).
            </p>
            <p>
                I hold a track record of winning national competitions and have hands-on R&amp;D experience across avionics, automotive, and marine technology. I'm currently pursuing a Master of Engineering at Tokyo Metropolitan University while deepening my work in electronics, AI, and autonomous systems.
            </p>
            <div class="about-skills">
                <span class="skill-chip">C / C++</span>
                <span class="skill-chip">Python</span>
                <span class="skill-chip">ROS / ROS2</span>
                <span class="skill-chip">VHDL / Verilog</span>
                <span class="skill-chip">STM32</span>
                <span class="skill-chip">FPGA</span>
                <span class="skill-chip">OpenCV</span>
                <span class="skill-chip">TensorFlow</span>
                <span class="skill-chip">CAN Bus</span>
                <span class="skill-chip">KiCAD</span>
            </div>
        </div>
    </div>
</section>

<section class="section section-alt">
    <div class="container">
        <div class="section-head">
            <span class="section-kicker">// my journey</span>
            <h2 class="section-title">Overview Timeline</h2>
            <p class="section-sub">Education, organization &amp; work — at a glance.</p>
        </div>

        <div class="timeline-legend">
            <span class="legend-item"><span class="swatch edu"></span> Education</span>
            <span class="legend-item"><span class="swatch work"></span> Work</span>
            <span class="legend-item"><span class="swatch org"></span> Organization</span>
        </div>

        {%- assign tl = site.data.timeline -%}
        {%- assign span_years = tl.axis_end | minus: tl.axis_start -%}
        {%- assign total_months = span_years | times: 12 -%}
        {%- assign last_year = tl.axis_end | minus: 1 -%}
        {%- assign col_w = 100.0 | divided_by: span_years -%}
        <div class="gantt-scroll">
            <div class="gantt">
                <div class="gantt-header">
                    {%- for y in (tl.axis_start..last_year) -%}
                    {%- assign yleft = y | minus: tl.axis_start | times: col_w -%}
                    <span class="gantt-year" style="left:{{ yleft | round: 4 }}%">{{ y }}</span>
                    {%- endfor -%}
                </div>

                <div class="gantt-body" style="background-size:{{ col_w | round: 4 }}% 100%">
                    {%- assign items = tl.items | sort: "start" -%}
                    {%- for item in items -%}
                        {%- assign sy = item.start | date: "%Y" | plus: 0 -%}
                        {%- assign sm = item.start | date: "%m" | plus: 0 -%}
                        {%- assign start_mo = sy | minus: tl.axis_start | times: 12 | plus: sm | minus: 1 -%}
                        {%- if item.end -%}{%- assign endval = item.end -%}{%- else -%}{%- assign endval = site.time -%}{%- endif -%}
                        {%- assign ey = endval | date: "%Y" | plus: 0 -%}
                        {%- assign em = endval | date: "%m" | plus: 0 -%}
                        {%- assign end_mo = ey | minus: tl.axis_start | times: 12 | plus: em | minus: 1 -%}
                        {%- assign left = start_mo | times: 100.0 | divided_by: total_months -%}
                        {%- assign width = end_mo | minus: start_mo | times: 100.0 | divided_by: total_months -%}
                        {%- assign bar_right = left | plus: width -%}
                        {%- assign right_off = 100 | minus: bar_right -%}
                        {%- capture range -%}{{ item.start | date: "%b %Y" }} – {% if item.end %}{{ item.end | date: "%b %Y" }}{% else %}Present{% endif %}{%- endcapture -%}
                    <div class="gantt-row is-{{ item.category }}{% if item.current %} is-current{% endif %}">
                        <div class="gantt-track"><span class="gantt-bar" style="left:{{ left | round: 3 }}%;width:{{ width | round: 3 }}%" title="{{ range }}"></span></div>
                        {%- if left >= 50 -%}
                        <div class="gantt-label right" style="margin-right:{{ right_off | round: 3 }}%">
                        {%- else -%}
                        <div class="gantt-label" style="margin-left:{{ left | round: 3 }}%">
                        {%- endif -%}
                            <span class="role">{{ item.role }}</span>
                            <span class="org">{% if item.link %}<a href="{{ item.link }}" target="_blank" rel="noopener">{{ item.org }}</a>{% else %}{{ item.org }}{% endif %}{% if item.lab %} · {% if item.lab_link %}<a href="{{ item.lab_link }}" target="_blank" rel="noopener">{{ item.lab }}</a>{% else %}{{ item.lab }}{% endif %}{% endif %}{% if item.current %} · current{% endif %}</span>
                            {%- if item.cert %}<a class="tl-cert" href="{{ item.cert }}" target="_blank" rel="noopener">📄 {{ item.cert_label | default: "Certificate" }}</a>{% endif %}
                        </div>
                    </div>
                    {%- endfor -%}
                </div>
            </div>
        </div>
    </div>
</section>

<section class="section">
    <div class="container">
        <div class="section-head">
            <span class="section-kicker">// selected work</span>
            <h2 class="section-title">Featured Projects</h2>
            <p class="section-sub">A few projects I'm proud of. Browse the full archive for more.</p>
        </div>
        <div class="projects-grid">
            {% assign featured_projects = site.projects | where: "featured", true | limit: 3 %}
            {% if featured_projects.size == 0 %}
                {% assign featured_projects = site.projects | sort: "date" | reverse | limit: 3 %}
            {% endif %}
            {% for project in featured_projects %}
            <div class="project-card">
                {% if project.cover_image %}
                <div class="project-card-image">
                    <a href="{{ project.url | relative_url }}">
                        <img src="{{ project.cover_image | relative_url }}" alt="{{ project.title }}" loading="lazy">
                    </a>
                </div>
                {% endif %}
                <div class="project-card-content">
                    <h3><a href="{{ project.url | relative_url }}">{{ project.title }}</a></h3>
                    <p class="project-description">{{ project.description | truncate: 110 }}</p>
                    {% if project.tags %}
                    <div class="project-tags">
                        {% for tag in project.tags limit: 3 %}
                        <span class="tag">{{ tag }}</span>
                        {% endfor %}
                    </div>
                    {% endif %}
                    <div class="project-card-footer">
                        <a href="{{ project.url | relative_url }}" class="card-link">View Project &rarr;</a>
                    </div>
                </div>
            </div>
            {% endfor %}
        </div>
        <div class="text-center mt-2">
            <a href="{{ '/projects/' | relative_url }}" class="btn btn-secondary">View All Projects</a>
        </div>
    </div>
</section>

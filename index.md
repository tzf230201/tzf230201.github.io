---
layout: default
title: Home
---

<div class="hero">
    <div class="container">
        <div class="hero-content">
            <h1 class="hero-title">Hello, I'm <span class="highlight">Your Name</span></h1>
            <p class="hero-subtitle">Developer | Designer | Problem Solver</p>
            <p class="hero-description">
                Welcome to my personal website. I build things for the web and love creating elegant solutions to complex problems.
            </p>
            <div class="hero-actions">
                <a href="{{ '/projects/' | relative_url }}" class="btn btn-primary">View My Projects</a>
                <a href="{{ '/contact/' | relative_url }}" class="btn btn-secondary">Get in Touch</a>
            </div>
        </div>
    </div>
</div>

<section class="section">
    <div class="container">
        <h2 class="section-title">About Me</h2>
        <div class="about-content">
            <p>
                I'm a passionate developer with experience in building web applications and creating beautiful user experiences. 
                This section will showcase my skills, background, and what I'm currently working on.
            </p>
            <p>
                <strong>Note:</strong> Content will be added later. This is the template structure.
            </p>
        </div>
    </div>
</section>

<section class="section section-alt">
    <div class="container">
        <h2 class="section-title">Featured Projects</h2>
        <div class="projects-grid">
            {% assign featured_projects = site.projects | where: "featured", true | limit: 3 %}
            {% if featured_projects.size > 0 %}
                {% for project in featured_projects %}
                <div class="project-card">
                    {% if project.cover_image %}
                    <div class="project-card-image">
                        <img src="{{ project.cover_image | relative_url }}" alt="{{ project.title }}">
                    </div>
                    {% endif %}
                    <div class="project-card-content">
                        <h3>{{ project.title }}</h3>
                        <p>{{ project.description }}</p>
                        {% if project.tags %}
                        <div class="project-tags">
                            {% for tag in project.tags limit: 3 %}
                            <span class="tag">{{ tag }}</span>
                            {% endfor %}
                        </div>
                        {% endif %}
                        <a href="{{ project.url | relative_url }}" class="btn btn-small">View Project →</a>
                    </div>
                </div>
                {% endfor %}
            {% else %}
                <p class="text-center">No featured projects yet. Add some projects to the <code>_projects/</code> folder!</p>
            {% endif %}
        </div>
        <div class="text-center" style="margin-top: 2rem;">
            <a href="{{ '/projects/' | relative_url }}" class="btn btn-secondary">View All Projects</a>
        </div>
    </div>
</section>

---
layout: page
title: Projects
subtitle: A collection of my work and side projects
permalink: /projects/
---

<div class="projects-filter">
    <p class="filter-label">Filter by:</p>
    <div class="filter-tags">
        <button class="filter-tag active" data-filter="all">All</button>
        <!-- Add more filter tags based on your project tags -->
        <button class="filter-tag" data-filter="web">Web</button>
        <button class="filter-tag" data-filter="mobile">Mobile</button>
        <button class="filter-tag" data-filter="ai">AI/ML</button>
    </div>
</div>

<div class="projects-grid">
    {% if site.projects.size > 0 %}
        {% for project in site.projects %}
        <div class="project-card" data-tags="{{ project.tags | join: ',' | downcase }}">
            {% if project.cover_image %}
            <div class="project-card-image">
                <a href="{{ project.url | relative_url }}">
                    <img src="{{ project.cover_image | relative_url }}" alt="{{ project.title }}">
                </a>
            </div>
            {% endif %}
            
            <div class="project-card-content">
                <h3>
                    <a href="{{ project.url | relative_url }}">{{ project.title }}</a>
                </h3>
                
                {% if project.description %}
                <p class="project-description">{{ project.description }}</p>
                {% endif %}
                
                {% if project.tags %}
                <div class="project-tags">
                    {% for tag in project.tags %}
                    <span class="tag">{{ tag }}</span>
                    {% endfor %}
                </div>
                {% endif %}
                
                <div class="project-card-footer">
                    <a href="{{ project.url | relative_url }}" class="btn btn-small">View Details →</a>
                </div>
            </div>
        </div>
        {% endfor %}
    {% else %}
        <div class="empty-state">
            <p>No projects yet. Create your first project by adding a Markdown file to the <code>_projects/</code> folder!</p>
            <p class="text-muted">Example: <code>_projects/my-awesome-project.md</code></p>
        </div>
    {% endif %}
</div>

<script>
// Simple filter functionality
document.addEventListener('DOMContentLoaded', function() {
    const filterTags = document.querySelectorAll('.filter-tag');
    const projectCards = document.querySelectorAll('.project-card');
    
    filterTags.forEach(tag => {
        tag.addEventListener('click', function() {
            const filter = this.getAttribute('data-filter');
            
            // Update active state
            filterTags.forEach(t => t.classList.remove('active'));
            this.classList.add('active');
            
            // Filter projects
            projectCards.forEach(card => {
                const tags = card.getAttribute('data-tags');
                if (filter === 'all' || tags.includes(filter)) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        });
    });
});
</script>

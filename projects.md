---
layout: page
title: Projects
subtitle: A collection of robotics, embedded & engineering work
permalink: /projects/
---

{% comment %} Build a unique, sorted list of tags across all projects {% endcomment %}
{% capture tags_str %}{% for project in site.projects %}{% for tag in project.tags %}{{ tag }},{% endfor %}{% endfor %}{% endcapture %}
{% assign all_tags = tags_str | split: "," | uniq | sort_natural %}

<div class="projects-filter">
    <button class="filter-tag active" data-filter="all">All</button>
    {% for tag in all_tags %}
    <button class="filter-tag" data-filter="{{ tag | downcase }}">{{ tag }}</button>
    {% endfor %}
</div>

<div class="projects-grid">
    {% if site.projects.size > 0 %}
        {% assign sorted_projects = site.projects | sort: "date" | reverse %}
        {% for project in sorted_projects %}
        <div class="project-card" data-tags="{{ project.tags | join: ',' | downcase }}">
            {% if project.featured %}<span class="featured-badge">★ Featured</span>{% endif %}
            {% if project.cover_image %}
            <div class="project-card-image">
                <a href="{{ project.url | relative_url }}">
                    <img src="{{ project.cover_image | relative_url }}" alt="{{ project.title }}" loading="lazy">
                </a>
            </div>
            {% endif %}

            <div class="project-card-content">
                <h3><a href="{{ project.url | relative_url }}">{{ project.title }}</a></h3>

                {% if project.description %}
                <p class="project-description">{{ project.description | truncate: 120 }}</p>
                {% endif %}

                {% if project.tags %}
                <div class="project-tags">
                    {% for tag in project.tags limit: 4 %}
                    <span class="tag">{{ tag }}</span>
                    {% endfor %}
                </div>
                {% endif %}

                <div class="project-card-footer">
                    <a href="{{ project.url | relative_url }}" class="card-link">View Details &rarr;</a>
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
document.addEventListener('DOMContentLoaded', function () {
    var filterTags = document.querySelectorAll('.filter-tag');
    var projectCards = document.querySelectorAll('.project-card');

    filterTags.forEach(function (tag) {
        tag.addEventListener('click', function () {
            var filter = this.getAttribute('data-filter');
            filterTags.forEach(function (t) { t.classList.remove('active'); });
            this.classList.add('active');

            projectCards.forEach(function (card) {
                var tags = card.getAttribute('data-tags') || '';
                var show = filter === 'all' || tags.split(',').indexOf(filter) !== -1;
                card.style.display = show ? 'flex' : 'none';
            });
        });
    });
});
</script>

---
layout: page
title: Projects
subtitle: A collection of robotics, embedded & engineering work
permalink: /projects/
content_class: page-wide
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

<div class="gh-section">
    <div class="section-head">
        <span class="section-kicker">// open source</span>
        <h2 class="section-title">From GitHub</h2>
        <p class="section-sub">Live from <a href="https://github.com/tzf230201" target="_blank" rel="noopener">@tzf230201</a> — auto-updated, sorted by stars.</p>
    </div>
    <div id="gh-repos" class="repo-grid">
        <p class="repo-status">Loading repositories…</p>
    </div>
    <div class="text-center mt-2">
        <a class="btn btn-secondary" href="https://github.com/tzf230201?tab=repositories" target="_blank" rel="noopener">View all on GitHub →</a>
    </div>
</div>

<script>
(function () {
    var grid = document.getElementById('gh-repos');
    if (!grid) return;

    var USER = 'tzf230201';
    var EXCLUDE = ['tzf230201.github.io'];      // repos to hide
    var SHOW_FORKS = false;
    var LANG_COLORS = {
        Python: '#3572A5', 'C++': '#f34b7d', C: '#555555', 'C#': '#178600',
        VHDL: '#adb2cb', 'F#': '#b845fc', CSS: '#563d7c', CMake: '#DA3434',
        JavaScript: '#f1e05a', TypeScript: '#3178c6', HTML: '#e34c26',
        Shell: '#89e051', Java: '#b07219', Go: '#00ADD8', Verilog: '#b2b7f8'
    };

    function esc(s) { var d = document.createElement('div'); d.textContent = s == null ? '' : s; return d.innerHTML; }

    fetch('https://api.github.com/users/' + USER + '/repos?per_page=100&sort=updated')
        .then(function (res) { if (!res.ok) throw new Error(res.status); return res.json(); })
        .then(function (repos) {
            repos = repos.filter(function (r) {
                return (SHOW_FORKS || !r.fork) && !r.archived && EXCLUDE.indexOf(r.name) === -1;
            });
            repos.sort(function (a, b) {
                return (b.stargazers_count - a.stargazers_count) ||
                       (new Date(b.pushed_at) - new Date(a.pushed_at));
            });
            if (!repos.length) {
                grid.innerHTML = '<p class="repo-status">No public repositories found.</p>';
                return;
            }
            grid.innerHTML = repos.map(function (r) {
                var lang = r.language
                    ? '<span class="lang"><span class="lang-dot" style="background:' +
                      (LANG_COLORS[r.language] || '#8b8aa3') + '"></span>' + esc(r.language) + '</span>'
                    : '';
                var topics = (r.topics || []).slice(0, 4).map(function (t) {
                    return '<span class="tag">' + esc(t) + '</span>';
                }).join('');
                var stars = r.stargazers_count ? '<span class="stat">★ ' + r.stargazers_count + '</span>' : '';
                var forks = r.forks_count ? '<span class="stat">⑂ ' + r.forks_count + '</span>' : '';
                return '<div class="repo-card">' +
                    '<h3><svg width="16" height="16" fill="currentColor" viewBox="0 0 16 16"><path d="M2 2.5A2.5 2.5 0 0 1 4.5 0h8.75a.75.75 0 0 1 .75.75v12.5a.75.75 0 0 1-.75.75h-2.5a.75.75 0 0 1 0-1.5h1.75v-2h-8a1 1 0 0 0-.714 1.7.75.75 0 1 1-1.072 1.05A2.495 2.495 0 0 1 2 11.5zm10.5-1h-8a1 1 0 0 0-1 1v6.708A2.486 2.486 0 0 1 4.5 9h8zM5 12.25a.25.25 0 0 1 .25-.25h3.5a.25.25 0 0 1 .25.25v3.25a.25.25 0 0 1-.4.2l-1.45-1.087a.25.25 0 0 0-.3 0L5.4 15.7a.25.25 0 0 1-.4-.2z"/></svg>' +
                    '<a href="' + r.html_url + '" target="_blank" rel="noopener">' + esc(r.name) + '</a></h3>' +
                    '<p class="repo-desc">' + (r.description ? esc(r.description) : '<em>No description provided.</em>') + '</p>' +
                    (topics ? '<div class="repo-topics">' + topics + '</div>' : '') +
                    '<div class="repo-meta">' + lang + stars + forks + '</div>' +
                    '</div>';
            }).join('');
        })
        .catch(function () {
            grid.innerHTML = '<p class="repo-status">Couldn\'t load repositories right now (GitHub rate limit?). ' +
                '<a href="https://github.com/' + USER + '?tab=repositories" target="_blank" rel="noopener">View them on GitHub →</a></p>';
        });
})();
</script>

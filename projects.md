---
layout: page
title: Projects
subtitle: A collection of robotics, embedded & engineering work
permalink: /projects/
content_class: page-wide
---

{% comment %} Build a unique, sorted list of tags across all projects {% endcomment %}
{% capture tags_str %}{% for project in site.projects %}{% for tag in project.tags %}{{ tag }},{% endfor %}{% endfor %}{% for model in site.data.grabcad %}{% for tag in model.tags %}{{ tag }},{% endfor %}{% endfor %}{% endcapture %}
{% assign all_tags = tags_str | split: "," | uniq | sort_natural %}

<div class="projects-toolbar" id="projects-toolbar" hidden>
    <div class="projects-filter" role="group" aria-label="Filter projects by topic">
        <span class="filter-label">Filter by topic</span>
        <div class="filter-primary">
            <button type="button" class="filter-tag active" data-filter="all" aria-pressed="true">All</button>
        </div>
        <button type="button" class="filter-more-toggle" aria-expanded="false" aria-controls="filter-panel">More topics <span class="filter-more-count"></span></button>
        <div class="filter-panel" id="filter-panel" hidden>
            {% for tag in all_tags %}
            <button type="button" class="filter-tag" data-filter="{{ tag | downcase }}">{{ tag }}</button>
            {% endfor %}
        </div>
    </div>
    <p class="filter-status" aria-live="polite"></p>
</div>

<div class="gh-section">
    <div class="section-head">
        <span class="section-kicker">GitHub</span>
        <h2 class="section-title">Open Source</h2>
    </div>
    <div id="gh-repos" class="project-image-grid">
        <p class="repo-status">Loading repositories…</p>
    </div>
    <p class="grid-empty" data-empty-for="gh-repos" hidden>No open-source repositories match this topic.</p>
    <div class="text-center mt-2">
        <a class="btn btn-secondary" href="https://github.com/tzf230201?tab=repositories" target="_blank" rel="noopener">View all on GitHub →</a>
    </div>
</div>

{% if site.data.grabcad.size > 0 %}
<section aria-labelledby="cad-models-title">
    <div class="section-head section-head--spaced">
        <span class="section-kicker">GrabCAD</span>
        <h2 class="section-title" id="cad-models-title">CAD Models</h2>
        <p class="section-sub">Mechanical designs, sensor mounts, and hardware for robotics.</p>
    </div>
    <div class="project-image-grid" id="cad-models">
        {% for model in site.data.grabcad %}
        <a class="project-tile" href="{{ model.url | escape }}" target="_blank" rel="noopener noreferrer" data-tags="{{ model.tags | join: ',' | downcase | escape }}" aria-labelledby="cad-title-{{ forloop.index }}"{% if model.description %} aria-describedby="cad-description-{{ forloop.index }}"{% endif %}>
            <div class="project-tile-image"{% unless model.image %} hidden{% endunless %}>
                {% if model.image %}<img src="{{ model.image | relative_url | escape }}" alt="" loading="lazy" decoding="async">{% endif %}
            </div>
            <div class="project-tile-content">
                <h3 id="cad-title-{{ forloop.index }}">{{ model.title | escape }}</h3>
                <div class="project-tile-details">
                    <div>
                        {% if model.description %}<p id="cad-description-{{ forloop.index }}">{{ model.description | escape }}</p>{% endif %}
                        <span class="project-tile-cta">View on GrabCAD <span aria-hidden="true">&nearr;</span></span>
                    </div>
                </div>
            </div>
        </a>
        {% endfor %}
    </div>
    <p class="grid-empty" data-empty-for="cad-models" hidden>No CAD models match this topic.</p>
    <div class="text-center mt-2">
        <a class="btn btn-secondary" href="https://grabcad.com/teuku.zikri.fatahillah-3/models" target="_blank" rel="noopener noreferrer">View all on GrabCAD &rarr;</a>
    </div>
</section>
{% endif %}

<div class="section-head section-head--spaced">
    <span class="section-kicker">Case studies</span>
    <h2 class="section-title">Closed Source</h2>
    <p class="section-sub">In-depth write-ups of selected engineering work.</p>
</div>

<div class="project-image-grid" id="case-studies">
    {% if site.projects.size > 0 %}
        {% assign sorted_projects = site.projects | sort: "date" | reverse %}
        {% for project in sorted_projects %}
        <a class="project-tile" href="{{ project.url | relative_url }}" data-tags="{{ project.tags | join: ',' | downcase | escape }}" aria-labelledby="case-title-{{ forloop.index }}"{% if project.description %} aria-describedby="case-description-{{ forloop.index }}"{% endif %}>
            <div class="project-tile-image"{% unless project.cover_image %} hidden{% endunless %}>
                {% if project.cover_image %}<img src="{{ project.cover_image | relative_url }}" alt="" loading="lazy" decoding="async">{% endif %}
            </div>
            <div class="project-tile-content">
                <h3 id="case-title-{{ forloop.index }}">{{ project.title }}</h3>
                <div class="project-tile-details">
                    <div>
                        {% if project.description %}<p id="case-description-{{ forloop.index }}">{{ project.description | escape }}</p>{% endif %}
                        <span class="project-tile-cta">View case study <span aria-hidden="true">&rarr;</span></span>
                    </div>
                </div>
            </div>
        </a>
        {% endfor %}
    {% else %}
        <div class="empty-state">
            <p>No projects yet. Create your first project by adding a Markdown file to the <code>_projects/</code> folder!</p>
            <p class="text-muted">Example: <code>_projects/my-awesome-project.md</code></p>
        </div>
    {% endif %}
</div>
<p class="grid-empty" data-empty-for="case-studies" hidden>No case studies match this topic.</p>

<script>
/* Topic filter. Counts every tag across case studies, CAD models, and GitHub cards (Jekyll tags and
   GitHub topics are merged: "Computer Vision" == "computer-vision"), shows the most-used topics
   inline and tucks the long tail into a "More topics" panel. Rebuilt when the GitHub cards arrive. */
(function () {
    var toolbar = document.getElementById('projects-toolbar');
    var bar = toolbar && toolbar.querySelector('.projects-filter');
    if (!bar) return;
    var primary = bar.querySelector('.filter-primary');
    var panel = bar.querySelector('.filter-panel');
    var moreBtn = bar.querySelector('.filter-more-toggle');
    var moreCount = bar.querySelector('.filter-more-count');
    var status = toolbar.querySelector('.filter-status');
    var narrow = window.matchMedia('(max-width: 640px)');
    function primaryMax() { return narrow.matches ? 5 : 12; } // phones: one short row, the rest in "More topics"
    var active = 'all';
    var labels = {};

    // GitHub topics that mean the same as another tag, and display names for GitHub-only topics
    var ALIAS = {
        'embedded-systems': 'embedded-system', ros2: 'ros', 'robotic-arm': 'arm-robot', 'robot-arm': 'arm-robot', moveit2: 'moveit',
        'stm32f746g-discovery': '32f746g-discovery', 'playback-audio': 'audio-playback', 'record-audio': 'audio-recording'
    };
    var NICE = {
        ai: 'AI', iot: 'IoT', bsp: 'BSP', cad: 'CAD', lidar: 'LiDAR', slam: 'SLAM', realsense: 'RealSense',
        kicad: 'KiCad', canopen: 'CANopen', opencv: 'OpenCV', moveit: 'MoveIt',
        'arm-robot': 'Robot Arm', '32f746g-discovery': '32F746G Discovery', stm32cubeide: 'STM32CubeIDE', stm32f7: 'STM32F7',
        'esp8266-projects': 'ESP8266', 'tang-nano-9k': 'Tang Nano 9K', 'mediapipe-hands': 'MediaPipe Hands',
        'wav-file': 'WAV File', 'wav-player': 'WAV Player', 'wav-recorder': 'WAV Recorder'
    };
    function norm(t) {
        var k = String(t || '').toLowerCase().trim().replace(/[\s_]+/g, '-');
        return ALIAS[k] || k;
    }
    function nice(k) {
        return NICE[k] || k.replace(/-/g, ' ').replace(/\b[a-z]/g, function (c) { return c.toUpperCase(); });
    }
    function cards() { return [].slice.call(document.querySelectorAll('.project-tile')); }
    function tagsOf(card) { return (card.getAttribute('data-tags') || '').split(',').map(norm).filter(Boolean); }
    function byLabel(a, b) { return labels[a].localeCompare(labels[b], undefined, { sensitivity: 'base' }); }

    // Keep the original capitalisation of the Jekyll tags for display
    [].forEach.call(panel.querySelectorAll('.filter-tag'), function (b) {
        labels[norm(b.getAttribute('data-filter'))] = b.textContent.trim();
    });

    function makeButton(key, label, count) {
        var b = document.createElement('button');
        b.type = 'button';
        b.className = 'filter-tag';
        b.setAttribute('data-filter', key);
        b.appendChild(document.createTextNode(label));
        if (count != null) {
            var c = document.createElement('span');
            c.className = 'filter-count';
            c.textContent = count;
            b.appendChild(c);
        }
        return b;
    }

    function apply() {
        var all = cards(), shown = 0;
        all.forEach(function (card) {
            var show = active === 'all' || tagsOf(card).indexOf(active) !== -1;
            card.style.display = show ? '' : 'none';
            if (show) shown++;
        });
        [].forEach.call(bar.querySelectorAll('.filter-tag'), function (b) {
            var on = b.getAttribute('data-filter') === active;
            b.classList.toggle('active', on);
            b.setAttribute('aria-pressed', on ? 'true' : 'false');
        });
        [].forEach.call(document.querySelectorAll('[data-empty-for]'), function (note) {
            var grid = document.getElementById(note.getAttribute('data-empty-for'));
            var any = !grid || [].some.call(grid.querySelectorAll('.project-tile'), function (c) { return c.style.display !== 'none'; });
            note.hidden = active === 'all' || any;
        });
        status.textContent = '';
        if (active === 'all') {
            status.textContent = 'Showing all ' + all.length + ' projects';
        } else {
            status.appendChild(document.createTextNode('Showing ' + shown + ' of ' + all.length + ' projects tagged '));
            var name = document.createElement('strong');
            name.textContent = labels[active] || active;
            status.appendChild(name);
            status.appendChild(document.createTextNode(' · '));
            var clear = document.createElement('button');
            clear.type = 'button';
            clear.className = 'filter-clear';
            clear.setAttribute('data-filter', 'all');
            clear.textContent = 'Clear filter';
            status.appendChild(clear);
        }
    }

    function build() {
        var counts = {};
        cards().forEach(function (card) {
            var seen = {};
            tagsOf(card).forEach(function (k) {
                if (seen[k]) return;
                seen[k] = true;
                counts[k] = (counts[k] || 0) + 1;
                if (!labels[k]) labels[k] = nice(k);
            });
        });
        var keys = Object.keys(counts);
        var top = keys.filter(function (k) { return counts[k] > 1; })
            .sort(function (a, b) { return (counts[b] - counts[a]) || byLabel(a, b); })
            .slice(0, primaryMax());
        var inTop = {};
        top.forEach(function (k) { inTop[k] = true; });
        var rest = keys.filter(function (k) { return !inTop[k]; }).sort(byLabel);

        primary.textContent = '';
        primary.appendChild(makeButton('all', 'All', null));
        top.forEach(function (k) { primary.appendChild(makeButton(k, labels[k], counts[k])); });
        panel.textContent = '';
        rest.forEach(function (k) { panel.appendChild(makeButton(k, labels[k], counts[k])); });
        moreCount.textContent = rest.length;
        moreBtn.hidden = !rest.length;
        if (!rest.length) { panel.hidden = true; moreBtn.setAttribute('aria-expanded', 'false'); }
        if (active !== 'all' && !counts[active]) active = 'all';
        apply();
    }

    toolbar.addEventListener('click', function (e) {
        var pick = e.target.closest('[data-filter]');
        if (pick && toolbar.contains(pick)) {
            var fromClear = pick.classList.contains('filter-clear');
            active = pick.getAttribute('data-filter');
            apply();
            // "Clear filter" is rebuilt by apply(); keep keyboard focus in the toolbar
            if (fromClear) primary.querySelector('[data-filter="all"]').focus();
            return;
        }
        if (e.target.closest('.filter-more-toggle')) {
            var open = moreBtn.getAttribute('aria-expanded') !== 'true';
            moreBtn.setAttribute('aria-expanded', open ? 'true' : 'false');
            panel.hidden = !open;
        }
    });

    // GitHub cards load asynchronously; their topics join the filter when they arrive
    document.addEventListener('projects:updated', build);
    if (narrow.addEventListener) narrow.addEventListener('change', build);
    toolbar.hidden = false;
    build();
})();
</script>

{% include github-thumbnails.html %}
<script>
(function () {
    var grid = document.getElementById('gh-repos');
    if (!grid) return;

    var USER = 'tzf230201';
    var PINNED = {};                            // repos pinned on GitHub -> featured here
    var EXCLUDE = ['tzf230201.github.io'];      // repos to hide
    var SHOW_FORKS = false;

    function esc(s) { var d = document.createElement('div'); d.textContent = s == null ? '' : s; return d.innerHTML; }

    function isPinned(r) { return !!PINNED[(r.name || '').toLowerCase()]; }

    function loadRepos() {
    fetch('https://api.github.com/users/' + USER + '/repos?per_page=100&sort=updated', { cache: 'no-cache' })
        .then(function (res) { if (!res.ok) throw new Error(res.status); return res.json(); })
        .then(function (repos) {
            repos = repos.filter(function (r) {
                return (SHOW_FORKS || !r.fork) && !r.archived && EXCLUDE.indexOf(r.name) === -1;
            });
            repos.sort(function (a, b) {
                return (isPinned(b) - isPinned(a)) ||
                       (b.stargazers_count - a.stargazers_count) ||
                       (new Date(b.pushed_at) - new Date(a.pushed_at));
            });
            if (!repos.length) {
                grid.innerHTML = '<p class="repo-status">No public repositories found.</p>';
                return;
            }
            grid.innerHTML = repos.map(function (r, i) {
                var titleId = 'repo-title-' + i;
                var descriptionId = 'repo-description-' + i;
                return '<a class="project-tile project-tile--repo" href="' + esc(r.html_url) + '" target="_blank" rel="noopener noreferrer" data-name="' + esc(r.name) + '" data-branch="' + esc(r.default_branch || 'main') + '" data-tags="' + esc((r.topics || []).join(',').toLowerCase()) + '" aria-labelledby="' + titleId + '"' + (r.description ? ' aria-describedby="' + descriptionId + '"' : '') + '>' +
                    '<div class="project-tile-image" hidden><img alt="" decoding="async"></div>' +
                    '<div class="project-tile-content">' +
                        '<h3 id="' + titleId + '">' + esc(r.name).replace(/[_-]/g, '$&<wbr>') + '</h3>' +
                        '<div class="project-tile-details"><div>' +
                            (r.description ? '<p id="' + descriptionId + '">' + esc(r.description) + '</p>' : '') +
                            '<span class="project-tile-cta">View on GitHub <span aria-hidden="true">&nearr;</span></span>' +
                        '</div></div>' +
                    '</div></a>';
            }).join('');

            // Let the topic filter pick up the GitHub topics
            document.dispatchEvent(new CustomEvent('projects:updated'));

            // Follow the first README image, using the repo's update time to refresh cached files.
            var cards = grid.querySelectorAll('.project-tile');
            repos.forEach(function (r, i) {
                var card = cards[i];
                if (!card) return;
                var branch = r.default_branch || 'main';
                var revision = r.pushed_at || r.updated_at || '';
                PortfolioGitHub.readme(USER, r.name, branch, revision)
                    .then(function (md) {
                        if (!md) return;
                        var url = PortfolioGitHub.firstImage(md, USER, r.name, branch, revision);
                        if (!url) return;
                        var box = card.querySelector('.project-tile-image');
                        var img = box && box.querySelector('img');
                        if (!img) return;
                        PortfolioGitHub.loadImage(img, url,
                            function () { box.hidden = false; },
                            function () { box.hidden = true; });
                    })
                    .catch(function () {});
            });
        })
        .catch(function () {
            grid.innerHTML = '<p class="repo-status">Couldn\'t load repositories right now (GitHub rate limit?). ' +
                '<a href="https://github.com/' + USER + '?tab=repositories" target="_blank" rel="noopener">View them on GitHub →</a></p>';
        });
    }

    // Featured = repos you've pinned on GitHub (community API); falls back gracefully, then loads all repos
    fetch('https://pinned.berrysauce.dev/get/' + USER + '?_=' + Date.now(), { cache: 'no-store' })
        .then(function (r) { return r.ok ? r.json() : []; })
        .then(function (pins) { (pins || []).forEach(function (p) { PINNED[(p.name || '').toLowerCase()] = true; }); })
        .catch(function () {})
        .then(loadRepos);
})();
</script>

<script>
/* Touch: preview on the first tap, follow the card link on the next tap.
   Mouse clicks, keyboard activation, and modified clicks keep normal link behavior. */
(function () {
    var touchScreen = window.matchMedia('(hover: none)');
    function clear(except) {
        [].forEach.call(document.querySelectorAll('.project-tile.is-revealed'), function (card) {
            if (card !== except) card.classList.remove('is-revealed');
        });
    }
    document.addEventListener('click', function (e) {
        var card = e.target.closest('.project-tile');
        clear(card);
        if (!card || e.defaultPrevented || e.button !== 0 || e.metaKey || e.ctrlKey || e.shiftKey || e.altKey) return;
        var touch = e.pointerType === 'touch' || (!e.pointerType && touchScreen.matches && e.detail > 0);
        if (touch && !card.classList.contains('is-revealed')) {
            e.preventDefault();
            card.classList.add('is-revealed');
        }
    });
    document.addEventListener('keydown', function (e) {
        if (e.key === 'Escape') clear();
    });
    document.addEventListener('projects:updated', function () { clear(); });
})();
</script>

<div class="robot-game" id="robot-game">
    <div class="section-head">
        <span class="section-kicker">Coffee break</span>
        <h2 class="section-title">Drive a Robot with /cmd_vel</h2>
        <p class="section-sub">A tiny teleop. Drive the turtle like turtlesim, and every key press publishes a <code>geometry_msgs/Twist</code> to <code>/cmd_vel</code>. Dodge the TurtleBot3-style pillars and reach the goals before the 60&nbsp;s timer runs out.</p>
    </div>
    <div class="game-card">
        <canvas id="cmdvel-canvas" width="920" height="440" class="game-canvas" tabindex="0" aria-label="cmd_vel teleop game"></canvas>
        <div class="game-overlay" id="cmdvel-overlay">
            <div>
                <div class="game-emoji">🐢</div>
                <p class="game-msg" id="cmdvel-msg">Drive with <kbd>↑</kbd><kbd>↓</kbd><kbd>←</kbd><kbd>→</kbd> or <kbd>W</kbd><kbd>A</kbd><kbd>S</kbd><kbd>D</kbd><br>Reach the goals. Click or tap to start.</p>
                <p class="game-best" id="cmdvel-best"></p>
            </div>
        </div>
    </div>
    <p class="game-hint">↑/↓ → linear.x · ←/→ → angular.z · just like <code>teleop_twist_keyboard</code></p>
</div>

<script>
(function () {
    var canvas = document.getElementById('cmdvel-canvas');
    if (!canvas || !canvas.getContext) return;
    var ctx = canvas.getContext('2d');
    var W = canvas.width, H = canvas.height, M = 26;

    var overlay = document.getElementById('cmdvel-overlay');
    var msg = document.getElementById('cmdvel-msg');
    var bestEl = document.getElementById('cmdvel-best');
    var BEST_KEY = 'cmdVelBest';
    var best = parseInt(localStorage.getItem(BEST_KEY) || '0', 10);

    var MAXV = 3.3, MAXW = 0.052, GAME_TIME = 60, TR = 13;
    var calm = window.matchMedia('(prefers-reduced-motion: reduce)'); // no pulsing goal ring
    var state = 'ready';
    var bot, goal, vel, score, timeLeft, trail, wallMsg;
    // TurtleBot3-world-style cylindrical pillars (walls to dodge)
    var obstacles = [
        { x: W * 0.42, y: H * 0.30, r: 24 },
        { x: W * 0.42, y: H * 0.70, r: 24 },
        { x: W * 0.60, y: H * 0.50, r: 30 },
        { x: W * 0.78, y: H * 0.30, r: 22 },
        { x: W * 0.78, y: H * 0.70, r: 22 }
    ];

    function css(v, f) { return (getComputedStyle(document.documentElement).getPropertyValue(v).trim()) || (f || '#888'); }
    function rand(a, b) { return a + Math.random() * (b - a); }

    function newGoal() {
        for (var k = 0; k < 60; k++) {
            var gx = rand(M + 40, W - M - 40), gy = rand(M + 40, H - M - 40), ok = true;
            for (var i = 0; i < obstacles.length; i++) {
                var o = obstacles[i], dx = gx - o.x, dy = gy - o.y;
                if (Math.sqrt(dx * dx + dy * dy) < o.r + 36) { ok = false; break; }
            }
            if (ok) { goal = { x: gx, y: gy, r: 17 }; return; }
        }
        goal = { x: rand(M + 40, W - M - 40), y: rand(M + 40, H - M - 40), r: 17 };
    }

    function reset() {
        bot = { x: W * 0.16, y: H * 0.5, th: 0 };
        vel = { v: 0, w: 0 };
        score = 0; timeLeft = GAME_TIME; trail = []; wallMsg = 0;
        newGoal();
    }
    function start() { reset(); state = 'running'; overlay.classList.add('hidden'); }
    function over() {
        state = 'over';
        if (score > best) { best = score; localStorage.setItem(BEST_KEY, best); }
        msg.innerHTML = 'Time! You reached <b>' + score + '</b> goal' + (score === 1 ? '' : 's') + '.<br>Press a key or tap to try again.';
        bestEl.textContent = 'Best: ' + best;
        overlay.classList.remove('hidden');
    }

    var keys = {};
    var DRIVE = { ArrowUp: 1, ArrowDown: 1, ArrowLeft: 1, ArrowRight: 1, KeyW: 1, KeyS: 1, KeyA: 1, KeyD: 1 };
    var visible = false;
    // The arrow keys only drive the turtle once the visitor has engaged with the game (click, tap or
    // keyboard focus), so scrolling past it with the keyboard keeps working
    var armed = false;
    if ('IntersectionObserver' in window) {
        new IntersectionObserver(function (es) {
            es.forEach(function (e) { visible = e.isIntersecting; });
            if (!visible && state !== 'running') armed = false;
        }, { threshold: 0.3 }).observe(canvas);
    } else { visible = true; }

    window.addEventListener('keydown', function (e) {
        if (!visible || (!armed && state !== 'running')) return;
        if (DRIVE[e.code]) {
            e.preventDefault();
            keys[e.code] = true;
            if (state !== 'running') start();
        }
    });
    window.addEventListener('keyup', function (e) { keys[e.code] = false; });
    canvas.addEventListener('focus', function () { armed = true; });
    canvas.addEventListener('blur', function () { if (state !== 'running') armed = false; });
    canvas.addEventListener('pointerdown', function (e) { e.preventDefault(); armed = true; if (state !== 'running') start(); });
    overlay.addEventListener('pointerdown', function (e) { e.preventDefault(); armed = true; if (state !== 'running') start(); });

    function update(dt) {
        var f = Math.min(dt * 60, 3);
        var up = keys.ArrowUp || keys.KeyW, down = keys.ArrowDown || keys.KeyS;
        var left = keys.ArrowLeft || keys.KeyA, right = keys.ArrowRight || keys.KeyD;
        var tv = up ? MAXV : (down ? -MAXV * 0.6 : 0);
        var tw = left ? -MAXW : (right ? MAXW : 0);
        vel.v += (tv - vel.v) * 0.18 * f;
        vel.w += (tw - vel.w) * 0.22 * f;

        bot.th += vel.w * f;
        bot.x += Math.cos(bot.th) * vel.v * f;
        bot.y += Math.sin(bot.th) * vel.v * f;

        var hit = false;
        if (bot.x < M) { bot.x = M; hit = true; } if (bot.x > W - M) { bot.x = W - M; hit = true; }
        if (bot.y < M) { bot.y = M; hit = true; } if (bot.y > H - M) { bot.y = H - M; hit = true; }
        for (var oi = 0; oi < obstacles.length; oi++) {
            var ob = obstacles[oi], odx = bot.x - ob.x, ody = bot.y - ob.y, od = Math.sqrt(odx * odx + ody * ody), md = ob.r + TR;
            if (od < md && od > 0) { bot.x = ob.x + odx / od * md; bot.y = ob.y + ody / od * md; hit = true; }
        }
        if (hit) { vel.v = 0; wallMsg = 1.2; }
        if (wallMsg > 0) wallMsg -= dt;

        trail.push({ x: bot.x, y: bot.y }); if (trail.length > 90) trail.shift();

        var dx = bot.x - goal.x, dy = bot.y - goal.y;
        if (Math.sqrt(dx * dx + dy * dy) < goal.r + 14) { score++; newGoal(); }

        timeLeft -= dt; if (timeLeft <= 0) { timeLeft = 0; over(); }
    }

    function rr(x, y, w, h, r) { ctx.beginPath(); ctx.moveTo(x + r, y); ctx.arcTo(x + w, y, x + w, y + h, r); ctx.arcTo(x + w, y + h, x, y + h, r); ctx.arcTo(x, y + h, x, y, r); ctx.arcTo(x, y, x + w, y, r); ctx.closePath(); }

    function draw() {
        var prim = css('--primary'), acc = css('--accent'), txt = css('--text'), faint = css('--text-faint'), bord = css('--border');
        ctx.clearRect(0, 0, W, H);

        // grid (rviz-ish)
        ctx.strokeStyle = bord; ctx.lineWidth = 1;
        for (var gx = M; gx <= W - M; gx += 40) { ctx.beginPath(); ctx.moveTo(gx, M); ctx.lineTo(gx, H - M); ctx.stroke(); }
        for (var gy = M; gy <= H - M; gy += 40) { ctx.beginPath(); ctx.moveTo(M, gy); ctx.lineTo(W - M, gy); ctx.stroke(); }
        ctx.strokeStyle = css('--border-strong'); ctx.lineWidth = 2; ctx.strokeRect(M, M, W - 2 * M, H - 2 * M);

        // pen trail
        if (trail.length > 1) {
            ctx.lineWidth = 3; ctx.lineCap = 'round'; ctx.lineJoin = 'round';
            for (var i = 1; i < trail.length; i++) {
                ctx.globalAlpha = i / trail.length * 0.6;
                ctx.strokeStyle = prim;
                ctx.beginPath(); ctx.moveTo(trail[i - 1].x, trail[i - 1].y); ctx.lineTo(trail[i].x, trail[i].y); ctx.stroke();
            }
            ctx.globalAlpha = 1;
        }

        // goal
        if (goal) {
            var pulse = calm.matches ? 1 : 1 + Math.sin(Date.now() / 300) * 0.12;
            ctx.strokeStyle = acc; ctx.lineWidth = 3;
            ctx.beginPath(); ctx.arc(goal.x, goal.y, goal.r * pulse, 0, Math.PI * 2); ctx.stroke();
            ctx.fillStyle = acc; ctx.beginPath(); ctx.arc(goal.x, goal.y, 4, 0, Math.PI * 2); ctx.fill();
        }

        // TurtleBot3-world-style pillars (walls)
        for (var pi = 0; pi < obstacles.length; pi++) {
            var p = obstacles[pi];
            var pg = ctx.createRadialGradient(p.x - p.r * 0.35, p.y - p.r * 0.35, 2, p.x, p.y, p.r);
            pg.addColorStop(0, css('--text-faint')); pg.addColorStop(1, css('--border-strong'));
            ctx.fillStyle = pg; ctx.beginPath(); ctx.arc(p.x, p.y, p.r, 0, Math.PI * 2); ctx.fill();
            ctx.strokeStyle = css('--text-soft'); ctx.lineWidth = 1.5; ctx.stroke();
        }

        // turtle (turtlesim-style)
        ctx.save(); ctx.translate(bot.x, bot.y); ctx.rotate(bot.th);
        ctx.fillStyle = '#39b86d';
        var fl = [[9, -11, 0.6], [-9, -11, -0.6], [9, 11, -0.6], [-9, 11, 0.6]];
        for (var fi = 0; fi < 4; fi++) { ctx.save(); ctx.translate(fl[fi][0], fl[fi][1]); ctx.rotate(fl[fi][2]); ctx.beginPath(); ctx.ellipse(0, 0, 6, 3.4, 0, 0, 7); ctx.fill(); ctx.restore(); }
        ctx.beginPath(); ctx.moveTo(-13, 0); ctx.lineTo(-19, -3.5); ctx.lineTo(-19, 3.5); ctx.closePath(); ctx.fill(); // tail
        ctx.beginPath(); ctx.arc(15, 0, 5.5, 0, 7); ctx.fill(); // head
        ctx.fillStyle = '#fff'; ctx.beginPath(); ctx.arc(16.5, -2.4, 1.6, 0, 7); ctx.arc(16.5, 2.4, 1.6, 0, 7); ctx.fill();
        ctx.fillStyle = '#0a3d22'; ctx.beginPath(); ctx.arc(17.2, -2.4, 0.8, 0, 7); ctx.arc(17.2, 2.4, 0.8, 0, 7); ctx.fill();
        ctx.fillStyle = '#2e9e5b'; ctx.strokeStyle = '#14633b'; ctx.lineWidth = 2; ctx.beginPath(); ctx.arc(0, 0, 12.5, 0, 7); ctx.fill(); ctx.stroke(); // shell
        ctx.strokeStyle = '#14633b'; ctx.lineWidth = 1.2; ctx.beginPath(); ctx.arc(0, 0, 6.5, 0, 7); ctx.stroke();
        for (var hs = 0; hs < 6; hs++) { var ha = hs / 6 * Math.PI * 2; ctx.beginPath(); ctx.moveTo(Math.cos(ha) * 6.5, Math.sin(ha) * 6.5); ctx.lineTo(Math.cos(ha) * 12.5, Math.sin(ha) * 12.5); ctx.stroke(); }
        ctx.restore();

        // HUD: /cmd_vel panel
        var lin = (vel.v / MAXV * 0.5), ang = (-vel.w / MAXW * 1.0);
        ctx.font = '600 13px monospace'; ctx.textBaseline = 'top';
        ctx.fillStyle = css('--surface'); ctx.globalAlpha = 0.82; rr(M + 8, M + 8, 188, 60, 8); ctx.fill(); ctx.globalAlpha = 1;
        ctx.fillStyle = prim; ctx.textAlign = 'left'; ctx.fillText('/cmd_vel', M + 20, M + 16);
        ctx.fillStyle = faint; ctx.fillText('linear.x : ', M + 20, M + 34); ctx.fillText('angular.z: ', M + 20, M + 50);
        ctx.fillStyle = txt; ctx.fillText(lin.toFixed(2), M + 96, M + 34); ctx.fillText(ang.toFixed(2), M + 96, M + 50);

        // HUD: score + timer
        ctx.textAlign = 'right'; ctx.font = '700 16px monospace';
        ctx.fillStyle = txt; ctx.fillText('goals ' + score, W - M - 12, M + 14);
        ctx.fillStyle = timeLeft <= 10 ? acc : faint; ctx.font = '600 14px monospace';
        ctx.fillText(timeLeft.toFixed(1) + 's', W - M - 12, M + 38);
        ctx.fillStyle = faint; ctx.fillText('best ' + best, W - M - 12, M + 58);
        ctx.textAlign = 'left';

        // wall easter egg
        if (wallMsg > 0) {
            ctx.fillStyle = acc; ctx.font = '700 15px monospace'; ctx.textAlign = 'center';
            ctx.fillText('Oh no! I hit the wall!', W / 2, H - M - 26);
            ctx.textAlign = 'left';
        }
    }

    reset();
    bestEl.textContent = best ? 'Best: ' + best : '';
    var last = 0;
    function loop(ts) {
        if (!last) last = ts;
        var dt = Math.min((ts - last) / 1000, 0.05); last = ts;
        if (state === 'running') update(dt);
        draw();
        requestAnimationFrame(loop);
    }
    requestAnimationFrame(loop);
})();
</script>

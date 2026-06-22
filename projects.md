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
    var filterBar = document.querySelector('.projects-filter');
    if (!filterBar) return;
    // Event delegation so dynamically-added GitHub topic buttons work too
    filterBar.addEventListener('click', function (e) {
        var btn = e.target.closest('.filter-tag');
        if (!btn) return;
        var filter = btn.getAttribute('data-filter');
        filterBar.querySelectorAll('.filter-tag').forEach(function (t) { t.classList.remove('active'); });
        btn.classList.add('active');
        // Re-query at click time to include async-loaded GitHub repo cards
        document.querySelectorAll('.project-card, .repo-card').forEach(function (card) {
            var tags = (card.getAttribute('data-tags') || '').split(',');
            var show = filter === 'all' || tags.indexOf(filter) !== -1;
            card.style.display = show ? '' : 'none';
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
    var PINNED = {};                            // repos pinned on GitHub -> featured here
    var EXCLUDE = ['tzf230201.github.io'];      // repos to hide
    var SHOW_FORKS = false;
    var LANG_COLORS = {
        Python: '#3572A5', 'C++': '#f34b7d', C: '#555555', 'C#': '#178600',
        VHDL: '#adb2cb', 'F#': '#b845fc', CSS: '#563d7c', CMake: '#DA3434',
        JavaScript: '#f1e05a', TypeScript: '#3178c6', HTML: '#e34c26',
        Shell: '#89e051', Java: '#b07219', Go: '#00ADD8', Verilog: '#b2b7f8'
    };

    function esc(s) { var d = document.createElement('div'); d.textContent = s == null ? '' : s; return d.innerHTML; }

    // Find the first usable image URL in a README's markdown (skips badges), resolving relative paths
    function firstImage(md, repo, branch) {
        var re = /!\[[^\]]*\]\(\s*<?([^)\s>]+)>?[^)]*\)|<img[^>]+src\s*=\s*["']([^"']+)["']/ig;
        var m;
        while ((m = re.exec(md))) {
            var u = m[1] || m[2];
            if (!u) continue;
            if (/shields\.io|img\.shields|badgen|\/badge|badge\.|\.svg($|\?)|actions\/work/i.test(u)) continue;
            // GitHub blob/raw or raw.githubusercontent links -> jsDelivr CDN (reliable, CORS, cached)
            var g = u.match(/^https?:\/\/github\.com\/([^/]+)\/([^/]+)\/(?:blob|raw)\/([^/]+)\/(.+)$/i)
                 || u.match(/^https?:\/\/raw\.githubusercontent\.com\/([^/]+)\/([^/]+)\/([^/]+)\/(.+)$/i);
            if (g) return 'https://cdn.jsdelivr.net/gh/' + g[1] + '/' + g[2] + '@' + g[3] + '/' + g[4].split('?')[0];
            if (/^https?:\/\//i.test(u)) return u;
            if (u.indexOf('//') === 0) return 'https:' + u;
            var rel = (u.charAt(0) === '/' ? u.slice(1) : u.replace(/^\.\//, ''));
            return 'https://cdn.jsdelivr.net/gh/' + USER + '/' + repo + '@' + branch + '/' + rel;
        }
        return null;
    }

    function isPinned(r) { return !!PINNED[(r.name || '').toLowerCase()]; }

    function loadRepos() {
    fetch('https://api.github.com/users/' + USER + '/repos?per_page=100&sort=updated')
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
                return '<div class="repo-card" data-name="' + esc(r.name) + '" data-branch="' + esc(r.default_branch || 'main') + '" data-tags="' + esc((r.topics || []).join(',').toLowerCase()) + '">' +
                    (isPinned(r) ? '<span class="featured-badge">★ Featured</span>' : '') +
                    '<a class="repo-card-image" href="' + r.html_url + '" target="_blank" rel="noopener" hidden><img alt="' + esc(r.name) + '"></a>' +
                    '<h3><svg width="16" height="16" fill="currentColor" viewBox="0 0 16 16"><path d="M2 2.5A2.5 2.5 0 0 1 4.5 0h8.75a.75.75 0 0 1 .75.75v12.5a.75.75 0 0 1-.75.75h-2.5a.75.75 0 0 1 0-1.5h1.75v-2h-8a1 1 0 0 0-.714 1.7.75.75 0 1 1-1.072 1.05A2.495 2.495 0 0 1 2 11.5zm10.5-1h-8a1 1 0 0 0-1 1v6.708A2.486 2.486 0 0 1 4.5 9h8zM5 12.25a.25.25 0 0 1 .25-.25h3.5a.25.25 0 0 1 .25.25v3.25a.25.25 0 0 1-.4.2l-1.45-1.087a.25.25 0 0 0-.3 0L5.4 15.7a.25.25 0 0 1-.4-.2z"/></svg>' +
                    '<a href="' + r.html_url + '" target="_blank" rel="noopener">' + esc(r.name) + '</a></h3>' +
                    '<p class="repo-desc">' + (r.description ? esc(r.description) : '<em>No description provided.</em>') + '</p>' +
                    (topics ? '<div class="repo-topics">' + topics + '</div>' : '') +
                    '<div class="repo-meta">' + lang + stars + forks + '</div>' +
                    '</div>';
            }).join('');

            // Merge GitHub topics into the shared tag filter (skip ones already present)
            var filterBar = document.querySelector('.projects-filter');
            if (filterBar) {
                var existing = {};
                filterBar.querySelectorAll('.filter-tag').forEach(function (b) { existing[b.getAttribute('data-filter')] = true; });
                repos.forEach(function (r) {
                    (r.topics || []).forEach(function (t) {
                        var key = t.toLowerCase();
                        if (existing[key]) return;
                        existing[key] = true;
                        var b = document.createElement('button');
                        b.className = 'filter-tag';
                        b.setAttribute('data-filter', key);
                        b.textContent = t;
                        filterBar.appendChild(b);
                    });
                });
            }

            // Pull a thumbnail from each repo's README.md (raw CDN — no API rate limit)
            var cards = grid.querySelectorAll('.repo-card');
            repos.forEach(function (r, i) {
                var card = cards[i];
                if (!card) return;
                var branch = r.default_branch || 'main';
                fetch('https://cdn.jsdelivr.net/gh/' + USER + '/' + r.name + '@' + branch + '/README.md')
                    .then(function (res) { return res.ok ? res.text() : null; })
                    .then(function (md) {
                        if (!md) return;
                        var url = firstImage(md, r.name, branch);
                        if (!url) return;
                        var box = card.querySelector('.repo-card-image');
                        var img = box && box.querySelector('img');
                        if (!img) return;
                        img.onload = function () { box.hidden = false; };
                        img.src = url;
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
    fetch('https://pinned.berrysauce.dev/get/' + USER)
        .then(function (r) { return r.ok ? r.json() : []; })
        .then(function (pins) { (pins || []).forEach(function (p) { PINNED[(p.name || '').toLowerCase()] = true; }); })
        .catch(function () {})
        .then(loadRepos);
})();
</script>

<div class="robot-game" id="robot-game">
    <div class="section-head">
        <span class="section-kicker">// rosrun</span>
        <h2 class="section-title">Drive a Robot with /cmd_vel</h2>
        <p class="section-sub">A tiny teleop. Drive the turtle like turtlesim — every key press publishes a <code>geometry_msgs/Twist</code> to <code>/cmd_vel</code>. Dodge the TurtleBot3-style pillars and reach the goals before the 60&nbsp;s timer runs out.</p>
    </div>
    <div class="game-card">
        <canvas id="cmdvel-canvas" width="920" height="440" class="game-canvas" aria-label="cmd_vel teleop game"></canvas>
        <div class="game-overlay" id="cmdvel-overlay">
            <div>
                <div class="game-emoji">🐢</div>
                <p class="game-msg" id="cmdvel-msg">Drive with <kbd>↑</kbd><kbd>↓</kbd><kbd>←</kbd><kbd>→</kbd> or <kbd>W</kbd><kbd>A</kbd><kbd>S</kbd><kbd>D</kbd><br>Reach the goals. Press a key or tap to start.</p>
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
    if ('IntersectionObserver' in window) {
        new IntersectionObserver(function (es) { es.forEach(function (e) { visible = e.isIntersecting; }); }, { threshold: 0.3 }).observe(canvas);
    } else { visible = true; }

    window.addEventListener('keydown', function (e) {
        if (!visible) return;
        if (DRIVE[e.code]) {
            e.preventDefault();
            keys[e.code] = true;
            if (state !== 'running') start();
        }
    });
    window.addEventListener('keyup', function (e) { keys[e.code] = false; });
    canvas.addEventListener('pointerdown', function (e) { e.preventDefault(); if (state !== 'running') start(); });
    overlay.addEventListener('pointerdown', function (e) { e.preventDefault(); if (state !== 'running') start(); });

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
            var pulse = 1 + Math.sin(Date.now() / 300) * 0.12;
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

# Jekyll Website - tzf230201.github.io

Personal website built with Jekyll and hosted on GitHub Pages.

## 🚀 Quick Start

### Local Development

1. Install Jekyll:
   ```bash
   gem install jekyll bundler
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Run the development server:
   ```bash
   bundle exec jekyll serve
   ```

4. Visit `http://localhost:4000` in your browser

### Adding a New Project

1. Create a new Markdown file in the `_projects/` folder:
   ```
   _projects/my-new-project.md
   ```

2. Add front matter and content:
   ```yaml
   ---
   title: My Project Title
   description: Short description for the project card
   cover_image: /assets/images/projects/my-project-cover.jpg
   tags: [Web, React, API]
   featured: true
   demo_url: https://demo.example.com
   repo_url: https://github.com/username/repo
   date: 2026-02-03
   ---

   ## Project Description
   Write your detailed project description here...
   ```

3. The project will automatically appear on the `/projects/` page

## 📁 Project Structure

```
.
├── _config.yml              # Jekyll configuration
├── _layouts/                # Page layouts
│   ├── default.html         # Base layout with navbar & footer
│   ├── page.html            # For regular pages
│   └── project.html         # For project detail pages
├── _includes/               # Reusable components
│   └── navbar.html          # Navigation menu
├── _projects/               # Project collection (add .md files here)
│   ├── project-example-1.md
│   ├── project-example-2.md
│   └── project-example-3.md
├── assets/
│   ├── css/
│   │   └── style.css        # Main stylesheet
│   └── images/
│       └── projects/        # Project images
├── index.md                 # Home page
├── projects.md              # Projects listing page
├── contact.md               # Contact page
└── README.md               # This file
```

## 🎨 Customization

### Update Site Information

Edit `_config.yml` to update:
- Site title
- Your email
- Description
- URL

### Change Colors

Edit CSS variables in `assets/css/style.css`:
```css
:root {
    --primary-color: #2563eb;
    --primary-dark: #1e40af;
    --secondary-color: #64748b;
    ...
}
```

### Add New Pages

Create a new `.md` file with front matter:
```yaml
---
layout: page
title: My New Page
permalink: /my-page/
---

Content goes here...
```

## 🌐 Deployment

This site is automatically deployed via GitHub Pages when you push to the `main` branch.

### GitHub Pages Setup

1. Go to repository Settings > Pages
2. Source: Deploy from a branch
3. Branch: `main` / `(root)`
4. Save

Your site will be available at: `https://tzf230201.github.io/`

## 📝 Front Matter Options for Projects

| Field | Required | Description |
|-------|----------|-------------|
| `title` | Yes | Project name |
| `description` | Yes | Short description for card |
| `cover_image` | No | Path to cover image |
| `tags` | No | Array of technology tags |
| `featured` | No | Show on homepage (true/false) |
| `demo_url` | No | Link to live demo |
| `repo_url` | No | Link to GitHub repo |
| `gallery` | No | Array of image paths |
| `date` | No | Project date (for sorting) |

## 🔧 Troubleshooting

### Jekyll not found
```bash
gem install jekyll bundler
```

### Port already in use
```bash
bundle exec jekyll serve --port 4001
```

### Changes not showing
- Hard refresh: `Ctrl + Shift + R` (Windows/Linux) or `Cmd + Shift + R` (Mac)
- Or clear your browser cache

## 📚 Resources

- [Jekyll Documentation](https://jekyllrb.com/docs/)
- [GitHub Pages Documentation](https://docs.github.com/en/pages)
- [Markdown Guide](https://www.markdownguide.org/)

## 📄 License

This project is open source and available under the MIT License.
# Panduan Implementasi dan Deployment

## 📋 Checklist Sebelum Deploy

### 1. Update Informasi Personal

Edit [`_config.yml`](_config.yml):
```yaml
title: Nama Anda
email: email.anda@example.com
description: >-
  Deskripsi singkat tentang Anda atau website Anda
url: "https://tzf230201.github.io"
```

### 2. Update Konten Homepage

Edit [`index.md`](index.md):
- Ganti "Your Name" dengan nama Anda
- Update subtitle dan deskripsi
- Sesuaikan section "About Me"

### 3. Update Halaman Contact

Edit [`contact.md`](contact.md):
- Update link GitHub
- Tambahkan link LinkedIn
- Update email (otomatis dari _config.yml)

### 4. Hapus/Update Project Contoh

Folder `_projects/` berisi 3 file contoh:
- `project-example-1.md`
- `project-example-2.md`
- `project-example-3.md`

**Pilihan:**
- Hapus semua dan buat project Anda sendiri
- Atau edit sebagai template untuk project Anda

## 🚀 Cara Deploy ke GitHub Pages

### Opsi 1: Push Langsung (Recommended)

1. **Commit semua perubahan:**
   ```bash
   git add .
   git commit -m "Setup Jekyll template"
   git push origin main
   ```

2. **Aktifkan GitHub Pages:**
   - Buka https://github.com/tzf230201/tzf230201.github.io/settings/pages
   - Source: **Deploy from a branch**
   - Branch: **main** / `(root)`
   - Klik **Save**

3. **Tunggu build selesai** (2-5 menit)
   - Cek di tab **Actions**: https://github.com/tzf230201/tzf230201.github.io/actions
   - Website live di: https://tzf230201.github.io/

### Opsi 2: Test Lokal Dulu

```bash
# Install dependencies
bundle install

# Run local server
bundle exec jekyll serve

# Buka browser di http://localhost:4000
```

Kalau sudah puas, push ke GitHub seperti Opsi 1.

## ✨ Cara Menambah Project Baru

### Langkah 1: Buat File Markdown

Buat file baru di folder `_projects/`, misalnya:
```
_projects/website-portfolio.md
```

### Langkah 2: Tambahkan Front Matter & Konten

```yaml
---
title: Website Portfolio Pribadi
description: Website portfolio modern dengan animasi interaktif
cover_image: /assets/images/projects/portfolio-cover.jpg
tags: [HTML, CSS, JavaScript]
featured: true
demo_url: https://myportfolio.com
repo_url: https://github.com/tzf230201/portfolio
date: 2026-02-03
---

## Tentang Project

Deskripsi lengkap project Anda di sini...

### Fitur Utama

- Fitur 1
- Fitur 2
- Fitur 3

### Tech Stack

- Frontend: HTML5, CSS3, JavaScript
- Deployment: GitHub Pages
```

### Langkah 3: Tambahkan Gambar (Opsional)

Upload gambar ke folder:
```
assets/images/projects/portfolio-cover.jpg
```

### Langkah 4: Push ke GitHub

```bash
git add .
git commit -m "Add new project: Website Portfolio"
git push origin main
```

**Project otomatis muncul di:**
- `/projects/` (halaman list)
- `/` (homepage, kalau `featured: true`)
- `/projects/website-portfolio/` (halaman detail)

## 🎨 Customisasi Warna & Style

### Ubah Warna Utama

Edit [`assets/css/style.css`](assets/css/style.css):

```css
:root {
    --primary-color: #2563eb;      /* Warna utama */
    --primary-dark: #1e40af;       /* Warna hover */
    --secondary-color: #64748b;    /* Warna secondary */
    /* ... */
}
```

**Contoh warna alternatif:**
```css
/* Purple theme */
--primary-color: #7c3aed;
--primary-dark: #5b21b6;

/* Green theme */
--primary-color: #10b981;
--primary-dark: #059669;

/* Red theme */
--primary-color: #ef4444;
--primary-dark: #dc2626;
```

## 📱 Struktur URL

Setelah deploy, URL akan seperti ini:

| Halaman | URL |
|---------|-----|
| Home | `https://tzf230201.github.io/` |
| Projects List | `https://tzf230201.github.io/projects/` |
| Project Detail | `https://tzf230201.github.io/projects/nama-project/` |
| Contact | `https://tzf230201.github.io/contact/` |

**Nama project** diambil dari nama file tanpa `.md`:
- File: `_projects/my-awesome-app.md`
- URL: `/projects/my-awesome-app/`

## 🔧 Tips & Troubleshooting

### File index.html Lama

File `index.html` dan `styles.css` yang lama bisa dihapus atau di-backup:
```bash
# Hapus
git rm index.html styles.css
git commit -m "Remove old files"

# Atau rename jadi backup
mv index.html index.html.backup
mv styles.css styles.css.backup
```

### Build Error di GitHub

1. Cek tab **Actions** untuk error log
2. Error umum:
   - Typo di front matter YAML
   - Image path salah
   - Syntax error di Liquid template

### Website Tidak Update

1. Hard refresh browser: `Ctrl + Shift + R`
2. Clear cache GitHub Pages (tunggu 5-10 menit)
3. Cek build status di Actions tab

### Menambahkan Halaman CV/Resume Nanti

Uncomment baris di [`_includes/navbar.html`](_includes/navbar.html):
```html
<!-- Uncomment when ready to add CV/Resume -->
<li><a href="{{ '/resume/' | relative_url }}">Resume</a></li>
```

Lalu buat file `resume.md`:
```yaml
---
layout: page
title: Resume
permalink: /resume/
---

# CV / Resume content here
```

## 📊 Next Steps

1. ✅ Setup template (done!)
2. 📝 Update informasi personal
3. 🎨 Customisasi warna/style
4. 📂 Hapus/edit project contoh
5. ➕ Tambah project asli Anda
6. 🚀 Deploy ke GitHub Pages
7. 🔍 Test semua link dan URL
8. 📱 Test responsive di mobile

## 💡 Resources

- **Jekyll Docs**: https://jekyllrb.com/docs/
- **GitHub Pages**: https://docs.github.com/en/pages
- **Markdown Cheatsheet**: https://www.markdownguide.org/cheat-sheet/
- **Free Images**: https://unsplash.com/

---

**Questions?** Buka issue di repo atau cek dokumentasi Jekyll untuk advanced customization.

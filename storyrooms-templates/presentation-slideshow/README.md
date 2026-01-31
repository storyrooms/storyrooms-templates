# Presentation Slideshow Template

**Transform slides into immersive 3D corridor experiences**

## 📖 Overview

Replace traditional PowerPoint with a walkable 3D presentation. Your slides become displays on corridor walls, creating an engaging storytelling experience.

**Perfect for:**
- Sales presentations
- Course materials  
- Conference talks
- Portfolio showcases

---

## ✨ Features

- 📸 **Images & Videos** - Display any media
- 🏷️ **Chapters** - Organize content into sections
- ⏱️ **Auto-advance** - Optional timed progression
- 🎬 **Smooth transitions** - Professional camera movement
- 🌐 **HTML export** - Share online easily
- 🎨 **Customizable** - Colors, layouts, branding

---

## 🚀 Quick Start

### 1. Install Requirements

```r
install.packages(c("tidyverse", "rayrender", "here", "yaml"))
```

### 2. Prepare Your Content

Organize your slides in a folder:
```
my-presentation/
├── slide-01.png
├── slide-02.png
├── slide-03.png
└── config.yaml
```

### 3. Configure

Create `config.yaml`:

```yaml
title: "My Presentation"
author: "Your Name"
output_dir: "output"

slides:
  - image: "slide-01.png"
    chapter: "Introduction"
    duration: 3
  
  - image: "slide-02.png"
    chapter: "Main Content"
    duration: 4
  
  - image: "slide-03.png"
    chapter: "Conclusion"
    duration: 3

style:
  wall_color: "#f0f0f0"
  floor_color: "#333333"
  lighting: "bright"
```

### 4. Create Presentation

```r
source("create_presentation.R")

create_presentation(
  config_file = "config.yaml",
  render = TRUE
)
```

### 5. View Result

Open `output/presentation.html` in your browser!

---

## 📂 What's Included

```
presentation-slideshow/
├── README.md                    # This file
├── GUIDE.md                     # Detailed tutorial
├── create_presentation.R        # Main script
├── enhanced_corridor_v2.R       # Core rendering engine
├── example_config.yaml          # Example configuration
├── examples/
│   ├── business-pitch/          # Sales presentation example
│   ├── course-lecture/          # Educational example
│   └── portfolio-showcase/      # Portfolio example
└── utils/
    ├── validate_config.R
    └── export_html.R
```

---

## 🎨 Customization

### Change Visual Style

```yaml
style:
  wall_color: "#ffffff"      # White walls
  floor_color: "#2c3e50"     # Dark blue floor
  ceiling_color: "#ecf0f1"   # Light gray ceiling
  lighting: "dramatic"        # Options: bright, dramatic, soft
  corridor_width: 5          # Wider corridor
```

### Add Videos

```yaml
slides:
  - video: "intro.mp4"
    chapter: "Welcome"
    duration: 10
    autoplay: true
```

### Branding

```yaml
branding:
  logo: "company-logo.png"
  colors:
    primary: "#0076bc"       # Gothenburg blue
    secondary: "#ffd700"
  font: "Helvetica"
```

---

## 📊 Example Configurations

### Business Pitch
```yaml
title: "Q4 Sales Results"
slides:
  - image: "cover.png"
    chapter: "Overview"
  - image: "metrics.png"
    chapter: "Key Metrics"
  - image: "growth.png"
    chapter: "Growth"
style:
  lighting: "dramatic"
  wall_color: "#1a1a1a"
```

### Educational Course
```yaml
title: "Introduction to Statistics"
slides:
  - image: "lesson-01.png"
    chapter: "What is Statistics?"
  - image: "lesson-02.png"
    chapter: "Data Types"
style:
  lighting: "bright"
  wall_color: "#ffffff"
```

---

## 🎓 Step-by-Step Guide

See [GUIDE.md](GUIDE.md) for detailed walkthrough including:
- Preparing slide images
- Advanced configurations
- Troubleshooting
- Tips & tricks

---

## 💰 Pricing

**Personal Use:** Free (with attribution)  
**Commercial Use:** 990 SEK

[Buy Commercial License](https://storyrooms.se/buy/presentation)

---

## 🆘 Troubleshooting

**Rendering is slow:**
- Reduce image resolution (max 1920x1080)
- Lower render quality in config
- Use fewer slides per render

**Images not showing:**
- Check file paths in config.yaml
- Ensure images are in correct folder
- Verify image formats (PNG, JPG supported)

**HTML export not working:**
- Update create_html_from_images_clean.R
- Check output directory permissions

---

## 📈 What's Next?

After mastering Presentation Slideshow, try:
- **Quiz Labyrinth** - Interactive quizzes
- **Timeline Corridor** - Show change over time
- **Data Gallery** - Showcase datasets

---

## 🤝 Support

- **Documentation:** Full guide in GUIDE.md
- **Examples:** See examples/ folder
- **Issues:** [GitHub Issues](https://github.com/storyrooms/storyrooms-templates/issues)
- **Email:** henrik@storyrooms.se

---

## 📝 License

MIT License (personal use)  
Commercial license required for business use.

---

**Status:** Week 1-2 of development  
**Based on:** enhanced_corridor_v2.R (90% complete)  
**Created by:** Henrik Söderholm

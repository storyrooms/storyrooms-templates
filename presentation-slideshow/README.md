# Presentation Slideshow Template

**Transform slides into immersive 3D corridor experiences**

---

## 📖 What is This?

This is a **working, production-ready** R script that creates interactive 3D presentations from your slides. It's the core of the StoryRooms Presentation Template.

**Status:** 🟢 Fully functional - this is Henrik's tested code!

---

## ⚡ Quick Start

### **1. Install Requirements**
```r
install.packages("jsonlite")
```

### **2. Source the script**
```r
source("enhanced_corridor.R")
```

### **3. Create a presentation**
```r
# From a folder of images
convert_directory_to_presentation(
  image_dir = "slides/",
  titles = c("Welcome", "Main Content", "Thank You"),
  chapters = c("Intro", "Body", "Outro"),
  presentation_title = "My Presentation"
)
```

**That's it!** Open the generated `presentation.html` in your browser.

---

## 🎯 Features

- ✅ **Interactive navigation** - Click, keyboard, or chapter dots
- ✅ **Auto-advance** - Optional timed progression
- ✅ **Chapters** - Organize slides into sections
- ✅ **Video support** - Mix images and videos
- ✅ **Multiple themes** - Dark, light, or minimal
- ✅ **Smooth transitions** - Fade, slide, zoom, or door
- ✅ **Progress bar** - Visual progress indicator
- ✅ **Keyboard shortcuts** - Arrow keys, Space, Home, Esc

---

## 📝 Usage Examples

### **Example 1: Quick Conversion**

Convert a folder of numbered slides:
```r
convert_directory_to_presentation(
  image_dir = "my-slides/",
  presentation_title = "Q4 Results"
)
```

### **Example 2: With Metadata**

Add titles and chapters:
```r
convert_directory_to_presentation(
  image_dir = "slides/",
  titles = c(
    "Welcome",
    "Overview",
    "Data Analysis",
    "Conclusions"
  ),
  chapters = c(
    "Introduction",
    "Introduction",
    "Analysis",
    "Conclusion"
  ),
  durations = c(3, 0, 0, 5),
  presentation_title = "Annual Report 2024",
  theme = "dark"
)
```

### **Example 3: Full Control**

Define each slide individually:
```r
slides <- list(
  list(
    file = "intro.png",
    title = "Welcome to My Story",
    subtitle = "An Interactive Journey",
    chapter = "Introduction",
    transition = "fade",
    duration = 5
  ),
  list(
    file = "demo.mp4",
    type = "video",
    title = "Watch This",
    caption = "Source: Author",
    chapter = "Demo",
    pause_after = TRUE
  ),
  list(
    file = "data.png",
    title = "The Numbers",
    chapter = "Analysis",
    transition = "zoom"
  )
)

create_presentation(
  slides,
  output_dir = "output/my-story/",
  title = "My Story",
  theme = "dark"
)
```

---

## 🎨 Options

### **Themes**
- `"dark"` (default) - Black background, white text
- `"light"` - White background, black text
- `"minimal"` - Dark gray, minimal UI

### **Transitions**
- `"fade"` (default) - Smooth fade
- `"slide"` - Slide animation
- `"zoom"` - Zoom in/out
- `"door"` - Door-opening effect

---

## ⌨️ Keyboard Controls

- `→` or `Space` - Next slide
- `←` - Previous slide
- `Home` - Back to first slide
- `Esc` - Pause/resume auto-advance

---

## 💡 Tips

- Use numbered prefixes for automatic ordering: `01_`, `02_`, etc.
- Keep images under 2MB for smooth loading
- Videos: H.264 codec recommended
- Limit to ~20 slides for best performance

---

## 📄 License

MIT License - Free to use and modify

---

## 👤 Created By

Henrik Söderholm  
Part of StoryRooms - 3D Data Storytelling Platform

**Status:** 🟢 Production Ready  
**Version:** 2.0
```

5. Commit message: "Create presentation-slideshow folder with documentation"
6. Commit changes

---

## 📝 STEG 3: Ladda upp enhanced_corridor.R

**Nu när mappen finns:**

1. Klicka på mappen **`presentation-slideshow`** (du ska se README.md inuti)
2. Klicka **"Add file"** → **"Upload files"**
3. Dra `enhanced_corridor.R` filen (den jag gav dig tidigare)
4. Commit message: "Add production-ready presentation code"
5. Commit changes

---

## ✅ KLART!

När du är klar ska strukturen se ut:
```
storyrooms-templates/
├── README.md
├── presentation-slideshow/
│   ├── README.md                 ✅ NYA
│   └── enhanced_corridor.R       ✅ NYA
├── quiz-labyrinth/
│   └── README.md
└── (gamla filer...)

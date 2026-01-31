# ═══════════════════════════════════════════════════════════════════════════════
# ENHANCED CORRIDOR v2.0 - STORYTELLING EDITION
# ═══════════════════════════════════════════════════════════════════════════════
# Kreativt storytelling-verktyg med metadata, transitions, och auto-advance
# ═══════════════════════════════════════════════════════════════════════════════

library(jsonlite)

#' Skapa enhanced storytelling-presentation
#'
#' @param slides Lista med slide-objekt
#' @param output_dir Mapp där presentation ska skapas
#' @param title Presentationstitel
#' @param theme "dark", "light", eller "minimal"
#' @return Sökväg till HTML-fil
create_enhanced_presentation <- function(
    slides,
    output_dir,
    title = "3D Story",
    theme = "dark"
) {

  cat("\n═══════════════════════════════════════════════════════════\n")
  cat("  ENHANCED CORRIDOR v2.0\n")
  cat("═══════════════════════════════════════════════════════════\n\n")

  # Skapa mapp
  if (!dir.exists(output_dir)) {
    dir.create(output_dir, recursive = TRUE)
  }

  # Berika slides med defaults
  slides <- lapply(slides, function(s) {
    list(
      file = s$file,
      type = s$type %||% if (grepl("\\.mp4$", s$file, ignore.case = TRUE)) "video" else "image",
      title = s$title %||% "",
      subtitle = s$subtitle %||% "",
      caption = s$caption %||% "",
      chapter = s$chapter %||% "",
      transition = s$transition %||% "fade",
      duration = s$duration %||% 0,
      pause_after = s$pause_after %||% FALSE
    )
  })

  num_slides <- length(slides)
  slide_json <- toJSON(slides, auto_unbox = TRUE)

  # Tema-färger
  colors <- switch(theme,
                   dark = list(bg = "#000", text = "#fff", primary = "#0076bc", overlay = "rgba(0,0,0,0.8)"),
                   light = list(bg = "#fff", text = "#000", primary = "#0076bc", overlay = "rgba(255,255,255,0.9)"),
                   minimal = list(bg = "#1a1a1a", text = "#eee", primary = "#fff", overlay = "rgba(0,0,0,0.9)")
  )

  cat(sprintf("Titel: %s\n", title))
  cat(sprintf("Slides: %d\n", num_slides))
  cat(sprintf("Tema: %s\n", theme))
  cat(sprintf("Output: %s\n\n", output_dir))

  # Skapa HTML
  html <- paste0('<!DOCTYPE html>
<html lang="sv">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>', title, '</title>
<style>
* { margin: 0; padding: 0; box-sizing: border-box; }
body {
  background: ', colors$bg, ';
  color: ', colors$text, ';
  font-family: "Open Sans", Arial, sans-serif;
  overflow: hidden;
}
#presentation {
  width: 100vw;
  height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
}
#slide-container {
  width: 100%;
  height: 100%;
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
}
.slide-media {
  max-width: 90vw;
  max-height: 90vh;
  position: absolute;
  cursor: pointer;
  box-shadow: 0 20px 60px rgba(0,0,0,0.5);
  opacity: 0;
  transition: opacity 0.6s ease;
}
.slide-media.active { opacity: 1; }
.slide-media:hover { transform: scale(1.005); transition: transform 0.3s; }

/* Transitions */
.transition-fade { transition: opacity 0.8s ease; }
.transition-slide { transition: transform 0.8s ease, opacity 0.8s ease; }
.transition-zoom { transition: transform 0.8s ease, opacity 0.8s ease; }
.transition-door {
  transition: transform 1.2s cubic-bezier(0.68, -0.55, 0.265, 1.55), opacity 0.8s ease;
}

#slide-info {
  position: fixed;
  bottom: 120px;
  left: 50%;
  transform: translateX(-50%);
  text-align: center;
  z-index: 100;
  max-width: 80vw;
  opacity: 0;
  transition: opacity 0.5s;
}
#slide-info.show { opacity: 1; }
#slide-title {
  font-size: 32px;
  font-weight: 700;
  margin-bottom: 8px;
  text-shadow: 0 2px 10px rgba(0,0,0,0.8);
}
#slide-subtitle {
  font-size: 20px;
  opacity: 0.9;
  text-shadow: 0 2px 10px rgba(0,0,0,0.8);
}
#slide-caption {
  position: fixed;
  bottom: 120px;
  right: 30px;
  font-size: 14px;
  opacity: 0.7;
  background: ', colors$overlay, ';
  padding: 8px 16px;
  border-radius: 6px;
}

#progress-bar {
  position: fixed;
  top: 0;
  left: 0;
  width: 0%;
  height: 4px;
  background: linear-gradient(90deg, ', colors$primary, ', #005a94);
  transition: width 0.3s;
  z-index: 1000;
}

#controls {
  position: fixed;
  bottom: 30px;
  left: 50%;
  transform: translateX(-50%);
  background: ', colors$overlay, ';
  padding: 20px 40px;
  border-radius: 50px;
  display: flex;
  gap: 25px;
  align-items: center;
  backdrop-filter: blur(10px);
  box-shadow: 0 5px 30px rgba(0,118,188,0.3);
  border: 1px solid rgba(0,118,188,0.3);
  z-index: 1000;
}
button {
  background: linear-gradient(135deg, ', colors$primary, ', #005a94);
  color: white;
  border: none;
  padding: 12px 24px;
  border-radius: 8px;
  cursor: pointer;
  font-size: 16px;
  font-weight: 600;
  transition: all 0.3s;
}
button:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 4px 15px rgba(0,118,188,0.5);
}
button:disabled {
  background: #333;
  opacity: 0.5;
  cursor: not-allowed;
}
#slide-counter {
  font-size: 20px;
  font-weight: 600;
  min-width: 100px;
  text-align: center;
  background: rgba(0,118,188,0.2);
  padding: 8px 16px;
  border-radius: 20px;
}

#chapters {
  position: fixed;
  right: 30px;
  top: 50%;
  transform: translateY(-50%);
  display: flex;
  flex-direction: column;
  gap: 15px;
  z-index: 900;
}
.chapter-dot {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  background: rgba(255,255,255,0.3);
  cursor: pointer;
  transition: all 0.3s;
  position: relative;
}
.chapter-dot:hover {
  background: ', colors$primary, ';
  transform: scale(1.5);
}
.chapter-dot.active {
  background: ', colors$primary, ';
  width: 16px;
  height: 16px;
}
.chapter-dot::after {
  content: attr(data-chapter);
  position: absolute;
  right: 25px;
  top: 50%;
  transform: translateY(-50%);
  white-space: nowrap;
  background: ', colors$overlay, ';
  padding: 6px 12px;
  border-radius: 6px;
  font-size: 14px;
  opacity: 0;
  pointer-events: none;
  transition: opacity 0.3s;
}
.chapter-dot:hover::after { opacity: 1; }

#auto-timer {
  position: fixed;
  top: 30px;
  left: 50%;
  transform: translateX(-50%);
  background: rgba(255,193,7,0.9);
  color: #000;
  padding: 10px 20px;
  border-radius: 20px;
  font-weight: 600;
  display: none;
  z-index: 1000;
}

#welcome-screen {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: linear-gradient(135deg, ', colors$primary, ', #005a94);
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  z-index: 2000;
  transition: opacity 0.5s;
}
#welcome-screen.hidden {
  opacity: 0;
  pointer-events: none;
}
#welcome-title {
  font-size: 48px;
  font-weight: 700;
  margin-bottom: 20px;
  text-shadow: 0 4px 20px rgba(0,0,0,0.5);
}
#start-button {
  font-size: 20px;
  padding: 20px 50px;
  background: white;
  color: ', colors$primary, ';
  border-radius: 50px;
  margin-top: 30px;
}

#hints {
  position: fixed;
  bottom: 30px;
  left: 30px;
  font-size: 13px;
  opacity: 0.6;
  background: ', colors$overlay, ';
  padding: 10px 16px;
  border-radius: 8px;
}
#hints kbd {
  background: rgba(255,255,255,0.2);
  padding: 2px 6px;
  border-radius: 3px;
  font-family: monospace;
}
</style>
</head>
<body>

<div id="welcome-screen">
  <div id="welcome-title">', title, '</div>
  <div style="font-size: 20px; opacity: 0.8;">', num_slides, ' slides • Klicka för att börja</div>
  <button id="start-button">Starta presentation</button>
</div>

<div id="progress-bar"></div>
<div id="auto-timer">Auto-advance om <span id="timer-seconds">5</span>s</div>

<div id="presentation">
  <div id="slide-container"></div>
  <div id="slide-info">
    <div id="slide-title"></div>
    <div id="slide-subtitle"></div>
  </div>
  <div id="slide-caption"></div>
</div>

<div id="chapters"></div>

<div id="controls">
  <button id="prev-btn">← Föregående</button>
  <div id="slide-counter">1 / ', num_slides, '</div>
  <button id="next-btn">Nästa →</button>
  <button id="reset-btn">⟲ Börja om</button>
</div>

<div id="hints">
  <kbd>←</kbd> <kbd>→</kbd> <kbd>Space</kbd> Navigera • <kbd>Home</kbd> Början • <kbd>Esc</kbd> Pausa
</div>

<script>
const slides = ', slide_json, ';
let currentSlide = 0;
let autoAdvanceTimer = null;
let isPaused = false;

const container = document.getElementById("slide-container");
const slideInfo = document.getElementById("slide-info");
const slideTitle = document.getElementById("slide-title");
const slideSubtitle = document.getElementById("slide-subtitle");
const slideCaption = document.getElementById("slide-caption");
const progressBar = document.getElementById("progress-bar");
const slideCounter = document.getElementById("slide-counter");
const prevBtn = document.getElementById("prev-btn");
const nextBtn = document.getElementById("next-btn");
const resetBtn = document.getElementById("reset-btn");
const welcomeScreen = document.getElementById("welcome-screen");
const startButton = document.getElementById("start-button");
const autoTimer = document.getElementById("auto-timer");
const timerSeconds = document.getElementById("timer-seconds");
const chaptersNav = document.getElementById("chapters");

// Preload media
slides.forEach(slide => {
  if (slide.type === "video") {
    const v = document.createElement("video");
    v.preload = "auto";
    v.src = slide.file;
  } else {
    const img = new Image();
    img.src = slide.file;
  }
});

// Build chapter navigation
const chapters = [...new Set(slides.map(s => s.chapter).filter(c => c))];
chapters.forEach(chapter => {
  const dot = document.createElement("div");
  dot.className = "chapter-dot";
  dot.dataset.chapter = chapter;
  dot.onclick = () => {
    const idx = slides.findIndex(s => s.chapter === chapter);
    if (idx !== -1) goToSlide(idx);
  };
  chaptersNav.appendChild(dot);
});

function updateSlide() {
  const slide = slides[currentSlide];
  container.innerHTML = "";

  let media;
  if (slide.type === "video") {
    media = document.createElement("video");
    media.src = slide.file;
    media.autoplay = true;
    media.muted = true;
    media.playsinline = true;
    media.onended = () => {
      if (slide.pause_after) clearAutoAdvance();
      else setTimeout(nextSlide, 500);
    };
  } else {
    media = document.createElement("img");
    media.src = slide.file;
  }

  media.className = "slide-media transition-" + slide.transition;
  media.onclick = nextSlide;
  container.appendChild(media);
  setTimeout(() => media.classList.add("active"), 50);

  slideTitle.textContent = slide.title;
  slideSubtitle.textContent = slide.subtitle;
  slideCaption.textContent = slide.caption;
  slideInfo.classList.toggle("show", !!(slide.title || slide.subtitle));

  slideCounter.textContent = `${currentSlide + 1} / ${slides.length}`;
  prevBtn.disabled = currentSlide === 0;
  nextBtn.disabled = currentSlide === slides.length - 1;

  progressBar.style.width = ((currentSlide + 1) / slides.length * 100) + "%";

  document.querySelectorAll(".chapter-dot").forEach(d => d.classList.remove("active"));
  if (slide.chapter) {
    const dot = document.querySelector(`[data-chapter="${slide.chapter}"]`);
    if (dot) dot.classList.add("active");
  }

  if (slide.duration && !isPaused) startAutoAdvance(slide.duration);
}

function startAutoAdvance(seconds) {
  clearAutoAdvance();
  let remaining = seconds;
  timerSeconds.textContent = remaining;
  autoTimer.style.display = "block";
  autoAdvanceTimer = setInterval(() => {
    remaining--;
    timerSeconds.textContent = remaining;
    if (remaining <= 0) {
      clearAutoAdvance();
      nextSlide();
    }
  }, 1000);
}

function clearAutoAdvance() {
  if (autoAdvanceTimer) {
    clearInterval(autoAdvanceTimer);
    autoAdvanceTimer = null;
    autoTimer.style.display = "none";
  }
}

function nextSlide() {
  if (currentSlide < slides.length - 1) {
    currentSlide++;
    updateSlide();
  }
}

function prevSlide() {
  clearAutoAdvance();
  if (currentSlide > 0) {
    currentSlide--;
    updateSlide();
  }
}

function goToSlide(idx) {
  clearAutoAdvance();
  currentSlide = Math.max(0, Math.min(idx, slides.length - 1));
  updateSlide();
}

function reset() {
  clearAutoAdvance();
  currentSlide = 0;
  updateSlide();
}

prevBtn.onclick = prevSlide;
nextBtn.onclick = nextSlide;
resetBtn.onclick = reset;
startButton.onclick = () => {
  welcomeScreen.classList.add("hidden");
  setTimeout(updateSlide, 500);
};

document.onkeydown = (e) => {
  if (!welcomeScreen.classList.contains("hidden")) {
    if (e.key === "Enter" || e.key === " ") {
      e.preventDefault();
      startButton.click();
    }
  } else {
    if (e.key === "ArrowRight" || e.key === " ") {
      e.preventDefault();
      nextSlide();
    } else if (e.key === "ArrowLeft") {
      e.preventDefault();
      prevSlide();
    } else if (e.key === "Home") {
      e.preventDefault();
      reset();
    } else if (e.key === "Escape") {
      isPaused = !isPaused;
      if (isPaused) clearAutoAdvance();
    }
  }
};
</script>
</body>
</html>')

  # Skriv fil
  output_file <- file.path(output_dir, "presentation.html")
  writeLines(html, output_file)

  cat(sprintf("✓ Presentation skapad: %s\n", output_file))
  cat(sprintf("  Öppna: file://%s\n\n", normalizePath(output_file, mustWork = FALSE)))
  cat("═══════════════════════════════════════════════════════════\n\n")

  return(invisible(output_file))
}


#' Konvertera befintliga filer till enhanced presentation
convert_to_enhanced <- function(
    image_dir,
    output_dir = NULL,
    titles = NULL,
    subtitles = NULL,
    chapters = NULL,
    durations = NULL,
    transitions = NULL,
    presentation_title = "3D Story",
    theme = "dark"
) {

  if (is.null(output_dir)) output_dir <- image_dir

  # Hitta filer
  files <- list.files(image_dir, pattern = "\\.(png|jpg|jpeg|mp4)$",
                      full.names = FALSE, ignore.case = TRUE)
  files <- sort(files)

  if (length(files) == 0) {
    stop("Inga filer hittades i: ", image_dir)
  }

  # Bygg slides
  slides <- lapply(seq_along(files), function(i) {
    list(
      file = files[i],
      type = if (grepl("\\.mp4$", files[i], ignore.case = TRUE)) "video" else "image",
      title = if (!is.null(titles) && i <= length(titles)) titles[i] else "",
      subtitle = if (!is.null(subtitles) && i <= length(subtitles)) subtitles[i] else "",
      chapter = if (!is.null(chapters) && i <= length(chapters)) chapters[i] else "",
      duration = if (!is.null(durations) && i <= length(durations)) durations[i] else 0,
      transition = if (!is.null(transitions) && i <= length(transitions)) transitions[i] else "fade"
    )
  })

  create_enhanced_presentation(
    slides,
    output_dir,
    title = presentation_title,
    theme = theme
  )
}


# NULL coalescing
`%||%` <- function(a, b) if (is.null(a)) b else a


# EXEMPEL ===================================================================

cat("\n═══════════════════════════════════════════════════════════\n")
cat("  ENHANCED CORRIDOR v2.0 - ANVÄNDNING\n")
cat("═══════════════════════════════════════════════════════════\n\n")

cat("SNABBSTART:\n\n")
cat('convert_to_enhanced(\n')
cat('  image_dir = "output/statistik_korridor",\n')
cat('  titles = c("Intro", "Data", "Analys"),\n')
cat('  chapters = c("Start", "Data", "Slutsats"),\n')
cat('  presentation_title = "Min Story"\n')
cat(')\n\n')

cat("MED FULL KONTROLL:\n\n")
cat('slides <- list(\n')
cat('  list(\n')
cat('    file = "01.png",\n')
cat('    title = "Välkommen",\n')
cat('    subtitle = "En resa genom data",\n')
cat('    chapter = "Intro",\n')
cat('    transition = "fade",\n')
cat('    duration = 5\n')
cat('  )\n')
cat(')\n')
cat('create_enhanced_presentation(slides, "output/story/")\n\n')

cat("═══════════════════════════════════════════════════════════\n\n")

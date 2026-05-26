# AutoCAD MatchZ 📐✈️

A fast, lightweight AutoLISP script for AutoCAD designed to streamline 3D drafting workflows. It maps geographic or layout objects (like blocks, circles, or lines) to their true 3D Z-elevation using nearby text references in a continuous, high-speed loop.

---

## 🛠️ The Problem It Solves

When preparing or updating site plans, survey data, or structural layouts, matching visual markers to their correct 3D elevation text can be incredibly tedious. Standard AutoCAD commands often fall short because:
1. **Lack of Entity Flexibility:** Traditional scripts expect standard AutoCAD `POINT` entities, completely breaking down if your layout uses custom symbols, crosshairs, blocks, or circles.
2. **Workflow Speed Bottlenecks:** Having to restart a command or copy-paste text data into the properties panel for hundreds of objects takes hours.
3. **Human Error / Fatigue:** With hundreds of identical layout icons on a screen, it is incredibly easy to lose track of which objects you already modified and which ones you missed.

**MatchZ** fixes all three of these bottlenecks at once.

---

## ✨ Features

- **Continuous Click Loop:** Instantly process hundreds of items back-to-back without ever needing to restart the command. 
- **Universal Object Support:** Works seamlessly on Blocks (`INSERT`), `CIRCLE` center points, and `LINE` segments instead of restricting you to standard AutoCAD points.
- **Visual Tracking:** Automatically changes the target object's color flag to **Green (Color Code 3)** the exact moment it moves, giving you an immediate visual confirmation of your progress.
- **Single-Hit Undo:** Wrapped in a clean undo group sequence. If you make a mistake or miss click, typing `U` once reverts your drawing back safely without erasing your entire session's progress.

---

## 🚀 How to Install and Run

### Method 1: Quick Run (Drag & Drop)
1. Download the `MatchZ.lsp` file from this repository.
2. Open your active drawing in AutoCAD.
3. **Drag and drop** the `MatchZ.lsp` file directly from your file explorer into the AutoCAD model space window.
4. Type `MATCHZ` into the command line and press **Enter**.

### Method 2: Permanent Load (Always Available)
1. Type `APPLOAD` into the AutoCAD command line and press **Enter**.
2. Under the **Startup Suite** section (bottom right), click the **Contents** briefcase icon.
3. Click **Add**, navigate to your downloaded `MatchZ.lsp` file, and select it.
4. Close out of the windows. The `MATCHZ` command will now automatically load every time you launch AutoCAD.

---

## 🕹️ How to Use It

1. Type `MATCHZ` and hit **Enter**.
2. Click your target object (e.g., your custom block symbol, line, or circle).
3. Click the text or mtext object displaying the numerical elevation.
4. *Boom!* The object instantly shifts to its true Z-axis height and turns green.
5. The command line will instantly prompt you for the next object. Keep clicking!
6. To exit the loop when finished, simply press **Enter** or **Esc**.

---

## 📜 License

This project is open-source and available under the **MIT License**. Feel free to use, modify, share, or build upon this code for personal or commercial projects. 

*Created out of real-world drafting frustration by **yoelhonig**.*

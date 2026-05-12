---
title: Enable bash-like Autocompletion, Autosuggestions, and Predictive IntelliSense in Windows PowerShell
date: 2026-02-02
categories: [utils]
tags:
  - PowerShell
  - Windows
  - PSReadLine
description: Enable bash-like Autocompletion, Autosuggestions, and Predictive IntelliSense in Windows PowerShell.
---

# How to Enable bash-like Autocompletion, Autosuggestions, and Predictive IntelliSense in Windows PowerShell

If you've ever used a modern IDE or the Zsh shell on Linux, you're likely used to **Predictive IntelliSense** — that "ghost text" that suggests your next command based on your history.

By default, the Windows PowerShell console feels a bit "old school," but with a few tweaks to the **PSReadLine** module, you can turn it into a high-productivity powerhouse. Here is how to set it up step-by-step.

---

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Step 1 — Update Your PowerShell Tools](#step-1-update-your-powershell-tools)
3. [Step 2 — Enable Predictions](#step-2-enable-predictions)
4. [Step 3 — Choose Your Visual Style](#step-3-choose-your-visual-style)
5. [Step 4 — Enable Tab Completion (Bash-style)](#step-4-enable-tab-completion-bash-style)
6. [Step 5 — Make It Permanent (The PowerShell Profile)](#step-5-make-it-permanent-the-powershell-profile)
7. [Bonus — HistoryAndPlugin (PowerShell 7+ Only)](#bonus-combine-history--plugin-predictions-powershell-7-only)
8. [Troubleshooting](#-troubleshooting-parameter-cannot-be-found)
9. [Quick Reference](#quick-reference)

---

## Prerequisites

Before you begin, make sure you have:

- **Windows PowerShell 5.1** (built into Windows 10/11) or **PowerShell 7+** (recommended)
- An internet connection to download the latest PSReadLine module
- Admin rights for the installation step

> **PowerShell 7 vs Windows PowerShell 5.1:** If you haven't already, consider upgrading to [PowerShell 7](https://github.com/PowerShell/PowerShell/releases). It ships with a much newer PSReadLine out of the box and offers better performance overall.

---

## Step 1: Update Your PowerShell Tools

The most common reason autocomplete fails is an outdated version of the **PSReadLine** module. Windows PowerShell 5.1 often ships with version 2.0.0 or older, which doesn't support modern predictions.

1. Right-click your **Start button** and select **Windows PowerShell (Admin)**.
2. Run the following command to install the latest version:

```powershell
Install-Module -Name PSReadLine -Force -Scope CurrentUser
```

3. If prompted to trust the repository, type **Y** and hit **Enter**.
4. **Restart PowerShell** to ensure the new version is loaded.

To confirm the installed version, run:

```powershell
Get-Module PSReadLine -ListAvailable
```

You should see version **2.2.6** or newer. Anything below 2.2.0 does not support `-PredictionSource`.

---

## Step 2: Enable Predictions

Now that your module is updated, you can turn on the history-based suggestions.

In your PowerShell window, run:

```powershell
Set-PSReadLineOption -PredictionSource History
```

As soon as you start typing a command you've used before, you will see a gray "ghost" suggestion appear to the right of your cursor.

### How to use it

| Action | Keybinding |
|---|---|
| Accept the full suggestion | `→` Right Arrow or `End` |
| Accept one word at a time | `Ctrl + →` |
| Dismiss the suggestion | `Escape` |
| Cycle through history | `↑` / `↓` Arrow keys |

---

## Step 3: Choose Your Visual Style

There are two ways to view suggestions. You can switch between them at any time by pressing **F2**.

### Option A: Inline View (Ghost Text)

This is the subtle, modern look where the suggestion sits right on your cursor line — similar to GitHub Copilot or the Fish shell.

```powershell
Set-PSReadLineOption -PredictionViewStyle InlineView
```

**Example:**

```
PS C:\> git commit -m "fix: update nginx config"|ghost text here
```

### Option B: List View (Drop-down Menu)

If you prefer a scrollable menu of possible matches drawn from your command history, use List View. This is more useful when you want to see multiple candidates at once.

```powershell
Set-PSReadLineOption -PredictionViewStyle ListView
```

**Example:**

```
PS C:\> git
> git commit -m "fix: update nginx config"   ← highlighted
  git pull origin main
  git status
```

Use the `↑` / `↓` arrow keys to navigate the list and `Enter` to select an entry.

> **Tip:** Press **F2** at any time to toggle between InlineView and ListView without running any command.

---

## Step 4: Enable Tab Completion (Bash-style)

By default, PowerShell cycles through completions one at a time on `Tab`. You can enable a more bash-like behavior where pressing `Tab` opens an inline menu of all matches:

```powershell
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
```

Alternatively, for strict bash-style behavior — complete the longest common prefix first, then list remaining matches — use:

```powershell
Set-PSReadLineKeyHandler -Key Tab -Function Complete
```

---

## Step 5: Make It Permanent (The PowerShell Profile)

If you close PowerShell now, your settings will be lost. To keep them permanently, add them to your **Profile script** — PowerShell's equivalent of `.bashrc`.

1. Open your profile in Notepad:

```powershell
notepad $PROFILE
```

2. If Notepad asks to create a new file, click **Yes**.

3. Paste the following configuration block into the file:

```powershell
# ─── PSReadLine Configuration ────────────────────────────────────────────────

# Ensure the latest PSReadLine module is loaded
Import-Module PSReadLine

# Enable history-based inline predictions (like Fish shell / GitHub Copilot)
Set-PSReadLineOption -PredictionSource History

# Set default view to Inline ghost text (switch to ListView if you prefer a menu)
Set-PSReadLineOption -PredictionViewStyle InlineView

# Use Up/Down arrows to search history matching the current typed prefix
Set-PSReadLineKeyHandler -Key UpArrow   -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# Tab: show a menu of all completions (bash-style)
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# Ctrl+D closes the shell (like bash/zsh)
Set-PSReadLineKeyHandler -Key Ctrl+d -Function DeleteCharOrExit

# ─────────────────────────────────────────────────────────────────────────────
```

4. **Save** (`Ctrl+S`) and close Notepad.

5. Reload your profile without restarting PowerShell:

```powershell
. $PROFILE
```

> **What is `$PROFILE`?** It is an automatic variable pointing to your personal PowerShell profile script, typically located at `C:\Users\<YourName>\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1`. This script runs automatically every time a new PowerShell session starts.

---

## Bonus: Combine History + Plugin Predictions (PowerShell 7+ Only)

If you are on PowerShell 7, you can set `PredictionSource` to `HistoryAndPlugin`. This merges your command history with predictions from PSReadLine-aware plugins such as the **Az** module:

```powershell
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
```

Add this to your `$PROFILE` in place of the `History`-only line if you want the richer prediction source.

---

## 🛠 Troubleshooting: "Parameter Cannot Be Found"

If you see an error saying `-PredictionSource` cannot be found, your system is still loading the old bundled version of PSReadLine.

**The Fix:**

Check what versions are installed:

```powershell
Get-Module PSReadLine -ListAvailable
```

If you see two versions (e.g., 2.0.0 and 2.3.x), PowerShell may be loading the older one from the system path first. Force-import the newer one explicitly:

```powershell
Import-Module PSReadLine -MinimumVersion 2.2.0 -Force
```

If that still doesn't work, you may need to remove the old system-level version. Open **File Explorer as Administrator** and delete the folder at:

```
C:\Program Files\WindowsPowerShell\Modules\PSReadLine\2.0.0\
```

Then restart PowerShell and confirm with:

```powershell
Get-Module PSReadLine -ListAvailable
```

---

## Quick Reference

| Command | What It Does |
|---|---|
| `Install-Module -Name PSReadLine -Force -Scope CurrentUser` | Install or update PSReadLine |
| `Get-Module PSReadLine -ListAvailable` | Check installed version |
| `Set-PSReadLineOption -PredictionSource History` | Enable history predictions |
| `Set-PSReadLineOption -PredictionViewStyle InlineView` | Ghost text mode |
| `Set-PSReadLineOption -PredictionViewStyle ListView` | Drop-down list mode |
| `F2` | Toggle between InlineView and ListView |
| `notepad $PROFILE` | Open your profile to make changes permanent |
| `. $PROFILE` | Reload profile without restarting |

---

**Happy Coding!** Your PowerShell experience should now feel much faster and more intuitive — almost indistinguishable from a modern terminal on Linux.
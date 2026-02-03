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

If you’ve ever used a modern IDE or the Zsh shell on Linux, you’re likely used to **Predictive IntelliSense**—that "ghost text" that suggests your next command based on your history.

By default, the Windows PowerShell console feels a bit "old school," but with a few tweaks to the **PSReadLine** module, you can turn it into a high-productivity powerhouse. Here is how to set it up step-by-step.

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

---

## Step 2: Enable Predictions

Now that your module is updated, you can turn on the history-based suggestions.

In your PowerShell window, type:

```powershell
Set-PSReadLineOption -PredictionSource History

```

As soon as you start typing a command you've used before, you will see a gray "ghost" suggestion.

### How to use it:

* **To accept the suggestion:** Press the **Right Arrow ()** or the **End** key.
* **To accept word-by-word:** Press **Ctrl + Right Arrow ()**.

---

## Step 3: Choose Your Visual Style

There are two ways to view these suggestions. You can switch between them at any time by pressing **F2**.

### Option A: Inline View (The Ghost Text)

This is the subtle, modern look where the suggestion sits right on your cursor line.

```powershell
Set-PSReadLineOption -PredictionViewStyle InlineView

```

### Option B: List View (The Drop-down)

If you prefer a menu of possible matches from your history, use List View.

```powershell
Set-PSReadLineOption -PredictionViewStyle ListView

```

---

## Step 4: Make it Permanent (The PowerShell Profile)

If you close PowerShell now, your settings will be lost. To keep them forever, you need to add them to your **Profile script**.

1. In PowerShell, type: `notepad $PROFILE`
2. If Notepad asks to create a new file, click **Yes**.
3. Paste the following code into the Notepad file:
```powershell
# Ensure the latest PSReadLine is used
Import-Module PSReadLine

# Enable History-based suggestions
Set-PSReadLineOption -PredictionSource History

# Set the default view to Inline (Change to ListView if preferred)
Set-PSReadLineOption -PredictionViewStyle InlineView

# Bonus: Use Up/Down arrows to search through history matches only
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

```


4. **Save** and close Notepad.

---

## 🛠 Troubleshooting: "Parameter Cannot Be Found"

If you see an error saying `-PredictionSource` cannot be found, your system is still trying to use the old version of PSReadLine.

**The Fix:** Run `Get-Module PSReadLine -ListAvailable` to see if you have multiple versions. If you do, ensure you have followed **Step 1** above. You may need to manually delete the older folder version located in `C:\Program Files\WindowsPowerShell\Modules\PSReadLine` (requires Admin).

---

**Happy Coding!** Your PowerShell experience should now feel much faster and more intuitive.

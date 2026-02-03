---
title: Essential GNU Nano Text Editor Key Bindings
date: 2025-10-18
categories: [linux]
tags:
  - Nano
description: Essential GNU Nano Text Editor Key Bindings.
---



[View full cheat -sheet](https://linuxsimply.com/cheat-sheets/nano/)

***

# Essential GNU Nano Text Editor Key Bindings

Nano is a user-friendly, command-line text editor known for its simplicity. Its key bindings are displayed at the bottom of the screen, but knowing the most useful ones by heart will make you much faster.

> **Note:** In Nano, the `^` symbol represents the **Ctrl** key. So `^X` means `Ctrl+X`. The `M-` symbol represents the **Meta** key, which is usually **Alt** or **Esc**.

## Basic File Operations

| Key Binding | Description |
| :--- | :--- |
| `Ctrl + X` | **Exit** Nano. It will prompt to save if the buffer is modified. |
| `Ctrl + O` | **Write (Save)** the current file to disk. You will be prompted for a filename. |
| `Ctrl + S` | **Save** the file without prompting (works in many cases). |
| `Ctrl + R` | **Insert** another file into the current one. |
| `Ctrl + T` | **Spell Check** the text (if spell check is supported). |

## Cursor Navigation

| Key Binding | Description |
| :--- | :--- |
| `Ctrl + F` | Move cursor **Forward** one character. |
| `Ctrl + B` | Move cursor **Back** one character. |
| `Ctrl + P` | Move to the **Previous** line. |
| `Ctrl + N` | Move to the **Next** line. |
| `Ctrl + A` | Move to the **Beginning** of the current line. |
| `Ctrl + E` | Move to the **End** of the current line. |
| `Ctrl + Space` | Move forward one **word**. |
| `Alt + Space` | Move backward one **word**. |
| `Ctrl + _` | **Go to** specific line and column number. |
| `Ctrl + \` | **Search** for a string (pattern). `Alt + W` to find next. |

## Text Editing

| Key Binding | Description |
| :--- | :--- |
| `Ctrl + D` | **Delete** the character under the cursor. |
| `Ctrl + H` | **Delete** the character to the left of the cursor (Backspace). |
| `Ctrl + K` | **Cut** the entire current line (or marked region). |
| `Ctrl + U` | **Paste (Uncut)** the last cut line(s) at the cursor position. |
| `Alt + U` | **Undo** the last action. |
| `Alt + E` | **Redo** the last undone action. |
| `Alt + A` | Start **marking (selecting)** text. Use navigation keys to highlight. |
| `Alt + 6` | **Copy** the marked text instead of cutting it. |
| `Alt + T` | **Cut** until the end of the file from the cursor. |

## Advanced Operations

| Key Binding | Description |
| :--- | :--- |
| `Ctrl + C` | **Show Cursor Position** (line/column/character count). |
| `Ctrl + G` | **Show Help** (displays all key bindings!). |
| `Alt + 3` | **Comment/Uncomment** the current line (or marked region). |
| `Alt + Y` | **Syntax Highlighting** on/off. |
| `Alt + P` | **Show/Hide** the formatting toolbar at the bottom. |
| `Alt + X` | **Show/Hide** the help lines at the bottom. |
| `Alt + C` | **Show/Hide** the cursor position in real-time. |
| `Tab` | **Indent** the current line (or marked region). |
| `Shift + Tab` | **Unindent** the current line (or marked region). |

## Search and Replace

| Key Binding | Description |
| :--- | :--- |
| `Ctrl + W` | **Search** for a string. |
| `Alt + W` | **Find Next** occurrence after a search. |
| `Ctrl + \` | **Search and Replace**. You will be prompted for the search term and its replacement. |

## Pro Tips for Nano

*   **The Ultimate Shortcut:** Press `Ctrl + G` to open the full help menu anytime you forget a command.
*   **Multiple Cuts:** You can press `Ctrl + K` multiple times in a row to cut multiple lines, and then paste them all at once with a single `Ctrl + U`.
*   **Navigation Confusion?** Remember the mnemonics: `P` for Previous (up), `N` for Next (down). `F`=Forward, `B`=Backward.
*   **To Save and Exit Quickly:** It's just two keys: `Ctrl + X` followed by `Y` (for Yes) and then `Enter` to confirm the filename.

These bindings will help you navigate and edit files in Nano with much greater speed and confidence.
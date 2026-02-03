---
title: Vim cheatsheet
date: 2025-09-29
categories: [linux]
tags:
  - vim
description: Vim cheatsheet
---


Here is a curated list of essential, real-world Vim commands. This list avoids esoteric tips and focuses on the core commands that form the daily workflow of developers, DevOps engineers, and sysadmins.

### Navigation (The Foundation)

You can't fix a server config or refactor code if you can't move around efficiently.

*   **`h` `j` `k` `l`** - Basic movement (left, down, up, right). Muscle memory for this is non-negotiable.
*   **`w`** - Move forward one **word** (punctuation considered words).
*   **`b`** - Move backward one **word**.
*   **`W`** - Move forward one **WORD** (ignores punctuation).
*   **`B`** - Move backward one **WORD**.
*   **`0`** - Move to the very **beginning** of the line.
*   **`^`** - Move to the first **non-blank character** of the line.
*   **`$`** - Move to the **end** of the line.
*   **`gg`** - Go to the **first line** of the file.
*   **`G`** - Go to the **last line** of the file.
*   **`[Line Number]G`** - Go to a specific line number (e.g., `50G` goes to line 50). Essential for reading log files and compiler errors.
*   **`Ctrl + f`** - Page **Forward** (Page Down).
*   **`Ctrl + b`** - Page **Backward** (Page Up).
*   **`%`** - Jump to the matching **brace/bracket/parenthesis** (`{ } [ ] ( )`). Incredibly useful for code blocks and conditionals.

### Editing & Text Manipulation

This is where Vim's power becomes obvious for quick edits.

*   **`i`** - Enter **Insert** mode at the cursor.
*   **`a`** - Enter **Insert** mode **after** the cursor.
*   **`A`** - Enter **Insert** mode at the **end of the line**.
*   **`o`** - Open a new line **below** the current line and enter Insert mode.
*   **`O`** - Open a new line **above** the current line and enter Insert mode.
*   **`r`** - **Replace** a single character under the cursor (e.g., `r[char]`).
*   **`x`** - **Delete** the character under the cursor (like Delete key).
*   **`dd`** - **Delete (cut)** the current line.
*   **`yy`** - **Yank (copy)** the current line.
*   **`p`** - **Paste** the yanked/deleted text **after** the cursor.
*   **`P`** - **Paste** the yanked/deleted text **before** the cursor.
*   **`u`** - **Undo** the last change.
*   **`Ctrl + r`** - **Redo**.
*   **`.`** - **Repeat** the last command. This is a massive productivity booster.

### Powerful Editing (Combining Motion)

This is the "Verb + Noun" philosophy that makes Vim legendary.

*   **`d[motion]`** - Delete text defined by a motion.
    *   `dw` - Delete from cursor to start of next word.
    *   `d$` or `D` - Delete from cursor to end of line.
    *   `d^` - Delete from cursor to first non-blank of line.
    *   `dt[char]` - Delete **until** the specified character (e.g., `dt"` deletes until the next quote).
    *   `dd` - Delete the entire line (a special case of `d[motion]`).
*   **`c[motion]`** - **Change** (delete and enter Insert mode) text defined by a motion.
    *   `cw` - Change word. This is used *constantly* for renaming variables.
    *   `c$` - Change to the end of the line.
    *   `cc` - Change the entire line.
*   **`y[motion]`** - Yank (copy) text defined by a motion.
    *   `yw` - Yank word.
    *   `y$` - Yank to end of line.
    *   `yy` - Yank the entire line.

### Searching and Replacing (The Sysadmin's Best Friend)

Crucial for analyzing logs, debugging configs, and refactoring code.

*   **`/[pattern]`** - Search **forward** for a pattern (e.g., `/error`).
*   **`?[pattern]`** - Search **backward** for a pattern.
*   **`n`** - Repeat the last search in the **same** direction.
*   **`N`** - Repeat the last search in the **opposite** direction.
*   **`*`** - Search for the **word under the cursor** (forward). Perfect for finding all uses of a variable/function.
*   **`#`** - Search for the **word under the cursor** (backward).
*   **`:%s/old/new/g`** - **Global search and replace** in the entire file. The workhorse command.
    *   `:%s/old/new/gc` - Same, but with a **confirmation** for each replace. *Always use this first to be safe!*
    *   `:s/old/new/g` - Search and replace only in the **current line**.

### File and Window Management

Essential for working with multiple files, which is a daily task.

*   **`:e [file]`** - **Edit** a file (e.g., `:e /etc/hosts`). You can use tab completion.
*   **`:w`** - **Write (save)** the file.
*   **`:q`** - **Quit**.
*   **`:q!`** - **Quit without saving** (force quit).
*   **`:wq`** or **`ZZ`** - Write and quit.
*   **`:vsp [file]`** - Open a file in a **vertical split**.
*   **`:sp [file]`** - Open a file in a **horizontal split**.
*   **`Ctrl + w + w`** - Switch between open windows/splits.
*   **`:ls`** - List all open buffers (files).

### Visual Mode (For Selecting Blocks of Text)

*   **`v`** - Enter **character-wise** Visual mode.
*   **`V`** - Enter **line-wise** Visual mode.
*   **`Ctrl + v`** - Enter **block-wise** Visual mode. *Extremely useful for commenting out multiple lines or editing columns of text.*
*   Once in Visual mode, use navigation keys (`j`, `k`, `w`, `$`) to select text, then apply a command:
    *   `d` - Delete the selection.
    *   `y` - Yank the selection.
    *   `:` - Apply a command to the selection (e.g., `:'<,'>s/foo/bar/g` to replace only in the selected lines).

### Real-World Scenarios

1.  **Quick Log Analysis:** `vim /var/log/syslog`. You see an error on line 1050. `1050G` to jump right to it. Search for all occurrences of "timeout": `/timeout` then press `n` to cycle through them.
2.  **Editing a Config:** You need to change a port number in `nginx.conf`. Find the line with `/listen`. Use `cw` to delete the old number and type the new one. Save and quit with `:wq`.
3.  **Refactoring a Variable:** You need to rename a function parameter from `user_id` to `accountId`. Put your cursor on `user_id` and press `*` to find all instances. At each one, press `cw`, type `accountId`, and press `Esc`. Then press `n` to go to the next occurrence and `.` to repeat the change.
4.  **Commenting out a Block:** You need to disable a section of a Python script. Move to the top of the block, press `Ctrl + v`, use `j` to select down, then press `I` (capital I), type `#`, and press `Esc`. The `#` will appear on every selected line.

Master these commands, and you will be significantly more efficient in any text-editing task on a server or your local machine. This is the core Vim that professionals use every day.
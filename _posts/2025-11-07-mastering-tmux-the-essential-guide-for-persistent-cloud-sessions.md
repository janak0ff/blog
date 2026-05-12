---
title: Mastering Tmux - The Essential Guide for Persistent Cloud Sessions
date: 2025-11-07
categories: [linux]
tags:
  - Hands On Lab
  - Linux
  - Tmux
description: Stop losing work! Learn how to use tmux to keep long-running processes alive on a cloud server, even after your SSH connection drops. Complete beginner's guide to sessions, windows, and panes.
---

# Mastering Tmux - The Essential Guide for Persistent Cloud Sessions

Stop losing work! Learn how to use tmux to keep long-running processes alive on a cloud server, even after your SSH connection drops. Complete beginner's guide to sessions, windows, panes, scrolling, and more.

---

## Part 1: Tmux Fundamentals and Session Persistence

### 1. What is Tmux?

Tmux is a **terminal multiplexer**. It creates a persistent shell that runs on your cloud server, independent of your local SSH connection.

| Feature | Benefit |
| :--- | :--- |
| **Persistence** | Processes continue to run after you disconnect. |
| **Resilience** | Your work is safe from unstable Wi-Fi or accidental shutdowns. |
| **Organization** | Manage multiple terminal windows and splits within a single session. |
| **Multiplexing** | Run multiple terminals side-by-side in a single SSH connection. |

### 2. Installation

Install tmux on your cloud server using your distribution's package manager:

```bash
# For Debian/Ubuntu
sudo apt update && sudo apt install tmux

# For CentOS/RHEL
sudo yum install tmux

# Verify installation and version
tmux -V
```

### 3. The Prefix Key

All tmux keyboard shortcuts start with the **Prefix Key**: **`Ctrl + b`**. Press and **release** this combination before pressing any command key.

> **Tip:** The prefix key can be customized in `~/.tmux.conf`. Many users change it to `Ctrl + a` (similar to GNU Screen) for comfort.

### 4. Session Management: Named vs. Unnamed

Tmux sessions can be handled in two ways: named (recommended for clarity) or unnamed (automatically numbered).

| Action | Named Session (e.g., `myproject`) | Unnamed Session (e.g., `0`, `1`) |
| :--- | :--- | :--- |
| **Create New** | `tmux new -s myproject` | `tmux new` / `tmux` |
| **Detach** | `Ctrl + b` then `d` | `Ctrl + b` then `d` |
| **List All** | `tmux list-sessions` / `tmux ls` | `tmux list-sessions` / `tmux ls` |
| **Reattach** | `tmux attach -t myproject` / `tmux a -t myproject` | `tmux attach -t 0` / `tmux a -t 0` |
| **Reattach (First Available)** | N/A | `tmux attach` / `tmux a` |
| **Rename Session** | `tmux rename-session -t old new` | `Ctrl + b` then `$` |
| **Kill Session** | `tmux kill-session -t myproject` | `tmux kill-session -t 0` |

**Note on Unnamed Reattach:** If you have multiple unnamed sessions (e.g., `0`, `1`, `2`), you **must** use the `-t` flag with the specific number (`tmux a -t 2`). If you only use `tmux a` with multiple sessions, it will usually connect to the oldest or numerically lowest one.

### 5. Switching Between Sessions

When you have multiple sessions running, you can switch between them without detaching and reattaching.

| Action | Shortcut / Command | Description |
| :--- | :--- | :--- |
| **Interactive Session List** | `Ctrl + b` then `s` | Opens a tree view of all sessions and windows. Use arrow keys to navigate, `Enter` to switch. |
| **Next Session** | `Ctrl + b` then `)` | Switches to the next session in the list. |
| **Previous Session** | `Ctrl + b` then `(` | Switches to the previous session in the list. |
| **Switch by Name (CLI)** | `tmux switch -t myproject` | Switch to a named session from within any session. |
| **Last Active Session** | `Ctrl + b` then `L` | Toggles back to the last session you were in (very handy!). |

> **Pro Tip:** `Ctrl + b` then `s` is the most powerful navigation shortcut — it shows a collapsible tree of **all sessions → windows → panes** and lets you jump anywhere instantly.

### 6. Running Your Process

Once you are inside a session (named or unnamed), you can safely run any long command:

```bash
python3 train_model.py     # This process will continue after you detach!
ansible-playbook site.yml  # Long playbook runs safely
./db_migration.sh          # Database migrations without timeout fear
```

Detach from the session with `Ctrl + b` then `d` — your process keeps running on the server.

### 7. Killing a Session

When your process is complete, terminate the session to free up resources.

| Method | Command |
| :--- | :--- |
| **From Outside** | `tmux kill-session -t [name or number]` |
| **Kill All Sessions** | `tmux kill-server` |
| **From Inside** (single pane) | `Ctrl + b` then `x` (confirm with `y`) |
| **Type exit** | `exit` or `Ctrl + d` inside the pane |

---

## Part 2: Advanced Organization with Windows and Panes

Tmux allows you to organize your terminal space using two main levels of hierarchy: **Windows** (like browser tabs) and **Panes** (like split screens within a tab).

### 1. Window Management (The Tabs)

| Task | Shortcut (After `Ctrl + b`) | Description |
| :--- | :--- | :--- |
| **Create New Window** | `c` | Creates a new, empty window and switches you to it. |
| **Switch to Next Window** | `n` | Moves to the window with the next sequential number. |
| **Switch to Previous Window** | `p` | Moves to the window with the previous number. |
| **Switch by Index** | `0` to `9` | Directly switches to the window by its number. |
| **List Windows** | `w` | Opens an interactive list of all windows in the session. |
| **Rename Window** | `,` (Comma) | Opens the command prompt to type a new name. |
| **Find Window** | `f` | Search for a window by name or content. |
| **Move to Last Window** | `l` (lowercase L) | Toggles to the last active window. |
| **Close (Kill) Window** | `&` (Ampersand) | Kills the current window and all panes inside it (confirm: `y`). |

### 2. Pane Management (The Splits)

Panes split a single window into multiple independent terminal views (e.g., viewing logs while editing code).

| Task | Shortcut (After `Ctrl + b`) | Description |
| :--- | :--- | :--- |
| **Split Vertically** | `%` (Percent) | Splits the current pane into two side-by-side (left/right). |
| **Split Horizontally** | `"` (Double Quote) | Splits the current pane into a top and bottom pane. |
| **Switch Panes (Arrow)** | `<Arrow Key>` | Changes focus to the adjacent pane. |
| **Switch Panes (Cycle)** | `o` | Cycles through all panes in the current window. |
| **Show Pane Numbers** | `q` | Briefly displays the index number of each pane. |
| **Swap Pane Forward** | `}` | Swaps the current pane with the next one. |
| **Swap Pane Backward** | `{` | Swaps the current pane with the previous one. |
| **Zoom Pane** | `z` | Toggles the active pane to fill the entire window temporarily. |
| **Convert Pane to Window** | `!` | Breaks the current pane out into its own window. |
| **Resize Pane** | `Ctrl + <Arrow Key>` | Resize pane in the direction of the arrow (hold to repeat). |
| **Close (Kill) Pane** | `x` | Kills the currently active pane (confirm: `y`). |

---

## Part 3: Scrolling and Copy Mode

This is one of the most important — and most overlooked — features of tmux. By default, your mouse scroll and `PgUp`/`PgDn` keys don't work inside a tmux pane. You need **Copy Mode** to scroll through history.

### 1. Entering and Exiting Copy Mode

| Action | Shortcut |
| :--- | :--- |
| **Enter Copy Mode** | `Ctrl + b` then `[` |
| **Exit Copy Mode** | `q` or `Esc` |

Once inside Copy Mode, your pane becomes a read-only scrollable buffer. The cursor is now yours to navigate freely.

### 2. Navigation in Copy Mode

Copy Mode uses **vi-style** key bindings by default (you can switch to emacs bindings in config).

| Action | Vi Keys | Emacs Keys |
| :--- | :--- | :--- |
| **Scroll Up (line)** | `k` | `Up Arrow` |
| **Scroll Down (line)** | `j` | `Down Arrow` |
| **Scroll Up (half page)** | `Ctrl + u` | `Alt + v` |
| **Scroll Down (half page)** | `Ctrl + d` | — |
| **Scroll Up (full page)** | `Ctrl + b` | `v` (page up) |
| **Scroll Down (full page)** | `Ctrl + f` | — |
| **Jump to Top (oldest output)** | `g` | `Alt + <` |
| **Jump to Bottom (newest output)** | `G` | `Alt + >` |
| **Search Upward** | `/` then type, `n` to repeat | `Ctrl + r` |
| **Search Downward** | `?` then type, `n` to repeat | `Ctrl + s` |

> **Quick Scroll Tip:** You can also use `PgUp` to enter copy mode AND scroll up in one keystroke — no prefix key needed!

### 3. Copying Text in Copy Mode

| Action | Vi Keys |
| :--- | :--- |
| **Start Selection** | `Space` (move cursor to extend) |
| **Copy Selection** | `Enter` |
| **Paste Copied Text** | `Ctrl + b` then `]` |

> **Note:** Copied text goes into tmux's internal buffer, not your system clipboard. To integrate with the system clipboard, tools like `xclip` or `xsel` (Linux) are commonly used with a custom binding in `~/.tmux.conf`.

### 4. Enable Mouse Scrolling (Recommended)

If you prefer scrolling with your mouse wheel, add this to your `~/.tmux.conf`:

```bash
set -g mouse on
```

Then reload the config:

```bash
tmux source-file ~/.tmux.conf
# Or from inside tmux: Ctrl + b then :source-file ~/.tmux.conf
```

With mouse mode on, you can scroll, click to switch panes, and even resize panes by dragging borders.

---

## Part 4: The Command Prompt and Configuration

### 1. The Tmux Command Prompt

Every tmux shortcut has a longer command-line equivalent. Access the prompt from inside tmux:

**`Ctrl + b` then `:` (colon)**

This opens a command bar at the bottom of the screen. Useful commands to run here:

```
:new-window                      # Create a new window
:rename-window dev               # Rename current window to 'dev'
:split-window -h                 # Split horizontally
:split-window -v                 # Split vertically
:kill-session                    # Kill the current session
:source-file ~/.tmux.conf        # Reload config without restarting
:set -g mouse on                 # Enable mouse mode on the fly
:list-keys                       # Show all key bindings
```

### 2. Useful `~/.tmux.conf` Settings

Create or edit `~/.tmux.conf` to persist your preferences:

```bash
# Change prefix to Ctrl + a (optional, screen-like)
# unbind C-b
# set -g prefix C-a
# bind C-a send-prefix

# Enable mouse support
set -g mouse on

# Increase scroll-back history (default is 2000 lines)
set -g history-limit 10000

# Start window and pane numbering from 1 (easier keyboard reach)
set -g base-index 1
setw -g pane-base-index 1

# Enable 256-color support
set -g default-terminal "screen-256color"

# Reload config with Ctrl + b then r
bind r source-file ~/.tmux.conf \; display "Config reloaded!"

# Split panes using | and - (more intuitive than % and ")
bind | split-window -h
bind - split-window -v
```

After editing, reload without restarting:

```bash
tmux source-file ~/.tmux.conf
```

---

## Part 5: Practical Workflow Example

Here's a real-world DevOps workflow using everything above:

```bash
# 1. SSH into your server
ssh user@your-server

# 2. Create a named session for your project
tmux new -s deployment

# 3. Split into two panes: top for commands, bottom for logs
# Ctrl + b then "

# 4. In top pane: run your deployment
ansible-playbook -i inventory site.yml

# 5. Switch to bottom pane (Ctrl + b then arrow down)
# Tail logs in real time
tail -f /var/log/app/deploy.log

# 6. Open a new window for monitoring
# Ctrl + b then c
htop

# 7. Detach safely — everything keeps running!
# Ctrl + b then d

# 8. Come back later and reattach
tmux a -t deployment

# 9. Scroll up to review output
# Ctrl + b then [  →  use Ctrl+u / Ctrl+d to scroll  →  q to exit
```

---

## Quick Reference Cheat Sheet

### Sessions
| Action | Command / Shortcut |
| :--- | :--- |
| New named session | `tmux new -s name` |
| List sessions | `tmux ls` |
| Attach to session | `tmux a -t name` |
| Detach | `Ctrl + b` → `d` |
| Switch sessions (interactive) | `Ctrl + b` → `s` |
| Next / Previous session | `Ctrl + b` → `)` / `(` |
| Last session | `Ctrl + b` → `L` |
| Rename session | `Ctrl + b` → `$` |
| Kill session | `tmux kill-session -t name` |

### Windows
| Action | Shortcut |
| :--- | :--- |
| New window | `Ctrl + b` → `c` |
| Next / Prev window | `Ctrl + b` → `n` / `p` |
| Switch by number | `Ctrl + b` → `0–9` |
| Rename window | `Ctrl + b` → `,` |
| List windows | `Ctrl + b` → `w` |
| Kill window | `Ctrl + b` → `&` |

### Panes
| Action | Shortcut |
| :--- | :--- |
| Split vertical (left/right) | `Ctrl + b` → `%` |
| Split horizontal (top/bottom) | `Ctrl + b` → `"` |
| Navigate panes | `Ctrl + b` → Arrow keys |
| Zoom / unzoom pane | `Ctrl + b` → `z` |
| Kill pane | `Ctrl + b` → `x` |

### Scrolling & Copy Mode
| Action | Shortcut |
| :--- | :--- |
| Enter copy mode | `Ctrl + b` → `[` |
| Exit copy mode | `q` |
| Scroll up / down (half page) | `Ctrl + u` / `Ctrl + d` |
| Jump to top / bottom | `g` / `G` |
| Search | `/` (up) or `?` (down) |
| Start/end selection | `Space` / `Enter` |
| Paste | `Ctrl + b` → `]` |
| Quick scroll (no prefix) | `PgUp` |

---

## Summary: Why Tmux is Essential

Tmux is the ultimate safety net for every remote professional. Using a named session for a specific project guarantees that your long-running script, training job, or deployment will never be killed by an unstable network connection. Combined with windows for organization, panes for multitasking, and copy mode for reviewing output, it transforms your server connection into a reliable, professional-grade workspace — all within a single SSH connection.
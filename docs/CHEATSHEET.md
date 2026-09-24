# Emacs Cheatsheet

This document contains the essential keybindings for my Emacs configuration.

## Core Concepts

- **Buffer**: A file opened in Emacs.
- **Window**: A visual pane showing a buffer. You can split the frame into multiple windows.
- **Frame**: What most editors call a "window" (the whole GUI/Terminal window).
- **Point**: The cursor position.
- **Region**: Selected text (like in other editors).

## Basic Editing (CUA Mode)

| Keybinding | Action |
| :--- | :--- |
| `C-x` | Cut (if region is active) |
| `C-c` | Copy (if region is active) |
| `C-v` | Paste (yank) |
| `C-z` | Undo |
| `C-y` | Redo (in CUA mode) |
| `C-SPC` | Set mark (start selection) |
| `C-x h` | Select entire buffer |
| `C-;` | Toggle comment on line |
| `C-g` | Cancel current command |

## File & Buffer Management

| Keybinding | Action |
| :--- | :--- |
| `C-x C-f` | Find file (open) |
| `C-x C-s` | Save file |
| `C-x C-c` | Quit Emacs |
| `C-x b` | Switch buffer (Ivy) |
| `C-x C-b` | List all buffers (ibuffer) |
| `C-x k` | Kill (close) current buffer |
| `C-x d` | Open Dired (file manager) |
| `C-x C-j` | Jump to Dired buffer for current file |

## Window Management (Tmux-like)

| Keybinding | Action |
| :--- | :--- |
| `M-o` | Switch to other window |
| `C-x 0` | Delete all other windows |
| `C-x 2` | Split window below |
| `C-x 3` | Split window right |
| `C-x 1` | Close current window |

## Navigation

| Keybinding | Action |
| :--- | :--- |
| `C-s` | Search in current buffer (Swiper) |
| `C-c s` | Search in project (counsel-rg, requires ripgrep) |
| `M-x` | Run any command (counsel-M-x) |
| `C-a` / `C-e` | Beginning/End of line |
| `M-<` / `M->` | Beginning/End of buffer |
| `C-v` / `M-v` | Page Down / Page Up |
| `M-f` / `M-b` | Forward/Backward word |

## Project Management (Projectile)

| Keybinding | Action |
| :--- | :--- |
| `C-c p f` | Find file in project |
| `C-c p p` | Switch project |
| `C-c p s` | Search in project |
| `C-c p k` | Kill project buffers |

## Git (Magit)

| Keybinding | Action |
| :--- | :--- |
| `C-c g` | Open Magit status |
| `s` | Stage file (in Magit) |
| `c` | Commit (in Magit) |
| `P` | Push (in Magit) |

## Dired (File Manager)

| Keybinding | Action |
| :--- | :--- |
| `Enter` | Open file or directory |
| `q` | Quit Dired |
| `+` | Create directory |
| `C` | Copy file |
| `R` | Rename/Move file |
| `D` | Delete file |
| `m` | Mark file |
| `u` | Unmark file |
| `U` | Unmark all files |
| `d` | Flag file for deletion |
| `x` | Execute flagged deletions |

## Org Mode

| Keybinding | Action |
| :--- | :--- |
| `C-c l` | Store link |
| `C-c a` | Open Agenda |
| `C-c c` | Capture |
| `TAB` | Fold/unfold current heading |
| `S-TAB` | Fold/unfold all headings |

## System Monitor (Symon)

The mode line shows:
- **CPU**: CPU load percentage
- **MEM**: Memory usage percentage
- These update every few seconds.

## Custom Keybindings

| Keybinding | Action |
| :--- | :--- |
| `C-c d` | Insert today's date (requires custom function) |
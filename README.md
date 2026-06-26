# Dotfiles

A terminal-first workstation setup managed with [GNU Stow](https://www.gnu.org/software/stow/). One command installs the tools, stows the configs, and gets you running.

## What's Included

| Tool | Purpose |
|------|---------|
| **Zsh** | Shell with completions, history, aliases |
| **Starship** | Cross-shell prompt |
| **Neovim** | Text editor |
| **Kitty** | GPU-accelerated terminal emulator |
| **Yazi** | Terminal file manager |
| **Atuin** | Shell history with sync & search |
| **Lazygit** | Terminal UI for git |
| **Bottom** | System monitor (top alternative) |
| **Eza** | Modern `ls` replacement |
| **Bat** | Modern `cat` replacement |
| **Ripgrep** | Fast `grep` replacement |
| **fd** | Fast `find` replacement |
| **fzf** | Fuzzy finder |
| **Zoxide** | Smarter `cd` replacement |
| **jq** | JSON processor |

## Quick Start

### 1. Clone

```bash
git clone https://github.com/emperorsixpacks/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Run the Installer

```bash
bash install.sh
```

This will:
- Detect your package manager (`dnf`, `apt`, or `pacman`)
- Install all system packages
- Download latest releases for Starship, Bottom, Lazygit, and Atuin
- Change your default shell to Zsh
- Stow all dotfiles into place

### 3. Restart

```bash
exec zsh
```

Or simply open a new terminal window.

## Manual Stowing

If you prefer to stow individual packages instead of using `install.sh`:

```bash
cd ~/dotfiles

# Shell config
stow -t ~ zsh

# App configs (target ~/.config)
stow -t ~/.config starship
stow -t ~/.config atuin
stow -t ~/.config bottom
stow -t ~/.config lazygit
stow -t ~/.config kitty
stow -t ~/.config nvim
stow -t ~/.config yazi
```

## Key Aliases

| Alias | Command |
|-------|---------|
| `ls` | `eza --icons=auto` |
| `ll` | `eza -l --icons=auto --git` |
| `la` | `eza -la --icons=auto --git` |
| `cat` | `bat --theme=Catppuccin-mocha` |
| `grep` | `rg` |
| `find` | `fd` |
| `top` | `btm` |
| `vim` / `vi` | `nvim` |
| `lg` | `lazygit` |
| `g` | `git` |
| `gs` | `git status` |
| `gd` | `git diff` |
| `gl` | `git log --oneline --graph` |

## Requirements

- Linux (x86_64)
- `git`, `curl`, `tar`
- `sudo` access for installing packages
- One of: `dnf` (Fedora), `apt` (Debian/Ubuntu), or `pacman` (Arch)

## Adding New Dotfiles

1. Create a directory at the repo root matching the app name
2. Inside it, mirror the structure you want in `$HOME` or `~/.config`
3. Run `stow -t <target> <directory>`

Example for adding `tmux`:

```bash
mkdir tmux
cp ~/.tmux.conf tmux/
stow -t ~ tmux
```

## Uninstall

To remove a stowed package:

```bash
stow -D -t ~ zsh
stow -D -t ~/.config nvim
```

## License

MIT — use, copy, modify, share freely.

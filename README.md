# dotfiles

macOS development environment — Catppuccin Mocha throughout. One command to set up a fresh machine.

## Setup

```bash
curl -fsSL https://raw.githubusercontent.com/taras-lysyi/dotfiles/main/setup.sh | bash
```

Or clone and run manually:

```bash
git clone --bare git@github.com:taras-lysyi/dotfiles.git $HOME/dotfiles
./setup.sh
```

The script installs all dependencies, clones zsh plugins, checks out configs, and backs up any conflicting files to `~/.dotfiles-backup/`.

## What's included

| Tool | Config | Purpose |
|------|--------|---------|
| **Neovim** | `.config/nvim/` | Editor — LSP, Copilot + Sidekick AI, fzf-lua, conform.nvim, git-worktree |
| **Zsh** | `.zshrc` | Shell — native prompt, deferred plugins, vi-mode, zoxide, lazy-loaded NVM |
| **Alacritty + Zellij** | `.config/alacritty/`, `.config/zellij/` | Terminal + multiplexer (Alacritty renders, Zellij handles tabs/panes) |
| **Kitty** | `.config/kitty/` | Alternative terminal — handles tabs/panes natively, no multiplexer needed |
| **AeroSpace** | `.config/aerospace/` | Tiling WM — 3 workspaces: browser, code, chat |
| **Karabiner** | `.config/karabiner/` | Caps Lock → Cmd (held) / Escape (tap), Option+hjkl → arrows |
| **Yazi** | `.config/yazi/` | Terminal file manager |

> **Pick one terminal setup:** Alacritty + Zellij (current default) or Kitty standalone. Both configs are included.

## Highlights

**Neovim** — lazy.nvim plugin manager, LSP with gopls/lua_ls/tsserver, AI coding via Copilot and Sidekick, fzf-lua for file/grep navigation, conform.nvim for formatting (gofumpt, prettier), git-worktree with auto-derived paths and fzf picker.

**Zsh** — fast startup via `zsh-defer` (no framework overhead), native `vcs_info` git prompt, vi keybindings, history prefix search with arrow keys, `eza` for ls, lazy-loaded NVM and gcloud to avoid blocking shell init.

**Window management** — AeroSpace tiles windows across 3 workspaces with vim-style navigation (ctrl+cmd+hjkl). Karabiner turns Caps Lock into a dual-purpose key and adds arrow keys on the home row.

## Cherry-picking

The configs are independent — copy what you need:

- **Neovim only** — grab `.config/nvim/`, works on any OS
- **Zsh only** — grab `.zshrc`, install zsh-defer + plugins
- **Terminal only** — pick either `.config/alacritty/` + `.config/zellij/`, or `.config/kitty/`
- **Window management** — `.config/aerospace/` + `.config/karabiner/` (macOS only)

## Managing dotfiles

```bash
config status
config add .config/nvim/lua/plugins/init.lua
config commit -m "feat: add plugin"
config push
```

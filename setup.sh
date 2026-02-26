#!/bin/bash
set -e

echo "==> Installing Homebrew (if needed)"
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "==> Installing CLI tools"
brew install neovim zoxide eza yazi zellij git

echo "==> Installing cask apps"
brew install --cask alacritty kitty karabiner-elements font-fira-code-nerd-font
brew install --cask nikitabobko/tap/aerospace

echo "==> Installing zsh plugins"
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

if [ ! -d "$HOME/.zsh-defer" ]; then
  git clone --depth=1 https://github.com/romkatv/zsh-defer "$HOME/.zsh-defer"
fi

echo "==> Installing NVM"
if [ ! -d "$HOME/.nvm" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
fi

echo "==> Checking out dotfiles"
if [ ! -d "$HOME/dotfiles" ]; then
  git clone --bare git@github.com:taraslis453/dotfiles.git "$HOME/dotfiles"
fi

config() {
  /usr/bin/git --git-dir="$HOME/dotfiles/" --work-tree="$HOME" "$@"
}

# Back up existing files that would conflict
config checkout 2>&1 | grep -E "^\s+" | awk '{print $1}' | while read -r file; do
  mkdir -p "$HOME/.dotfiles-backup/$(dirname "$file")"
  mv "$HOME/$file" "$HOME/.dotfiles-backup/$file" 2>/dev/null || true
done

config checkout
config config status.showUntrackedFiles no

echo ""
echo "==> Done! Restart your terminal."
echo ""
echo "Backed up conflicting files to ~/.dotfiles-backup/ (if any)"
echo "Optional: set up ~/.git-acc and ~/.jira.env for git account switching and Jira CLI"

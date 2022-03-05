
#### FIG ENV VARIABLES ####
# Please make sure this block is at the start of this file.
[ -s ~/.fig/shell/pre.sh ] && source ~/.fig/shell/pre.sh
#### END FIG ENV VARIABLES ####
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi






# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/taras/.oh-my-zsh"
export PATH=$PATH:$HOME/go/bin
export GOPATH=$HOME/go

plugins=(git zsh-syntax-highlighting zsh-autosuggestions zsh-vi-mode )


# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"
source $ZSH/oh-my-zsh.sh
. $(brew --prefix)/etc/profile.d/z.sh
export KEYTIMEOUT=1
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#959695"

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
ENABLE_CORRECTION="true"


ZVM_CURSOR_STYLE_ENABLED=false
# User configuration

alias ys='yarn start'
alias ns='npm start'
alias dev='cd && dev/'
alias c='clear'
alias e='exit'
alias nv='nvim'
alias nvimi='cd && .config/nvim && nv .'
alias ls='exa'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#### FIG ENV VARIABLES ####
# Please make sure this block is at the end of this file.
[ -s ~/.fig/fig.sh ] && source ~/.fig/fig.sh
#### END FIG ENV VARIABLES ####
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

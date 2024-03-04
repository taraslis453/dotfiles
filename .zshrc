# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi






# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH=$PATH:$HOME/go/bin
export GOPATH=$HOME/usr/local/go/bin/go
plugins=(git zsh-syntax-highlighting zsh-autosuggestions zsh-vi-mode)

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
alias n='nvim'
alias v='vim'
alias ni='cd && .config/nvim && n'
alias ls='exa'
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export LANG="en_US.UTF-8"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

ulimit -n 1024




# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/taraslysyi/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/taraslysyi/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/taraslysyi/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/taraslysyi/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# git account switch
source $HOME/.git-acc

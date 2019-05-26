#!/bin/zsh

# Detection OS
if [ -f /etc/synopackageslimit.conf ]; then
	export OS=Synology
	export TERM="xterm-256color"
elif [[ `uname` == 'Linux' ]]; then
	export OS=linux
elif [[ `uname` == 'Darwin' ]]; then
	export OS=osx
fi

#Antigen
## On préfére le local s'il est la
if [ -f ~/antigen.zsh ]; then
	source ~/antigen.zsh
## Sinon on cherche les autres
elif [ -f /usr/share/zsh-antigen/antigen.zsh ]; then
	source /usr/share/zsh-antigen/antigen.zsh
elif [ -f /usr/local/share/antigen/antigen.zsh ]; then
	source /usr/local/share/antigen/antigen.zsh
fi

antigen use oh-my-zsh

POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k

antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

antigen theme bhilburn/powerlevel9k powerlevel9k
antigen apply

# powerlevel9k settings
export POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(background_jobs history time)

# Alias ls
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"

# History
export HISTFILE="${HOME}/.zsh_history"
export HISTSIZE=50000
export SAVEHIST=50000

# Path
export PATH=$PATH:~/.local/bin

# Extended globs
setopt extendedglob

test -e "${HOME}/.zshrc.local" && source "${HOME}/.zshrc.local"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


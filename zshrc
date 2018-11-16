#!/bin/zsh

#Completion
source /usr/share/zsh-antigen/antigen.zsh
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

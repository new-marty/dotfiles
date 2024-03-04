# git
alias gs='git status'
alias gl="git log --graph --pretty=format:'%C(yellow)%h%Creset %s %Cgreen(%an)%Creset %Cred%d%Creset'"
alias gls='git log --stat --summary'
alias ga='git add'
alias co='git checkout'
alias br="git branch --sort=-committerdate --format='%(authordate:short) %(color:red)%(objectname:short) %(color:yellow)%(refname:short)%(color:reset) (%(color:green)%(committerdate:relative)%(color:reset))'"
alias cob='git checkout -b'
alias gd='git diff'
alias gcm='git commit -m'
alias gca='git commit --amend'
alias gb='git branch -m'
alias gp='git push origin head'
alias sw='git switch'

# ls
alias ls="eza --icons"
alias ll="ls -la"
alias la="ls -l"
alias l1="ls -1"
alias lll="ls -abghHliS --git"

# cat
alias cat="ccat"

# diff
alias diff='colordiff -u'

# alias
alias v='vim'
alias e='emacs'
alias code='code .'
alias rs='exec $SHELL -l'
alias ....='../..'
alias zshrc='vi ~/.zshrc && source ~/.zshrc'
alias sz='source ~/.zshrc'
alias c='clear'

# yarn
alias y='yarn'
alias yd='yarn dev'
alias ym='yarn mongo'
alias yfc='yarn force-commit -m'
alias yj='yarn jest'

# docker
alias dcu='docker-compose up -d'

# python
alias p='python3'

# terraform
alias tf='terraform'

# personal
alias asu='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/ASU'
alias rakweb='node ~/dev/automation/rakuten/rakutenWeb.js'

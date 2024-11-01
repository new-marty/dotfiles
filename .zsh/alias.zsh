# git
alias gs='git status'
alias gl="git log --graph --pretty=format:'%C(yellow)%h%Creset %s %Cgreen(%an)%Creset %Cred%d%Creset'"
alias gls='git log --stat --summary'
alias ga='git add'
alias br="git branch --sort=-committerdate --format='%(authordate:short) %(color:red)%(objectname:short) %(color:yellow)%(refname:short)%(color:reset) (%(color:green)%(committerdate:relative)%(color:reset))'"
alias gd='git diff'
alias gcm='git commit -m'
alias gca='git commit --amend'
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
alias code='code .'
alias rs='exec $SHELL -l'
alias ....='../..'
alias sz='source ~/.zshrc'
alias c='clear'

# pnpm
alias pp="pnpm"
alias pi="pnpm install"
alias pr="pnpm run"
alias pd="pnpm dev"
alias pu="pnpm update"
alias pb="pnpm build"

# docker
alias dcu='docker-compose up -d'

# python
alias p='python3'

# terraform
alias tf='terraform'

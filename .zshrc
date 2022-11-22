# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

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
alias sw='git switch -c'

#alias
alias v='vim'
alias e='emacs'
alias code='code .'
alias rs='exec $SHELL -l'
alias ....='../..'
alias zshrc='vi ~/.zshrc && source ~/.zshrc'
alias sz='source ~/.zshrc'
alias y='yarn'
alias yd='yarn dev'
alias ym='yarn mongo'
alias yfc='yarn force-commit -m'
alias yj='yarn jest'
alias c='clear'
alias dcu='docker-compose up -d'
alias asu='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/ASU'
alias p='python3'
alias rakweb='node ~/dev/automation/rakuten/rakutenWeb.js'

# コマンドのスペルを訂正する
#setopt correct
unsetopt correct
unsetopt correctall
DISABLE_CORRECTION="true"

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
 
# [TAB] でパス名の補完候補を表示したあと、
# 続けて [TAB] を押すと候補からパス名を選択できるようになる
# 候補を選ぶには [TAB] か Ctrl-N,B,F,P
zstyle ':completion:*:default' menu select=1

# cd [TAB] で以前移動したディレクトリを表示
setopt auto_pushd
 
# ヒストリ (履歴) を保存、数を増やす
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
 
# 同時に起動した zsh の間でヒストリを共有する
setopt share_history
 
# 直前と同じコマンドの場合はヒストリに追加しない
setopt hist_ignore_dups
 
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
 
# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space
 
# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# cd なしでもディレクトリ移動
setopt auto_cd


export PATH=/Users/yumabuchi/.nodebrew/current/bin:/Users/yumabuchi/.nodebrew/current/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin

export LESS='-R'
# export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh  %s'

####################
#     Colorize     #
####################

# read grc setting
# [[ -s "/usr/local/etc/grc.zsh" ]] && source /usr/local/etc/grc.zsh

# ls
alias ls="exa"
alias ll="exa -la"
alias la="exa -l"
alias l1="exa -1"
alias lll="exa -abghHliS --git"

# less
export LESS='-R'
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh  %s'

# cat
alias cat="ccat"

# diff
alias diff='colordiff -u'

### End Colorize ###

export GITHUB_NPM_TOKEN='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8g'
export GITHUB_NPM_TOKEN='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'

# homebrew
eval $(/opt/homebrew/bin/brew shellenv)
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/usr/local/texlive/2022/bin/universal-darwin:$PATH"

# peco settings
# 過去に実行したコマンドを選択。ctrl-rにバインド
function peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# search a destination from cdr list
function peco-get-destination-from-cdr() {
  cdr -l | \
  sed -e 's/^[[:digit:]]*[[:blank:]]*//' | \
  peco --query "$LBUFFER"
}


### 過去に移動したことのあるディレクトリを選択。ctrl-uにバインド
function peco-cdr() {
  local destination="$(peco-get-destination-from-cdr)"
  if [ -n "$destination" ]; then
    BUFFER="cd $destination"
    zle accept-line
  else
    zle reset-prompt
  fi
}
zle -N peco-cdr
bindkey '^u' peco-cdr

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# opbookmarks
export PATH="$HOME/opbookmarks/target/release:$PATH"

export PATH=$HOME/.nodebrew/current/bin:$PATH

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"

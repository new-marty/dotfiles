# Amazon Q pre block
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

# Custom scripts directory
ZSH_DIR="${HOME}/.zsh"

# Load Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Shell behavior options
unsetopt correct
unsetopt correctall
DISABLE_CORRECTION="true"
setopt auto_pushd
setopt auto_cd

# Completion settings
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select=1

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt share_history
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks

# Development environment initialization
eval "$(pyenv init -)"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# Tool configurations
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform
eval $(thefuck --alias)

# Load custom scripts
if [ -d $ZSH_DIR ] && [ -r $ZSH_DIR ] && [ -x $ZSH_DIR ]; then
  for file in ${ZSH_DIR}/**/*.zsh; do
    [ -r $file ] && source $file
  done
fi

# Additional tools
[[ -f "$HOME/fig-export/dotfiles/dotfile.zsh" ]] && builtin source "$HOME/fig-export/dotfiles/dotfile.zsh"

# Compile zsh completion cache in background
{
  zcompdump="${XDG_CACHE_HOME:-$HOME/.cache}/prezto/zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
} &

# Login message
if [[ -o INTERACTIVE && -t 2 ]]; then
  if (($ + commands[fortune])); then
    fortune -s
    print
  fi
fi >&2

# Amazon Q post block
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"

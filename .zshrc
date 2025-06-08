# Amazon Q pre block
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

# Shell options
unsetopt correct correctall
DISABLE_CORRECTION="true"
setopt auto_pushd auto_cd

# Completion settings
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select=1

# History settings
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000
setopt share_history hist_ignore_dups hist_ignore_all_dups hist_ignore_space hist_reduce_blanks

# Tool configurations
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
autoload -U +X bashcompinit && bashcompinit
eval "$(thefuck --alias)"

# Load Sheldon (plugins are managed via ~/.config/sheldon/sheldon.toml)
eval "$(sheldon source)"

cache_dir=${XDG_CACHE_HOME:-$HOME/.cache}
sheldon_cache="$cache_dir/sheldon.zsh"
sheldon_toml="$HOME/.config/sheldon/plugins.toml"

if [[ ! -r "$sheldon_cache" || "$sheldon_toml" -nt "$sheldon_cache" ]]; then
  mkdir -p "$cache_dir"
  sheldon source >"$sheldon_cache"
fi
source "$sheldon_cache"
unset cache_dir sheldon_cache sheldon_toml

# Amazon Q post block (if needed)
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"

complete -o nospace -C /opt/homebrew/bin/terraform terraform

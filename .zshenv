#
# Environment Variables Configuration
# This file is always sourced, for all shells
#

# Basic environment variables
export LANG='en_US.UTF-8'
export EDITOR='nano'
export VISUAL='nano'
export PAGER='less'
[[ "$OSTYPE" == darwin* ]] && export BROWSER='open'

# Load secrets if the file exists
[[ -f "$HOME/dotfiles/.secrets" ]] && source "$HOME/dotfiles/.secrets"

# Less configuration
export LESS='-R'
export LESSOPEN='| /opt/homebrew/bin/src-hilite-lesspipe.sh %s'

# Application configurations
export BAT_CONFIG_PATH="$HOME/dotfiles/bat/bat.conf"
export GOOGLE_CHROME_PATH='/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'

# Homebrew
export PATH="/opt/homebrew/bin:$PATH"
eval $(/opt/homebrew/bin/brew shellenv)

# Development languages
# Python
eval "$(pyenv init --path)"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# Java
export JAVA_HOME=$(/usr/libexec/java_home -v 2.0)
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# Node.js
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# .NET
export PATH="/opt/homebrew/opt/dotnet@6/bin:$PATH"

# Additional language tools
export PATH="/opt/homebrew/lib/python3.12/site-packages/pip:$PATH"
export PATH="/usr/local/texlive/2022/bin/universal-darwin:$PATH"
export PATH="/opt/homebrew/opt/mongodb-community@4.2/bin:$PATH"
export PATH="/usr/local/opt/php/bin:$PATH"

# Development tools and utilities
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.amplify/bin:$PATH"
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
export PATH="~/.console-ninja/.bin:$PATH"

# Remove duplicate entries from PATH
typeset -U path

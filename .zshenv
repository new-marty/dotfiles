#
# Environment Variables Configuration
#

# System default paths
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin

# Homebrew - Package manager for macOS
eval $(/opt/homebrew/bin/brew shellenv)

#
# Development Tools & Languages
#

# Python - pyenv for Python version management
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# Java - OpenJDK configuration
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export JAVA_HOME=$(/usr/libexec/java_home -v 2.0)

# Node.js - Nodebrew for Node.js version management
export PATH="$HOME/.nodebrew/current/bin:$PATH"
export NVM_DIR="$HOME/.nvm"

# .NET - Version 6 runtime and SDK
export PATH="/opt/homebrew/opt/dotnet@6/bin:$PATH"

# Python pip packages
export PATH="/opt/homebrew/lib/python3.12/site-packages/pip:$PATH"

# LaTeX - TeX Live distribution
export PATH="/usr/local/texlive/2022/bin/universal-darwin:$PATH"

# MongoDB - Community Edition v4.2
export PATH="/opt/homebrew/opt/mongodb-community@4.2/bin:$PATH"

# PHP - Local PHP installation
export PATH="/usr/local/opt/php/bin:$PATH"

#
# Development Tools & Utilities
#

# Local binaries
export PATH="$HOME/.local/bin:$PATH"

# AWS Amplify CLI
export PATH="$HOME/.amplify/bin:$PATH"

# PNPM - Fast, disk space efficient package manager
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Console Ninja - VS Code console logger
export PATH="~/.console-ninja/.bin:$PATH"

#
# Application Settings
#

# Environment Variables
export LANG='en_US.UTF-8'
export EDITOR='nano'
export VISUAL='nano'
export PAGER='less'
[[ "$OSTYPE" == darwin* ]] && export BROWSER='open'

# Less Configuration

export LESS='-R'                                                 # -R: Allow ANSI color escape sequences
export LESSOPEN='| /opt/homebrew/bin/src-hilite-lesspipe.sh  %s' # Syntax highlighting in less

# Bat configuration (modern replacement for cat)
export BAT_CONFIG_PATH="$HOME/dotfiles/bat/bat.conf"

# Chrome executable path (for automation/testing)
export GOOGLE_CHROME_PATH='/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'

# Remove duplicate entries from PATH
typeset -U path

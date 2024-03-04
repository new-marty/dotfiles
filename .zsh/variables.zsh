# path
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin

# homebrew
eval $(/opt/homebrew/bin/brew shellenv)
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/usr/local/texlive/2022/bin/universal-darwin:$PATH"

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# less
export LESS='-R'
export LESSOPEN='| /opt/homebrew/bin/src-hilite-lesspipe.sh  %s'

# bat
export BAT_CONFIG_PATH='~/dotfiles/bat/bat.cong'
# export BAT_THEME="Visual Studio Dark+"

# chrome
export GOOGLE_CHROME_PATH='/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'

# pre-commit
export PATH="$HOME/.local/bin:$PATH"

# Java
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export JAVA_HOME=$(/usr/libexec/java_home -v 2.0)

# dotnet
export PATH="/opt/homebrew/opt/dotnet@6/bin:$PATH"

# mongoDB
export PATH="/opt/homebrew/opt/mongodb-community@4.2/bin:$PATH"

# php
export PATH="/usr/local/opt/php/bin:$PATH"

# mysql
# export PATH="/opt/homebrew/opt/mysql@5.7/bin:$PATH"
# export LDFLAGS="-L/opt/homebrew/opt/mysql@5.7/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/mysql@5.7/include"

# dotnet
export PATH="/opt/homebrew/opt/dotnet@6/bin:$PATH"

# path
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin

# homebrew
eval $(/opt/homebrew/bin/brew shellenv)
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/usr/local/texlive/2022/bin/universal-darwin:$PATH"

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# opbookmarks
export PATH="$HOME/opbookmarks/target/release:$PATH"

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

# less
export LESS='-R'
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh  %s'

# bat
export BAT_CONFIG_PATH='~/dotfiles/bat/bat.cong'
# export BAT_THEME="Visual Studio Dark+"

# chrome
export GOOGLE_CHROME_PATH='/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'

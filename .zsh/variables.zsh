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

# github
export GITHUB_NPM_TOKEN='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8g'
export GITHUB_NPM_TOKEN='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'

# bat
export BAT_THEME="Visual Studio Dark+"
#!/usr/bin/env zsh

# *** mkcd ***
mkcd() {
    if [[ $# -ne 1 ]]; then
        echo "Usage: mkcd <directory-name>"
        return 1
    fi

    mkdir "$1" && cd "$1"
}

# *** cdf ***
function cdf() {
    if [[ "$(pwd)" =~ "$HOME/.*" ]]; then
        target=$(fd -t d | fzf --height 50% --layout=reverse --border --inline-info --preview 'ls -F -1 {}')
        if [[ -n "$target" ]]; then
            cd $target
        fi
    else
        echo -e "\e[33mThe directory must be under your home directory to be able to run this.\e[m"
        return 1
    fi
}

# *** brew ***
brew() {
    # Run the original brew command
    command brew "$@"

    # If the command was an install or upgrade, update the Brewfile
    if [[ "$1" == "install" || "$1" == "upgrade" || "$1" == "uninstall" ]]; then
        echo "Updating Brewfile..."
        command brew bundle dump --force --file=~/dotfiles/Brewfile
    fi
}

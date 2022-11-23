#!/usr/bin/env zsh

function cdf() {
  if [[ "$(pwd)" =~ "$HOME/.*" ]]; then
    target=$(fd -t d | fzf --height 50% --layout=reverse --border --inline-info --preview 'exa -F -1 {}')
    if [[ -n "$target" ]]; then
      cd $target
    fi;
  else
    echo -e "\e[33mThe directory must be under your home directory to be able to run this.\e[m"
    return 1
  fi;
}
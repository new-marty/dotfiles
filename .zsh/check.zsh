#!/usr/bin/env zsh

if test -n "$(git -C ~/dotfiles status --porcelain)" ||
    ! git -C ~/dotfiles diff --exit-code --stat --cached origin/main >/dev/null; then
    echo -e "\e[33mThe dotfiles have been changed.\e[m"
fi

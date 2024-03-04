#!/bin/bash

# setup dotfiles

echo "Setting up dotfiles..."
for file in $(find . -maxdepth 1 -not -type d); do
    if [[ $file != './deploy.sh' ]]; then
        f=$(echo $file | sed 's/.\///')
        ln -svf ~/dotfiles/$f ~
    fi
done

if [ ! -d ~/.zsh ]; then
    mkdir ~/.zsh
fi

for file in $(find ./.zsh -maxdepth 1 -not -type d); do
    f=$(echo $file | sed 's/.\///')
    ln -svf ~/dotfiles/$f ~/.zsh
done

echo "Done setting up dotfiles!"

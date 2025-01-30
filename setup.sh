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

# Setup Hammerspoon
echo "Setting up Hammerspoon..."
mkdir -p ~/.hammerspoon
ln -svf ~/dotfiles/hammerspoon/init.lua ~/.hammerspoon/init.lua
echo "Done setting up Hammerspoon!"

# Setup Ghostty
echo "Setting up Ghostty..."
mkdir -p ~/.config/ghostty/themes
ln -svf ~/dotfiles/ghostty/ghostty.conf ~/.config/ghostty/config
ln -svf ~/dotfiles/ghostty/poimandres.ghostty \
    ~/.config/ghostty/themes/poimandres.ghostty
echo "Done setting up Ghostty!"

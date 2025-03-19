#!/bin/bash

# Setup essential dotfiles
echo "Setting up dotfiles..."
ln -svf ~/dotfiles/.zshenv ~/.zshenv
ln -svf ~/dotfiles/.zshrc ~/.zshrc
echo "Done setting up dotfiles!"

# Setup Brewfile
echo "Setting up Brewfile..."
ln -svf ~/dotfiles/Brewfile ~/Brewfile
echo "Done setting up Brewfile!"

# Setup Sheldon
echo "Setting up Sheldon..."
mkdir -p ~/.config/sheldon
ln -svf ~/dotfiles/sheldon/plugins.toml ~/.config/sheldon/plugins.toml
echo "Done setting up Sheldon!"

# Setup Ghostty
echo "Setting up Ghostty..."
mkdir -p ~/.config/ghostty/themes
ln -svf ~/dotfiles/ghostty/ghostty.conf ~/.config/ghostty/config
ln -svf ~/dotfiles/ghostty/poimandres.ghostty ~/.config/ghostty/themes/poimandres.ghostty
echo "Done setting up Ghostty!"

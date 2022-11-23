#!/bin/bash

# install brew
if [ -z "$(command -v brew)" ]; then
    echo "Installing brew..."

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/${USER}/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    brew bundle

    echo "Done installing brew!"
fi

# install vim-plug
# echo "Installing vim-plug..."
# curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# echo "Done installing vim-plug!"

# setup dotfiles
echo "Setting up dotfiles..."
for file in $(find . -maxdepth 1 -not -type d)
do
    if [[ $file != './deploy.sh' ]]
    then
        f=$(echo $file | sed 's/.\///')
        ln -svf ~/dotfiles/$f ~
    fi
done

if [ ! -d ~/.zsh ]; then
    mkdir ~/.zsh   
fi

for file in $(find ./.zsh -maxdepth 1 -not -type d)
do
    f=$(echo $file | sed 's/.\///')
    ln -svf ~/dotfiles/$f ~/.zsh
done
echo "Done setting up dotfiles!"
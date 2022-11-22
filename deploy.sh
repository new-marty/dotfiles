#!/bin/bash

for file in $(ls -a)
do
    if [[ $file != '.' && $file != '..' && $file != 'deploy.sh' ]]
    then
        ln -svf ~/dotfiles/$file ~
    fi
done
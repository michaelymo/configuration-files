#!/bin/bash
for filename in .vimrc .gitconfig
do
    ln -s $(pwd)/${filename} ~/${filename} && echo "${filename} placed."
done

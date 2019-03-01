#!/bin/bash
# create reqyured dirs
mkdir -p ~/.vim/bundle
mkdir -p ~/.vim/pack/default/start

# install vundle for vim
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
  git clone --quiet https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  git clone --quiet https://github.com/morhetz/gruvbox.git ~/.vim/pack/default/start/gruvbox
fi

# download required files
curl -s -o ~/.tmux.conf https://raw.githubusercontent.com/sephioh/developer-tools/master/tmux.conf
curl -s -o ~/.vimrc https://raw.githubusercontent.com/sephioh/developer-tools/master/vimrc

# install plugins
vim -c VundleInstall -c quital

# show successful message
echo "developer-tools installed with success!"

#!/bin/bash
# install vundle for vim
if [ -d "$DIRECTORY" ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

# download required files
curl -s -o ~/.tmux.conf https://raw.githubusercontent.com/sephioh/developer-tools/master/tmux.conf
curl -s -o ~/.vimrc https://raw.githubusercontent.com/sephioh/developer-tools/master/vimrc

# install plugins
vim -c VundleInstall -c quital

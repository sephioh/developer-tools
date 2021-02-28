#!/bin/bash
# create required folders
mkdir -p ~/.config/nvim/

# download required files
curl -s -o ~/.tmux.conf https://raw.githubusercontent.com/sephioh/developer-tools/master/tmux.conf
curl -s -o ~/.config/nvim/init.vim https://raw.githubusercontent.com/sephioh/developer-tools/master/init.vim

# install YCM dependencies
#unameOut="$(uname -s)"
#case "${unameOut}" in
#    Linux*)     machine=Linux;;
#    Darwin*)    machine=Mac;;
#    *)          machine="UNKNOWN:${unameOut}"
#esac

# install plugins
vim +PlugInstall +qall

# if [[ "${machine}" = Linux ]]
# then
# 	sudo apt install build-essential cmake vim-nox python3-dev
# 	cd ~/.vim/bundle/YouCompleteMe
# 	python3 install.py --all
# else
# 	brew install cmake python mono go nodejs
# fi
#
#
# # install custom vim packages
# sudo pip3 install rope ropemode ropevim
# wget -P ~/.vim/ https://raw.githubusercontent.com/python-rope/ropevim/master/ftplugin/python_ropevim.vim
# echo "source ~/.vim/python_ropevim.vim" >> ~/.vimrc

# show successful message
echo "developer-tools installed with success!"

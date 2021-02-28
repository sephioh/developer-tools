#!/bin/bash
create_required_folders() {
	mkdir -p ~/.config/nvim/
}

download_config_files() {
	curl -s -o ~/.tmux.conf https://raw.githubusercontent.com/sephioh/developer-tools/master/tmux.conf
	curl -s -o ~/.config/nvim/init.vim https://raw.githubusercontent.com/sephioh/developer-tools/master/init.vim
}

linux_install() {
 	sudo apt install neovim tmux python3-dev build-essential cmake 
}

mac_install() {
	brew install cmake python mono go nodejs tmux
}

install_deps() {
	os="$(uname -s)"
	if [ $os == "Linux" ]
	then 
		linux_install
	else
		mac_install
	fi

	pip install neovim
}

installYCM() {
 	python3 ~/.config/nvim/plugged/YouCompleteMe/install.py
}

main(){
	# install deps
	install_deps

	# install plugins
	vim +PlugInstall +qall

	# custom install for ycm
	installYCM

	echo "developer-tools installed with success!"
}

# # install custom vim packages
# sudo pip3 install rope ropemode ropevim
# wget -P ~/.vim/ https://raw.githubusercontent.com/python-rope/ropevim/master/ftplugin/python_ropevim.vim
# echo "source ~/.vim/python_ropevim.vim" >> ~/.vimrc

main

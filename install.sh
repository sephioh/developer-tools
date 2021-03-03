#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

create_required_folders() {
	mkdir -p ~/.config/nvim/
}

download_config_files() {
	create_required_folders
	curl -s -o ~/.tmux.conf https://raw.githubusercontent.com/sephioh/developer-tools/master/tmux.conf
	curl -s -o ~/.config/nvim/init.vim https://raw.githubusercontent.com/sephioh/developer-tools/master/init.vim
	curl -s -o ~/.gitignore_global https://raw.githubusercontent.com/sephioh/developer-tools/master/.gitignore_global
}

linux_install() {
	sudo apt install neovim tmux python3-dev build-essential cmake git ack silversearcher-ag ranger
}

mac_install() {
	brew install cmake python mono go nodejs tmux git
}

install_deps() {
	os="$(uname -s)"

	if [ $os == "Linux" ]
	then
		linux_install
	else
		mac_install
	fi

	pip3 install neovim black ropevim rope ropemode
}

install_ycm() {
	python3 ~/.config/nvim/plugged/YouCompleteMe/install.py
}

git_config() {
	git config --global user.name "Abraão Alcântara"
	git config --global user.email "sephioh@gmail.com"
	git config --global core.excludesfile ~/.gitignore_global
}


main() {
	install_deps

	download_config_files

	# install plugins
	vim +PlugInstall +qall

	# custom install required for ycm
	install_ycm

	git_config

	echo -e "${GREEN}developer-tools installed with success!${NC}"
}

main

#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'

download_config_files() {
	CONFIG_REPO_BASE_ADDRESS="https://raw.githubusercontent.com/sephioh/developer-tools/master/config"
	curl -s -o ~/.config/ranger/rc.conf $CONFIG_REPO_BASE_ADDRESS/rc.conf
	curl -s -o ~/.flake8 $CONFIG_REPO_BASE_ADDRESS/.flake8
	curl -s -o ~/.ackrc $CONFIG_REPO_BASE_ADDRESS/.ackrc
}

install_deps() {
	os="$(uname -s)"

	if [ $os == "Linux" ]
	then
		linux_install
	else
		brew install zsh cmake python mono go nodejs tmux git
	fi
}

main() {
	install_deps

	# install plugins
	vim +PlugInstall +qall

	# success message
	echo -e "${GREEN}developer-tools installed with success!${NC}"
}

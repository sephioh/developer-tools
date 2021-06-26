#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
PYTHON_DEV_DEPS="neovim black ropevim rope ropemode pudb isort bpython pyflakes pylint automport"
RUST_DEV_DEPS="rust-src"

create_required_folders() {
	mkdir -p ~/.config/nvim/
}

download_config_files() {
	create_required_folders
	CONFIG_REPO_BASE_ADDRESS="https://raw.githubusercontent.com/sephioh/developer-tools/master/config"
	curl -s -o ~/.tmux.conf $CONFIG_REPO_BASE_ADDRESS/tmux.conf
	curl -s -o ~/.config/nvim/init.vim $CONFIG_REPO_BASE_ADDRESS/init.vim
	curl -s -o ~/.config/ranger/rc.conf $CONFIG_REPO_BASE_ADDRESS/rc.conf
	curl -s -o ~/.gitignore_global $CONFIG_REPO_BASE_ADDRESS/.gitignore_global
	curl -s -o ~/.flake8 $CONFIG_REPO_BASE_ADDRESS/.flake8
	curl -s -o ~/.ackrc $CONFIG_REPO_BASE_ADDRESS/.ackrc
	rustup component add rust-src
}

linux_install() {
	PACKAGES="zsh autojump neovim tmux python3-dev build-essential cmake git ack silversearcher-ag ranger fzf bat gh"
	sudo apt update -qq
	sudo apt install -qqy $PACKAGES
}

mac_install() {
	brew install zsh cmake python mono go nodejs tmux git
}

pip_install_tools() {
	pip install -q ${PYTHON_DEV_DEPS}
}

add_custom_commands() {
	# setup local path
	LOCAL_PATH="$HOME/.local/bin"
	SETUP_DEV_PIPENV_PATH=${LOCAL_PATH}/setup-dev-pipenv
	mkdir -p ${LOCAL_PATH}
	grep -qxF "export PATH=\"$LOCAL_PATH:\$PATH\"" ~/.zshrc || echo "export PATH=\"$LOCAL_PATH:\$PATH\"" >> ~/.zshrc
	grep -qxF "export FZF_DEFAULT_COMMAND='ag -l --path-to-ignore ~/.ignore --nocolor -g \"\"'" ~/.zshrc || echo "export FZF_DEFAULT_COMMAND='ag -l --path-to-ignore ~/.ignore --nocolor -g \"\"'" >> ~/.zshrc
	zsh && source ~/.zshrc

	# custom commands
	echo "pipenv install --dev ${PYTHON_DEV_DEPS}" > ${SETUP_DEV_PIPENV_PATH}
	chmod a+x ${SETUP_DEV_PIPENV_PATH}
}

zsh_setup() {
	# set zsh as default shell
	echo ${SHELL} | grep zsh || chsh -s $(which zsh)

	# pudb as default python debugger
	grep -qxF 'export PYTHONBREAKPOINT="pudb.set_trace"' ~/.zshrc || echo 'include "export PYTHONBREAKPOINT="pudb.set_trace"' >> ~/.zshrc
}

install_deps() {
	os="$(uname -s)"

	if [ $os == "Linux" ]
	then
		linux_install
	else
		mac_install
	fi

	pip_install_tools
	zsh_setup
	add_custom_commands
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

	echo "Setup git configuration?"
	select yn in "Yes" "No"; do
		case $yn in
			Yes ) git_config; break;;
			No ) break;;
		esac
	done

	# install plugins
	vim +PlugInstall +qall
	# custom install required for ycm
	install_ycm
	# success message
	echo -e "${GREEN}developer-tools installed with success!${NC}"
}

add_custom_commands

#!/usr/bin/env bash
# Inspired by https://gist.github.com/lpimem/a83aa0b736d95a53beb049cc07511705

# Installation directory
DIR=$HOME/app

NVIM_URL="https://github.com/neovim/neovim/releases/download/stable/nvim.appimage"

mkdir -p ${DIR}
cd ${DIR}

# Install Neovim
mkdir nvim
cd nvim
curl -L $NVIM_URL --output nvim.appimage
chmod +x nvim.appimage
./nvim.appimage +qa
ret=$?
if [ $ret -ne 0 ]; then
	echo "Cannot run nvim as appimage"
	exit 1
else
	# Update .bashrc
	echo "alias nvim={DIR}/nvim/nvim.appimage" >> $HOME/.bashrc
fi

nvim +PackerSync


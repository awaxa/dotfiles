#!/bin/bash

installhome="$HOME/dotfiles/home"
autoinstall="$HOME/dotfiles/bin"

first=0

if [ ! -d $HOME/dotfiles/.git ]
then
	curl -s https://raw.github.com/awaxa/dotfiles/master/README.md
	echo ; echo
	echo "This script will proceed to clone https://github.com/awaxa/dotfiles.git into your home directory and install symlinks to its contents in the appropriate places."o
	echo "By default this will move your existing dotfiles to \$filename.backup-$(date +%Y.%m.%d-%H%M%S) and install symlinks in their place?"
	read -p "Press enter to continue installing dotfiles in $HOME  " gogogo
	echo "Beginning..."
	echo
	cd $HOME
	git clone https://github.com/awaxa/dotfiles.git
else
	cd $HOME/dotfiles
	git checkout master
	git pull
fi
cd $HOME

filelist=$(find $installhome $autoinstall -type f | sed "s#^$HOME/dotfiles/home/##g")
dirlist=$autoinstall" "$(find $installhome $autoinstall -type d -depth +0 | sed "s#^$HOME/dotfiles/home/##g")

for f in $filelist
do
	[ -f $HOME/$f ] && mv -v $HOME/$f $HOME/$f.backup-$(date +%Y.%m.%d-%H%M%S)
done

for d in $dirlist
do
	mkdir -pv $HOME/$d
done

for f in $filelist
do
	[ ! -h $HOME/$f ] && ln -sv $HOME/dotfiles/$f $HOME/$f
done


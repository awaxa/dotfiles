#!/bin/bash

autoinstall="bin home"

cd $HOME

backup=0

if [ ! -d dotfiles/.git ]
then
	curl -s https://raw.github.com/awaxa/dotfiles/master/README.md
	echo ; echo
	echo "This script will proceed to clone https://github.com/awaxa/dotfiles.git into your home directory and install symlinks to its contents in the appropriate places."o
	echo "By default this will move your existing dotfiles to \$filename.backup-$(date +%Y.%m.%d-%H%M%S) and install symlinks in their place?"
	read -p "Press enter to continue installing dotfiles in $HOME  " gogogo
	echo "Beginning..."
	echo
	git clone https://github.com/awaxa/dotfiles.git
	backup=1
fi

filelist=$(find $(for i in $autoinstall ; do echo -n "$HOME/dotfiles/$i " ; done) -type f | sed "s#^$HOME/dotfiles/home/##g")
dirlist=$(find $(for i in $autoinstall ; do echo -n "$HOME/dotfiles/$i " ; done) -type d -depth +0 | sed "s#^$HOME/dotfiles/home/##g")

if [ $backup -eq 1 ]
then
	for f in $filelist
	do
		[ -a $HOME/$f ] && mv -v $HOME/$f $HOME/$f.backup-$(date +%Y.%m.%d-%H%M%S)
	done
fi

for d in $dirlist
do
	mkdir -pv $HOME/$d
done

for f in $filelist
do
	ln -sv $f $HOME/$f
done


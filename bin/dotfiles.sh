#!/bin/bash

clonepath=$HOME
dotfiles=$clonepath/dotfiles
backup=$dotfiles/backup

homeinstall="$dotfiles/home"
autoinstall="$dotfiles/bin"

if [ ! -d $dotfiles] && [ ! -d $dotfiles/.git ]
then
	curl -s https://raw.github.com/awaxa/dotfiles/master/README.md
	echo ; echo
	echo "This script will proceed to clone https://github.com/awaxa/dotfiles.git into your home directory and install symlinks to its contents in the appropriate places."o
	echo "By default this will move your existing dotfiles to $backup/backup.\$filename.$(date +%Y.%m.%d-%H%M%S) and install symlinks in their place?"
	read -p "Press enter to continue installing dotfiles in $HOME  " gogogo
	echo "Beginning..."
	echo
	cd $clonepath
	git clone https://github.com/awaxa/dotfiles.git
else
	cd $dotfiles
	git checkout master
	git pull
fi
cd $clonepath

filelist=$(find $homeinstall -type f | sed "s#^$homeinstall/##g")" "$(find $autoinstall -type f | sed "s#^$dotfiles/##g")
dirlist=$(find $homeinstall -type d -depth +0 | sed "s#^$homeinstall/##g")" "$(find $autoinstall -type d | sed "s#^$dotfiles/##g")

mkdir -pv $backup

for d in $dirlist
do
	mkdir -pv $clonepath/$d
	mkdir -pv $backup/$d
done

for f in $filelist
do
	if [ -h $clonepath/$f ] && [ "$(readlink $clonepath/$f)" == "$homeinstall/$f" ] 
	then
		break
	elif [ -a $clonepath/$f ]
	then
		mv -v $clonepath/$f $backup/backup.$f.$(date +%Y.%m.%d-%H%M%S)
	fi

	if [ -f $homeinstall/$f ]
	then
		ln -sv $homeinstall/$f $clonepath/$f
	elif [ -f $dotfiles/$f ]
	then
		ln -sv $dotfiles/$f $clonepath/$f
	else
		echo "exception: $f doesn't exist in $dotfiles nor $homeinstall"
	fi
done


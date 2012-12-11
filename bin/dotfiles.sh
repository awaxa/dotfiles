#!/usr/bin/env bash

ghuser="awaxa"
ghrepo="dotfiles"
ghbranch="script"

interval=1 # minutes after which to perform an autoupdate on login

clonepath=$HOME
dotfiles=$clonepath/$ghrepo
backup=$dotfiles/backup
tstamp=$(date +%Y.%m.%d-%H%M%S)
now=$(date +%s)

homeinstall="$dotfiles/home"
autoinstall="$dotfiles/bin"

uname=$(uname -a)

curl --version &> /dev/null
if [ $? -ne 0 ]
then
	echo "exception: can't run curl --version"
	exit 1
fi

git --version &> /dev/null
if [ $? -ne -0 ]
then
	echo "exception: can't run git --version"
	exit 1
fi

if [ ! -d $dotfiles/.git ]
then
	if [ ! -d $dotfiles ]
	then
		curl -s https://raw.github.com/$ghuser/$ghrepo/$ghbranch/README.md
		echo ; echo
		echo "This script will proceed to clone https://github.com/$ghuser/$ghrepo.git into your home directory and install symlinks to its contents in the appropriate places."
		echo "By default this will move your existing dotfiles to $backup/backup.\$filename.$tstamp and install symlinks in their place?"
		read -p "Press enter to continue installing dotfiles in $HOME  " gogogo
		echo "Beginning..."
		echo
		cd $clonepath
		git clone git://github.com/$ghuser/$ghrepo.git
		git checkout $ghbranch
	elif [ -d $dotfiles ]
	then
		echo "exception: $dotfiles exists but $dotfiles/.git does not"
		exit 1
	fi
else
	update=0
	fetchhead=0
	if [[ "$uname" == "Linux" ]]
	then
		fetchhead=$(/usr/bin/stat -c %y $dotfiles/.git/FETCH_HEAD)
	elif [[ "$uname" == "Darwin" ]]
	then
		fetchhead=$(/usr/bin/stat -f %c $dotfiles/.git/FETCH_HEAD)
	fi
	echo "$now - $interval * 60 ?> $fetchhead"
	if [ $((now-interval*60)) -gt $fetchhead ]
		then
		cd $dotfiles
		git checkout $ghbranch
		head=$(git log --pretty=oneline | head -n 1 | cut -f1 -d' ')
		git pull origin $ghbranch
		git diff -U1 $head bin/dotfiles.sh
	fi
fi
cd $clonepath

filelist=$(find $homeinstall -type f | sed "s#^$homeinstall/##g" | grep -v \.swp$)" "$(find $autoinstall -type f | sed "s#^$dotfiles/##g" | grep -v \.swp$)
dirlist=$(find $homeinstall -mindepth 1 -type d | sed "s#^$homeinstall/##g")" "$(find $autoinstall -type d | sed "s#^$dotfiles/##g")

mkdir -pv $backup

for d in $dirlist
do
	mkdir -pv $clonepath/$d
	mkdir -pv $backup/$d
done

for f in $filelist
do
	if [ $(expr "$(readlink $clonepath/$f)" : "$dotfiles.*$f") -ge ${#dotfiles} ]
	then
		continue
	elif [ -a $clonepath/$f ]
	then
		mv -v $clonepath/$f $backup/$f.$tstamp
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


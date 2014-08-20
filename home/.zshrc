HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=200000
setopt appendhistory
unsetopt beep

[ -f ~/.oh-my-zsh/.git/config ] || git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="agnoster"
DEFAULT_USER="awaxa"

DISABLE_AUTO_UPDATE="true"

COMPLETION_WAITING_DOTS="true"

plugins=(
brew
bundler
git
gitignore
heroku
history
osx
tmux
vagrant
virtualenv
virtualenvwrapper
wd
)

[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh

source $ZSH/oh-my-zsh.sh

source ~/.aliases

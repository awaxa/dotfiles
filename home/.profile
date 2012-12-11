# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

function sagent {
ssh-agent > ~/.ssh/agent
chmod 600 ~/.ssh/agent
source ~/.ssh/agent
ssh-add ~/.ssh/*id_rsa
}

function kagent {
pkill ssh-agent
unset SSH_AUTH_SOCK SSH_AGENT_PID
rm -f ~/.ssh/agent
}

export -f sagent kagent

if [ -f "$HOME/.ssh/agent" ]; then
    . "$HOME/.ssh/agent"
fi

ssh-add -l &> /dev/null
agentstatus=$?
if [ $agentstatus -eq 0 ] ; then
    ssh-add -l
elif [ $agentstatus -eq 1 ] ; then # 0 = identities >0, 1 = no identities, 2 = no agent
    ssh-add ~/.ssh/*id_rsa 
elif [ $agentstatus -eq 2 ] ; then
    sagent
fi

$HOME/bin/dotfiles.sh

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists

for bin in $HOME/bin $HOME/local/bin /usr/local/bin /usr/local/sbin
do
    if [ -d "$bin" ] ; then
	PATH="$bin:$PATH"
    fi
done

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
	. /etc/bash_completion
fi

if [ -f "$HOME/.ec2rc" ]; then
    . "$HOME/.ec2rc"
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


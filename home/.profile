# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh

# set PATH so it includes user's private bin if it exists
for bindir in "$HOME/bin" "$HOME/local/bin" ; do
    if [ -d "$bindir" ] ; then
        PATH="$bindir:$PATH"
    fi
done

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

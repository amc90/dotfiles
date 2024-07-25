# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/login.defs
#umask 022
umask 0026

# the rest of this file is commented out.

# include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# include .bashrc if it exists
if [ -f ~/.profile ]; then
    . ~/.profile
fi

# do the same with MANPATH
if [ -d ~/man ]; then
    MANPATH=~/man:"${MANPATH}"
    export MANPATH
fi

export 'VISUAL=/usr/bin/vim'
export 'EDITOR=/usr/bin/vim'
export 'PAGER=/usr/bin/less'
#Seems to override other URL handlers for xdg-open export 'BROWSER=/usr/bin/chromium'

export GOPATH=~/go

#Merge in the system flags too:

if [ -f /etc/chromium/default ] ; then
  . /etc/chromium/default
fi
export CHROMIUM_USER_FLAGS="$CHROMIUM_FLAGS --password-store=detect --new-window"

if which gopass>/dev/null; then
	source <(gopass completion bash)
fi


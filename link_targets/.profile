# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

if [ -d "$HOME/bin" ] ; then
	#Xmonad seems to be doing PATH correctly for a new terminal (because its a login 
	#shell?) but launching dmenu doesn't work, so we set it there too. On the other 
	#hand, setting PATH in both .profile #and .xsessionrc can cause a duplicate. Hence:
	case ":${PATH}:" in
		*":$HOME/bin:"*)
			;;
		*)
			PATH="$HOME/bin:${PATH}"
			;;
	esac
fi


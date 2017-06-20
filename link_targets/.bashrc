# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If running interactively, then:
if [ "$PS1" ]; then
	# Don't put duplicate lines in the history. See bash(1) for more options
	# export HISTCONTROL=ignoredups

	# check the window size after each command and, if necessary,
	# update the values of LINES and COLUMNS.
	shopt -s checkwinsize

	# enable color support of ls and also add handy aliases
	if [ "$TERM" != "dumb" ]; then
		eval `dircolors -b`
		alias ls='ls --color=auto'
		alias dir='ls --color=auto --format=vertical'
		alias vdir='ls --color=auto --format=long'
		alias grep='grep --color=auto'
		alias fgrep='fgrep --color=auto'
		alias egrep='egrep --color=auto'
	fi

	# some more ls aliases
	alias ll='ls -l'
	alias la='ls -A'
	alias l='ls -CF'

	alias screen='screen -U'

	# set a fancy prompt
	#PS1='\u@\h:\w\$ '
	#PS1='\[\e[35m\]\u@\h:\w\$ \[\e[0m\]'
	#PS1="\[\e[36m\]\$? \[\e[35m\]\u@\h:\w[\j]\[\e[0m\] "

	if [ -f ~/bin/setprompt ] ; then
		. ~/bin/setprompt
	else
		PS1="\[\e[36m\]\$? \[\e[33m\]\u@\h:\w[\j]\[\e[0m\] "
	fi


	# If this is an xterm set the title to user@host:dir
	case $TERM in
		u?xterm*)
			PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
			;;
		*)
			;;
	esac

	# enable programmable completion features (you don't need to enable
	# this, if it's already enabled in /etc/bash.bashrc).
	if [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

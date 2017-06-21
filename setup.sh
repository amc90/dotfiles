#!/bin/bash

if [ "$#" != 1 -o "$1" = "--help" -o "$1" = "-h" ]
then
	echo "Syntax: $0 <home_directory>">&2
fi
HOMEDIR="$1"

if [ ! -d "./link_targets" ]
then
	echo "Failed to find ./link_targets">&2
	exit 1
fi

mkdir -p "$HOMEDIR/attic"

#Now handle everything in ./link_targets
ensure_link () {
	TARGET="$(readlink -f "$1")"
	DOTFILE="$2"

	if [ "$(readlink "$DOTFILE")" != "$TARGET" ]
	then
		#Either there is no link, or it points at the wrong thing.
		#Back up if something already exists
		if [ -e "$DOTFILE" -o -h "$DOTFILE" ]
		then
			echo "Backing up old file/bad link:  mv \"$DOTFILE\" \"$DOTFILE.bak\"" 
			mv "$DOTFILE" "$DOTFILE.bak~"
		fi
		echo "Doing ln -s \"$TARGET\" \"$DOTFILE\""
		ln -s "$TARGET" "$DOTFILE"
	fi
}
(
	cd "./link_targets"
	find . -type d|while read DIR
	do
		mkdir -p "$DIR"
	done
	find . -type f|while read FILE
	do
		LINKTARGET="$(readlink -f "$FILE")"
		ensure_link "$LINKTARGET" "$HOMEDIR/$FILE"
	done
)


#!/bin/bash

actually_make_changes=0
while [[ $1 = -* ]]; do
	case $1 in
		-h|--help)
			cat <<EOF >&2
Syntax: $0 [-a] <home_directory>

  -a   Actually make changes (otherwise nothing will actually be done)

$0 adds links to homedirectory. A line is outputted for every change that is to be made.
EOF
			exit 1
			;;
		-a) actually_make_changes=1; shift;;
		--) shift; break;;
		*)
			echo "Unrecognised option $1">&2
			exit 1
			;;
	esac
done

if [ "$#" != 1 ]
then
	echo "Expected a single home directory to work on!">&2
	exit 1
fi

HOMEDIR="$1"

cd "$(readlink -f "$(dirname "$0")")"
if [ ! -d "./link_targets" ]
then
	echo "Failed to find ./link_targets">&2
	exit 1
fi

say_and_do () {
	for arg in "$@"; do printf "%q " "$arg";done
	printf "\n"
	if [ "$actually_make_changes" = 1 ]; then
		"$@"
	fi
}

if [ ! -d "$HOMEDIR" ]
then
	echo "$HOMEDIR/ doesn't seem to exist">&2
	exit 1
fi

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
			say_and_do mv "$DOTFILE" "$DOTFILE.bak~"
		fi
		say_and_do ln -s "$TARGET" "$DOTFILE"
	fi
}
(
	if ! cd "./link_targets"; then
		echo cd failed >&2
		exit 127
	fi
	find . -mindepth 1 -type d|while read DIR; do
		if [ ! -d "$HOMEDIR/$DIR" ]; then
			say_and_do mkdir -p "$HOMEDIR/$DIR"
		fi
	done
	find . -type f \! \( -name '*[~]' -o -name '*.sw[op]' \) |while read FILE; do
		#If there is an entry in .local then skip this file.
		if [ ! -f "../link_targets.local/$FILE" ]; then
			LINKTARGET="$(readlink -f "$FILE")"
			ensure_link "$LINKTARGET" "$HOMEDIR/$FILE"
		fi
	done
)
if [ -d "./link_targets.local" ]; then
(
	if ! cd "./link_targets.local"; then
		echo cd failed >&2
		exit 127
	fi
	find . -mindepth 1 -type d|while read DIR; do
		if [ ! -d "$HOMEDIR/$DIR" ]; then
			say_and_do mkdir -p "$HOMEDIR/$DIR"
		fi
	done
	find . -type f \! \( -name '*[~]' -o -name '*.sw[op]' \) |while read FILE; do
		LINKTARGET="$(readlink -f "$FILE")"
		ensure_link "$LINKTARGET" "$HOMEDIR/$FILE"
	done
)
fi


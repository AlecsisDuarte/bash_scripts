# Fedora script with functions, variables and aliases
## Variables
export SNAP_HOME=/var/lib/snapd/snap/;
export LOCAL_HOME=$HOME/.local;

## Paths
PATH=$PATH:$SNAP_HOME/bin;
PATH=$PATH:$LOCAL_HOME/bin;

## Aliases
alias fb_messenger='$HOME/Documents/bash_scripts/fb_messenger.sh';

# Syntax highlighters
alias lesss="pygmentize -g -O style=colorful";
alias lessss="pygmentize -g -O style=friendly";

# Files/Directories listing
alias ls="colorls --sd";
alias lt="colorls --sd --tree=2"
alias la="colorls --sda"
alias lsg="colorls --sd --gs"
alias ltg="colorls --sd --gs --tree=2"

## Functions
update() {
	echo " --- Making a full update/upgrade --- "
	sudo dnf update -qy
	sudo dnf upgrade -qy
	fb_messenger -m "Fedora update/upgrade finished" >> /dev/null;
}

clean() {
	echo " --- Making a full cleanup --- "
	echo "Autoremoving dnf packages"
	sudo dnf autoremove -qy
	echo "Cleaning dnf packages"
	sudo dnf clean packages
	echo "Cleaning the cached thumbnails"
	sudo rm -rf ~/.cache/thumbnails/*
}

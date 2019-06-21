# Fedora script with functions, variables and aliases
## Variables
export SNAP_HOME=/var/lib/snapd/snap/;
export LOCAL_HOME=$HOME/.local;
export FLUTTER_HOME=/opt/flutter/;

#Paths
PATH=$PATH:$SNAP_HOME/bin;
PATH=$PATH:$LOCAL_HOME/bin;
PATH=$PATH:$FLUTTER_HOME/bin;

## Aliases
alias fb_messenger='$HOME/Documents/bash_scripts/fb_messenger.sh';

# Syntax highlighters
alias lesss="pygmentize -g -O style=colorful";
alias lessss="pygmentize -g -O style=friendly";

# Files/Directories listing
alias ls="colorls --sd";
alias lt="colorls --sd --tree=2"
alias la="colorls --sd -a"
alias lsg="colorls --sd --gs"
alias ltg="colorls --sd --gs --tree=2"

## Functions
update() {
	echo " --- Making a full update/upgrade --- ";
	echo "Initializing update";
	sudo dnf update -qy
	echo "Initializing upgrade";
	sudo dnf upgrade -qy
	echo "Configuring grub incase of grub update";
	sudo grub2-mkconfig -o "$(readlink /etc/grub2.conf)" >> /dev/null;
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

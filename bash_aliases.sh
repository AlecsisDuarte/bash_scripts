#!/bin/bash
#########################################################
#						Constants						#
#########################################################
source $HOME/Documents/bash_scripts/.env; #Path to your constants
DO_HOST=$DO_HOST;#ENV Constant: Stores DigitalOcean Host
DO_USER=$DO_USER;#ENV Constant: Stores DigitalOcean User
BOLD_FONT=$BOLD_FONT;#Stores UNICODE for bold text (To be used in terminal text styling)
NORMAL_FONT=$NORMAL_FONT;# Stores UNICODE for normal text (To be used in terminal text styling)

#########################################################
#						Paths							#
#########################################################
export LOCAL_BIN=$HOME/.local/bin;
export GOLANG_HOME=/opt/go;
export FLUTTER_HOME=/opt/flutter;
export SDKMAN=$HOME/.sdkman/bin;
export BFG=$HOME/Public/BFG;
export FLUTTER=$HOME/Public/flutter/bin;
export ANDROID_DIR=$HOME/Android/Sdk;
export DART=/usr/lib/dart/bin;
export FB_MESSAGE=$HOME/Documents/bash_scripts;
export VIMCAT=$HOME/Downloads/vimcat;

PATH=$PATH:$FB_MESSAGE;
PATH=$PATH:$LOCAL_BIN;
PATH=$PATH:$SDKMAN;
PATH=$PATH:$HOME/.pub-cache/bin;
PATH=$PATH:$DART;
PATH=$PATH:$FLUTTER;
PATH=$PATH:$BFG;
PATH=$PATH:$ANDROID_DIR/emulator;
PATH=$PATH:$ANDROID_DIR/platform-tools/;
PATH=$PATH:$ANDROID_DIR/tools/bin/;
PATH=$PATH:$HOME/Documents/bash/;
PATH=$PATH:/opt/mssql-tools/bin;
PATH=$PATH:$VIMCAT;
PATH=$PATH:$FLUTTER_HOME/bin;
PATH=$PATH:$GOLANG_HOME/bin;
#########################################################
#						Aliases							#
#########################################################
alias c='clear';
alias ..='cd ..';
alias ...='cd ../../../';
alias ....='cd ../../../../';
alias .....='cd ../../../../';
alias .4='cd ../../../../';
alias .5='cd ../../../../..';
alias path='echo -e ${PATH//:/\\n}';
alias curTime='date +"%T"';
alias nowdate='date +"%d-%m-%Y"';
alias ports='netstat -tulanp';
alias myip="curl http://ipecho.net/plain; echo";
alias edit_aliases="nano ~/.bash_aliases && source ~/.bashrc";
alias restart-wifi="sudo service network-manager restart";

## pass options to free ##
alias meminfo='free -m -l -t';
 
## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4';
alias psmem10='ps auxf | sort -nr -k 4 | head -10';
 
## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3';
alias pscpu10='ps auxf | sort -nr -k 3 | head -10';
 
## Get server cpu info ##
alias cpuinfo='lscpu';
 
## Get GPU ram on desktop / laptop ##
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log';

## DigitalOcean Aliases ##
alias ssh-do="ssh $DO_USER@$DO_HOST";
alias mysql-do="mysql -u$DO_USER -h$DO_HOST -p";

## Code Viewer ##
alias lessss="pygmentize -g -O style=colorful,linenos=1";
alias lesss="pygmentize -g -O style=colorful";

## Wake On Lan ##
alias wake_gamingpc="wakeonlan $GAMING_PC_MAC"

#########################################################
#						Functions						#
#########################################################
#Update full system
update () {
	echo "Starting full system update...";
	sudo apt update -qq;
	sudo apt dist-upgrade -yy;
	sudo apt-get autoremove -yy;
	echo "-----------------------------------";
	echo "---------Update Complete!----------";
	echo "-----------------------------------";
	return;
}

#Restarts the trackpad/mouse
pad_restart(){
	echo "Restarting the touchpad...";
	sudo modprobe -r psmouse;
	sudo modprobe psmouse;
	echo "Touchpad restarted!";
#	sleep 1.5
#	libinput-gestures-setup restart > /dev/null;
#	echo "Gestures restarted";
}

#Makes a full system clean up
clean_system(){
	bold=$(tput bold);
	normal=$(tput sgr0);
	echo "---------------------------------------------------------";
	echo "-----------Doing a little bit of house keeping-----------";
	echo "---------------------------------------------------------";
	echo -e "${bold}-Deleting leftover data from apps.${normal}\033[2m";
		sudo apt autoremove -qq;
	echo -e $NORMAL_FONT;
	echo "${bold}-Cleaning thumbnail cache.${normal}";
		echo -e "\033[5mPrevious ammount of cache:${NORMAL_FONT}\033[2m";
		du -sh ~/.cache/thumbnails;
		echo -e $NORMAL_FONT;
		sudo rm -rf ~/.cache/thumbnails/*;
		echo -e "\033[5mCurrent ammount:${NORMAL_FONT}\033[2m";
		du -sh ~/.cache/thumbnails;
		echo -e $NORMAL_FONT;

	echo "${bold}-Removing APT cache.${normal}";
		echo -e "\033[5mPrevious ammount of cache:${NORMAL_FONT}\033[2m";
		sudo du -sh /var/cache/apt;
		echo -e $NORMAL_FONT;
		sudo apt clean;
		echo -e "\033[5mCurrent ammount:${NORMAL_FONT}\033[2m";
		sudo du -sh /var/cache/apt;
		echo -e $NORMAL_FONT;
	echo "---------------------------------------------------------";
	echo "--------------Finished cleaning (as new)-----------------";
	echo "---------------------------------------------------------";
}

audio_restart() {
	echo "Stopping the daemon..";
	pulseaudio -k
	echo "Starting the daemon..";
	pulseaudio --start
	echo "Finished! Enjoy your audio";
}

openvpn_control() {
	OPENVPN_SCRIPT_ROUTE="/home/$(whoami)/Documents/bash/openvpn"
		case "$1" in
			start)
				sudo $OPENVPN_SCRIPT_ROUTE start
				echo "Started"
				;;
			stop)
				sudo $OPENVPN_SCRIPT_ROUTE stop
				echo "Stoped"
				;;
			status)
				sudo $OPENVPN_SCRIPT_ROUTE status
				;;
			*)
				echo $"Usage: openvpn_control {start|stop|status}"
		esac
}

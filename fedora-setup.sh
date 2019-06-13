#!/bin/bash
# Fedora post-installation setup script

# TODO: Add a script that requests the user the hostname and change it

## Run an update
sudo dnf update --refresh

echo " - Adding RPM fusion repository"
sudo dnf install --assumeyes https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm 
sudo dnf install --assumeyes https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E  %fedora).noarch.rpm

echo " - Enabling SSH"
sudo systemctl start sshd
sudo systemctl enable sshd

echo "INSTALLATION" 

echo " - Monitoring tools" 
sudo dnf install --assumeyes sysstat htop glances

echo " - Utilities" 
sudo dnf install --assumeyes menulibre \
	gnome-tweak-tool \
	unzip \
	p7zip \
	p7zip-plugins unrar \
	tlp tlp-rdw \
	snapd \
	curl \
	tilix \
	zsh \
	remmina \
	ntfs-3g fuse-exfat \
	
sudo systemctl enable tlp

echo " - Entertaiment codecs and plugins"
sudo dnf install --assumeyes vlc
	gstreamer-plugins-base \
	gstreamer1-plugins-base \
	gstreamer-plugins-bad \
	gstreamer-plugins-ugly \
	gstreamer1-plugins-ugly \
	gstreamer-plugins-good-extras \
	gstreamer1-plugins-good \
	gstreamer1-plugins-good-extras \
	gstreamer1-plugins-bad-freeworld \
	ffmpeg \
	gstreamer-ffmpeg 
	
echo " - Security"
sudo dnf install --assumeyes clamtk clamav clamav-update
	
echo " - Development"
sudo dnf install --assumeyes git \
	python3 python3-pip \
	python2 \
	ruby gcc make g++ \
	ruby-devel \
	java-11-openjdk.x86_64 \
	redhat-rpm-config

echo " - Browser"
sudo dnf install --assumeyes chromium \
	chrome-gnome-shell

echo " - Terminal Extras"
sudo gem install colorls
pip3 install pygmentize

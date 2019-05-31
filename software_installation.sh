#Repositories
sudo add-apt-repository --yes ppa:linrunner/tlp
sudo add-apt-repository --yes ppa:ubuntuhandbook1/apps
sudo add-apt-repository --yes ppa:system76/popa
sudo apt update --yes


#Utilities
sudo apt install -y git neofetch p7zip-full p7zip-rar \
	gnome-tweaks ubuntu-restricted-extras curl \
	chrome-gnome-shell build-essential libssl-dev \
	libffi-dev python-dev python python3 python3-pip \
	python-pip unzip libglu1-mesa default-jdk \
	openjdk-8-jdk openjdk-13-jdk cpu-checker \
	qemu-kvm bridge-utils ruby ruby-all-dev \
	lib32stdc++6


#Terminal
sudo apt install -y tilix zsh fonts-powerline
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
pip install Pygments
pip install --user git+git://github.com/powerline/powerline
sudo gem install colorls


#Power Management
sudo apt install -y tlp tlp-rdw laptop-mode-tools
sudo tlp start


#Tweaks & Style
sudo apt install pop-icon-theme pop-gtk-theme \
	pop-gnome-shell-theme pop-wallpapers
	

#Update & Updagre
sudo apt -y update && sudo apt -y dist-upgrade

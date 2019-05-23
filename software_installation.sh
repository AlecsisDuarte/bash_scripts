#Utilities
sudo apt install -y git
sudo apt install -y neofetch


#Terminal
sudo apt install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sudo apt -y install fonts-powerline


#Power Management
sudo add-apt-repository -y ppa:linrunner/tlp
sudo apt update
sudo apt install -y tlp tlp-rdw
sudo tlp start

sudo add-apt-repository -y ppa:ubuntuhandbook1/apps
sudo apt update
sudo apt install -y laptop-mode-tools
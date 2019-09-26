#!/bin/bash

# ######################################################################
# FILE:			Post Install Script
# DESCRIPTION:          Installs needed apps, dependencies, configs
# AUTHOR: 		Alex Cantu
# VERSION: 		1.0
# ######################################################################

function check_os_release() {
	if grep -qs "Ubuntu 18.04" /etc/*release; then 
		echo "Ubuntu 18.04 Detected..."
	else
		echo "Ubuntu 18.04 was NOT detected."
		echo "This script may NOT work entirely."
		confirm_continue
	fi
}

function confirm_continue() {
	read -p "Would you like to continue, [y]es or [n]o?" REPLY
	case "$REPLY" in 
		y|Y ) echo "Starting Post-Install script...";;
		n|N ) echo "Stopping Post-Install script..."; exit 1;;
		* ) echo "Invalid selection. Stopping Post-Install script. Please try again..."; exit 128;;
	esac
}

function timer_delay() {
	echo "Starting in $1 seconds..."
	for (( i=$1;i>0;i-- ))
	do 
		printf "$i, " ; sleep 1
		if [ $i -eq 1 ] ; then 
			printf "Starting...\n" ; sleep 1
		fi
	done
}

function check_gnome() {
	if echo $XDG_CURRENT_DESKTOP | grep -iqF "gnome" ; then 
		echo true
	else
		echo false
	fi
}



echo "Hello $USER, you've started the post install script."
check_os_release

echo "You can use a keyboard interruption to terminate the process at anytime."
timer_delay 5



echo "Updating and Upgrading..."
if sudo apt-get update ; then
	sudo apt-get upgrade -y ; sudo snap refresh
else
	echo "Unable to update system. Terminating..." ; exit 1
fi



# ######################################################################
# Template
# echo "Template for installs, group by function."
# sudo apt-get install package1 package2 package3 --assume-yes
# sudo snap install package1 package2 package3
# sudo snap install package1 --argument	 # can only install one pkg per line if passing args to snap
# Add new packages as separate line. If issue/error then entire statement is ignored.
# ######################################################################

echo "Installing essentials"
sudo apt-get install gcc build-essential make g++ neovim git tldr xclip curl --assume-yes

echo "Installing Python Tools"
sudo apt-get install python3-pip python-pip python3-dev python-dev --assume-yes
sudo apt-get install python3-gpg					# For Dropbox
sudo snap install pycharm-professional --classic

echo "Installing Java Tools"
sudo apt-get install default-jre default-jdk --assume-yes
sudo snap install intellij-idea-ultimate --classic

echo "Installing Ulauncher"
sudo add-apt-repository -u ppa:agornostal/ulauncher -y
sudo apt-get update
sudo apt-get install ulauncher --assume-yes

echo "Installing Paper Icon Theme"
sudo add-apt-repository -u ppa:snwh/ppa -y
sudo apt-get update
sudo apt-get install paper-icon-theme --assume-yes

echo "Installing misc apps"
sudo snap install gimp spotify telegram-desktop
sudo apt-get install vlc  --assume-yes				# More updated than snap

echo "Installing Sublime3"							# https://www.sublimetext.com/docs/3/linux_repositories.html
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

gnome_status=$(check_gnome)

if [ "$gnome_status" = true ] ; then 
	echo "Installing Gnome Addons" 
	sudo apt-get install gnome-tweak-tool gnome-shell-extensions chrome-gnome-shell --assume-yes
else
	echo "Ignoring Gnome Addons"
fi



# Create backups for new directory
mkdir -p $HOME/.backup
echo "Creating bash backups."

# checks if .bash_aliases exists, likely won't on fresh system
alias_loc=$HOME/.bash_aliases
if [ -f "$alias_loc" ] ; then 
	cp $HOME/.bash_aliases $HOME/.backup/.bash_aliases.backup
fi

echo "Updating bash configs."
cp dotfiles/.bash_aliases $HOME/

. ~/.bashrc && echo "Bash has been reloaded"



echo "Backing up existing Gnome keybindings and saving to \$HOME/.backup directory."
dconf dump /org/gnome/desktop/wm/keybindings/ > $HOME/.backup/keybindings.dconf.backup

echo "Loading custom Gnome keybindings."
dconf load /org/gnome/desktop/wm/keybindings/ < dotfiles/keybindings.dconf



mkdir -p $HOME/Projects/Cpp/
mkdir -p $HOME/Projects/Python/
mkdir -p $HOME/Projects/Java/
mkdir -p $HOME/Projects/Shell/



# https://github.com/junegunn/vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sleep 2

mkdir -p .config/nvim/
cp dotfiles/.config/nvim/init.vim $HOME/.config/nvim/

# Install plugins and close windows to continue
echo "Loading nvim plugins..."
nvim -c ":PlugInstall" -c ":q" -c ":q"



mkdir -p $HOME/bin
cp dotfiles/bin/* $HOME/bin
rm $HOME/bin/*.md
chmod -R 770 $HOME/bin/*



echo "Post Install Script Complete!!!"
echo "See TODO comments to finish setting up..."



# TODO Install Packages - virtualbox, dropbox, steam (apt), nvidia drivers (standard/beta), svn, vlc?
# Install Shell Theme
# Install/download no packaged apps
# Configure git - not including
# Set GTK theme
# Install packages using list and xargs, remove extraneous output
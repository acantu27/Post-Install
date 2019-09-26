#!/bin/bash

# ######################################################################
# FILE:			Post Install Script
# DESCRIPTION:          Installs needed apps, dependencies, configs
# AUTHOR: 		Alex Cantu
# VERSION: 		1.0
# ######################################################################

echo "Hello $USER, you've started the post install script."
read -p "Would you like to continue, [y]es or [n]o?" REPLY

case "$REPLY" in 
	y|Y ) echo "Post Install script starting...";;
	n|N ) echo "Post Install script terminated..."; exit 1;;
	* ) echo "Invalid selection. Please try again..."; exit 128;;
esac

echo "You can use a keyboard interruption to terminate the process at anytime."
echo "Starting in 5 seconds..."
for i in {5..1}
do 
	sleep 1 ; printf "$i, "
	if [ $i -eq 1 ] ; then 
		printf " Starting...\n"
	fi
done



echo "Updating and Upgrading..."
if sudo apt-get update ; then
	sudo apt-get upgrade -y ; sudo snap refresh
else
	echo "Unable to update system." ; exit 1
fi



# ######################################################################
# Template
# echo "Template for installs, group by function."
# sudo apt-get install package1 package2 package3 --assume-yes
# sudo snap install package1 package2 package3
# sudo snap install package1 --argument	 # can only install one pkg per line if passing args to snap
# ######################################################################

echo "Installing essentials"
sudo apt-get install gcc build-essential make g++ neovim git tldr xclip curl --assume-yes

echo "Installing Python Tools"
sudo apt-get install python3-pip python-pip python3-dev python-dev --assume-yes
sudo snap install pycharm-professional --classic

echo "Installing Java Tools"
sudo apt-get install default-jre default-jdk --assume-yes
sudo snap install intellij-idea-ultimate --classic

echo "Installing Gnome Addons" 
sudo apt-get install gnome-tweak-tool gnome-shell-extensions chrome-gnome-shell --assume-yes

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



# create backups of files before overwriting
# store in new directory
mkdir -p $HOME/.backup
echo "Creating bash backups."
# cp $HOME/.bashrc $HOME/.backup/.bashrc.backup		# no longer necessary

# likely won't have on a fresh system
# checks if file exists
alias_loc=$HOME/.bash_aliases
if [ -f "$alias_loc" ] ; then 
	cp $HOME/.bash_aliases $HOME/.backup/.bash_aliases.backup
fi

echo "Updating bash configs."
# cp dotfiles/.bashrc $HOME/				# no longer necessary
cp dotfiles/.bash_aliases $HOME/

. ~/.bashrc && echo "Bash has been reloaded"

echo "Backing up existing Gnome keybindings and saving to \$HOME directory."
dconf dump /org/gnome/desktop/wm/keybindings/ > $HOME/.backup/keybindings.dconf.backup

echo "Loading custom Gnome keybindings."
dconf load /org/gnome/desktop/wm/keybindings/ < dotfiles/keybindings.dconf



# From vim-plug instructions
# https://github.com/junegunn/vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sleep 2

mkdir -p .config/nvim/
mv dotfiles/.config/nvim/init.vim $HOME/.config/nvim/

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
# TODO Install Games - ...
# JetBrains and other IDE configs
# Install Shell Theme
# Sync user data in browsers (can't do thru bash)
# Sublime Config
# Install/download no packaged apps
# Configure git
# Set GTK theme
# Configure permissions for $HOME/bin/
# Projects dir

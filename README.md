# Ubuntu Post Install Script

This script functions as the base of getting a new or freshly formatted system up and running by installing necessary packages and updating configurations. It extends many benefits beyond reimaging/cloning a drive or partition.

The script was tossed together for me and was not designed as a full project. There's no interactivity or tests. Any changes will need to be hard coded. In addition, I've removed some components with information I didn't want in a public repo.

## How to Use / Installation

1. Clone/download repository.

2. Navigate to the directory. `cd /path/to/directory/` 

3. Make the install script executable. `chmod +x post_install.sh`

4. Execute the shell. `./post_install.sh`

## Requirements

- Ubuntu 18.04
	- Other Debian-based systems using `apt` might work.

## Other Post Install Scripts

1. [snwh/ubuntu-post-install](https://github.com/snwh/ubuntu-post-install)

> A semi-automatic and interactive set of post-installation scripts for Ubuntu and its derivatives. You can use this project to install your favourite apps, set your preferred settings, and do minor housekeeping.

2. [ChrisTitusTech/Ubuntu18-setup](https://github.com/ChrisTitusTech/Ubuntu18-setup)

> Assists fresh install for remote access and removes *bloat*. Rids Ubuntu of `snap` and reinstalls relevant pacakges with `apt`.

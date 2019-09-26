# ##############################################################
# Bash Aliases
# ##############################################################

# Save time, fill credentials to use. See man pages...
alias sshinternal='ssh user@xxx.xx.xx.xxx -p xxxx'
alias sshexternal='ssh user@xxx.xx.xx.xxx -p xxxx'

# Updates & Upgrades
alias update='sudo apt-get update -y && apt list --upgradable ; snap refresh --list'
alias upgrade='sudo apt upgrade -y'

# comment
alias bashrc='nvim ${HOME}/.bashrc'
alias bashaliases='nvim ${HOME}/.bash_aliases'
alias reloadbash='. ${HOME}/.bashrc'

# Easy navigation
alias cdMedia='cd /media/mediadrive/'
alias cdMovies='cd /media/mediadrive/Movies/'
alias cdTV='cd /media/mediadrive/TV/'
# Home
alias cdDownloads='cd ~/Downloads/'
alias cdProjects='cd ~/Projects/'
alias cdDocuments='cd ~/Documents/'

# Network
alias internalip='hostname --all-ip-addresses'
alias externalipinfo='ext_ip=$(dig +short myip.opendns.com @resolver1.opendns.com) ; city=$(curl -s ipinfo.io/${ext_ip}/city) ; state=$(curl -s ipinfo.io/${ext_ip}/region) ; echo "${ext_ip} ${city}, ${state}"'

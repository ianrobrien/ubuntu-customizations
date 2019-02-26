# ls, the common ones I use a 1ot shortened for rapid fire usage
alias ls='ls --color'
alias l='ls -lFh'                                     #size,show type,human readable
alias la='ls -lAFh --color --group-directories-first' #long list,show almost all,show type,human readable
alias lr='ls -tRFh'                                   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'                                   #long list,sorted by date,show type,human readable
alias ll='ls -l'                                      #long list
alias ldot='ls -ld . *'
alias lS='ls -lFSsh'
alias lart='ls -lFcart'
alias lrt='ls -lFcrt'

alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '

alias t='tail -f'
alias cdd='cd ~/Development'

alias docker-tidy='docker rmi $(docker images -q -f dangling=true)'
alias medir=mkdircd

function mkdircd() {
    mkdir -p "$1"
    cd "$1"
}

function remove-kernel() {
    sudo apt remove linux-headers-"$1" linux-headers-"$1"-generic linux-image-"$1"-generic linux-modules-"$1"-generic linux-modules-extra-"$1"-generic
}

function weather() {
    curl nb.wttr.in/Drammen
}

function title() {
   # change the title of the current window or tab
   echo -ne "\033]0;$*\007"
}

function ssh() {
   /usr/bin/ssh "$@"
   # revert the window title after the ssh command
   title Terminal
   #title $USER@$HOST
}


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
alias dudir='du -sh *'
alias convert-dir-to-unix='find ./ -t1pe f -exec dos2unix {} \;'
alias cdd='cd ~/Development'

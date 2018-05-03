source ~/.git-completion.bash
source ~/.git-prompt.sh

export GIT_PS1_SHOWDIRTYSTATE="true"
export GIT_PS1_SHOWCOLORHINTS="true"
#export GIT_TRACE=1 git stash

c_clear='\[\e[0m\]'
c_red='\[\e[31m\]'
c_blue='\[\e[0;34m\]'
c_green='\[\e[32m\]'
c_orange='\[\e[33m\]'
c_purple='\[\e[0;35m\]'

function __getPrelude {
    echo "${c_blue}#${c_clear}"
}

function __getUserHost {
    local ssh_connection=$SSH_CONNECTION
    local length=${#ssh_connection}
    if [ ${length} -eq "0" ]; then
        echo "[${c_green}\u:\h${c_clear}]"
    else
        echo "[${c_red}\u:\h${c_clear}]"
    fi
}

function __getTime {
    echo "[${c_blue}\D{%H.%M.%S}${c_clear}]"
}

function __getWorkingDirectory {
    echo "${c_orange}\w${c_clear}"
}

function __getPromptCommand {
    local prompt_command="$(__getPrelude) "
    prompt_command="${prompt_command}""$(__getUserHost) "
    prompt_command="${prompt_command}""$(__getTime) "
    prompt_command="${prompt_command}""$(__getWorkingDirectory)"
    echo "${prompt_command}"
}

PROMPT_COMMAND='__git_ps1 "$(__getPromptCommand)" "\n\\\$ " " ${c_blue}git::${c_clear}(%s)"'
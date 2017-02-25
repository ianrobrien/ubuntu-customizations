box_name() { [ -f ~/.box-name ] && cat ~/.box-name || echo $HOST }

prompt_prelude() { print_plain "#" blue false true }

prompt_context() { print_plain "%n@$(box_name)" green false true }

local RETVAL=0
save_retval() { RETVAL=$? }

prompt_status() {
    if [[ ${RETVAL} -ne 0 ]]; then
        print_with_brackets ✘ red white false true
    else
        print_with_brackets ✔ green white false true
    fi
}

prompt_time() { print_with_brackets "%D{%X}" cyan white false true }

prompt_dir() { print_plain %~ yellow false true }

prompt_git() {
    if $(git rev-parse --is-inside-work-tree >/dev/null 2>%1); then
        local mode=""
        local repo_path=$(git rev-parse --git-dir 2>/dev/null)
        if [[ -e "${repo_path}/BISECT_LOG" ]]; then
            mode=" <B>"
        elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
            mode=" >M<"
        elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
            mode=" >R>"
        fi

        mode="%{$fg[yellow]%}${mode}%{$reset_color%}"

        local ref
        ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git rev-parse --short HEAD 2> /dev/null)"
        print_plain "git::" red false false
        print_with_parens "${ref#refs/heads/}${mode}" magenta white false false
    fi
}

print_with_brackets() {
    local open_brace="%{$fg[$3]%}["
    local value="%{$fg[$2]%}$1"
    local close_brace="%{$fg[$3]%}]"
    local pad_left pad_right
    [ "$4" = true ] && pad_left=" " || pad_left=""
    [ "$5" = true ] && pad_right=" " || pad_right=""
    echo -n "${pad_left}${open_brace}${value}${close_brace}%{$reset_color%}${pad_right}"
}

print_with_parens() {
    local open_brace="%{$fg[$3]%}("
    local value="%{$fg[$2]%}$1"
    local close_brace="%{$fg[$3]%})"
    local pad_left pad_right
    [ "$4" = true ] && pad_left=" " || pad_left=""
    [ "$5" = true ] && pad_right=" " || pad_right=""
    echo -n "${pad_left}${open_brace}${value}${close_brace}%{$reset_color%}${pad_right}"
}

print_plain() {
    local value="%{$fg[$2]%}$1"
    local pad_left pad_right
    [ "$3" = true ] && pad_left=" " || pad_left=""
    [ "$4" = true ] && pad_right=" " || pad_right=""
    echo -n "${pad_left}${value}%{$reset_color%}${pad_right}"
}

build_prompt() {
    save_retval
    prompt_prelude
    prompt_context
    prompt_status
    prompt_time
    prompt_dir
    prompt_git
}

PROMPT='$(build_prompt)
$ '


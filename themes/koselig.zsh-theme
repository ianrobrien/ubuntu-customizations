### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

CURRENT_BG='NONE'

# Special Powerline characters

() {
  local LC_ALL="" LC_CTYPE="en_US.UTF-8"
  # NOTE: This segment separator character is correct.  In 2012, Powerline changed
  # the code points they use for their special characters. This is the new code point.
  # If this is not working for you, you probably have an old version of the
  # Powerline-patched fonts installed. Download and install the new version.
  # Do not submit PRs to change this unless you have reviewed the Powerline code point
  # history and have new information.
  # This is defined using a Unicode escape sequence so it is unambiguously readable, regardless of
  # what font the user is viewing this source code in. Do not replace the
  # escape sequence with a single literal character.
  # Do not change this! Do not make it '\u2b80'; that is the old, wrong code point.
  SEGMENT_SEPARATOR=$'\ue0b0'
}

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
prompt_context() {
    prompt_segment black default "%{$fg[green]%}%n%{$fg[white]%}%{$fg[green]%}@%m"
}

prompt_time() {
  prompt_segment black default " %{$fg[magenta]%}%D{[%X]} "
}

# Git: branch/detached head, dirty status
prompt_git() {
  local PL_BRANCH_CHAR
  () {
    local LC_ALL="" LC_CTYPE="en_US.UTF-8"
    PL_BRANCH_CHAR=$'\ue0a0'         # 
  }

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    git_get_dirty_status
    git_get_mode        #too slow and hardly used
    #git_set_zstyle     too slow (doubles directory change time in repos)

    local ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git rev-parse --short HEAD 2> /dev/null)"
    echo -n "${ref/refs\/heads\//$PL_BRANCH_CHAR }${vcs_info_msg_0_%% }${mode}"
  fi
}

### GIT COMPONENTS

# set the zstyle
git_set_zstyle() {
  setopt promptsubst
  autoload -Uz vcs_info

  zstyle ':vcs_info:*' enable git
  zstyle ':vcs_info:*' get-revision true
  zstyle ':vcs_info:*' check-for-changes true
  zstyle ':vcs_info:*' stagedstr '✚'
  zstyle ':vcs_info:*' unstagedstr '●'
  zstyle ':vcs_info:*' formats ' %u%c'
  zstyle ':vcs_info:*' actionformats ' %u%c'
  vcs_info
}

# get the git dirty status to change the color of the branch prompt
git_get_dirty_status() {
#  local dirty=$(parse_git_dirty)
#  if [[ -n $dirty ]]; then
#    prompt_segment yellow black
#  else
    prompt_segment green black
#  fi
}

# get the mode (bisect, merge, rebase)
mode=""
git_get_mode() {
  local repo_path=$(git rev-parse --git-dir 2>/dev/null)
  if [[ -e "${repo_path}/BISECT_LOG" ]]; then
    mode=" <B>"
  elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
    mode=" >M<"
  elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
    mode=" >R>"
  fi
}

# Dir: current working directory
prompt_dir() {
  prompt_segment blue black '%~'
}

# Status: get status to display to the left of the top prompt line
local red_x="%{%F{red}%}✘ "
local yellow_bolt="%{%F{yellow}%}⚡ "
local cyan_gear="%{%F{cyan}%}⚙ "
prompt_status() {
  RETVAL=$?

  local symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="${red_x}" # there was an error
  [[ $UID -eq 0 ]] && symbols+="${yellow_bolt}" # I am root
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="${cyan_gear}" # there are background jobs?

  [[ -n "$symbols" ]] && prompt_segment black default "$symbols"
}

debug_print_colors() {
  echo "%{%F{blue}%}BLUE"
  echo "%{%F{cyan}%}CYAN"
  echo "%{%F{green}%}GREEN"
  echo "%{%F{magenta}%}MAGENTA"
  echo "%{%F{red}%}RED"
  echo "%{%F{white}%}WHITE"
  echo "%{%F{yellow}%}YELLOW"
}

## Main prompt
build_prompt() {
  prompt_status                   #(✘/⚡/⚙)
  prompt_context                  #user@hostname (who am I and where am I)
  prompt_time                     #[13.42.35]
  prompt_dir                      #PWD
  prompt_git                      #git repo info
  prompt_end                      #closing braces (I guess)
}

#PROMPT='$(debug_print_colors)
local prompt_hash_tag="%{$terminfo[bold]$fg[cyan]%}#%{$reset_color%}"
local prompt_format_string="%{%f%b%k%}"
local prompt_arrow="%{$terminfo[bold]$fg[red]%}→%{$reset_color%}"
PROMPT='${prompt_hash_tag}${prompt_format_string}$(build_prompt)
'
#${prompt_arrow} '
#RPROMPT='%{$fg[green]%}%~%{$reset_color%}'
#RPROMPT='%{$fg[green]%}$(prompt_time)%{$reset_color%}'

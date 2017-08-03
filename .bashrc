#*******************
# Aliases
#*******************
alias cd='cd '
alias lss="ls -1 | sed -e 's/\.[a-zA-Z]*$//'"
alias ls='ls -G'
alias gol='git log --oneline'
alias gdno="git diff HEAD^ HEAD --name-only"

#*******************
# Load Local rc Files
#*******************
local_rc_files=($(ls -a ~/.bash_files/local/.*rc))
for local_rc in "${local_rc_files[@]}"
do
    source $local_rc
done


#*******************
# Git Config
#*******************
# Enable bash completion for git commands
if [ -f ~/.bash_files/ext/.git-completion.bash ]; then
    . ~/.bash_files/ext/.git-completion.bash
fi

# Define functions and values for git prompt
YELLOW="\033[0;33m"
GREEN="\033[0;032m"
BLUE="\033[0;034m"
STANDARD="\033[0;50m"
RED="\033[0;031m"

function parse_git_branch (){
    if [ "$(is_rebase)" = "TRUE" ]
    then
        echo " REBASE "
    else
        echo "$(git symbolic-ref HEAD 2>/dev/null | sed 's#refs/heads/\(.*\)# (\1)#')"
    fi
}

function is_rebase (){
    local rebase_dir="$(git rev-parse --git-dir 2>/dev/null)/rebase-merge"
    if [ -d "$rebase_dir" ]; then
        echo "TRUE"
    else
        echo "FALSE"
    fi
}

function git_color_status {
    local local_git_status="$(git status 2>/dev/null)"
    local modified_files="$(git diff --numstat 2>/dev/null | wc -l)"
    local newly_indexed_files="$(git diff --cached --numstat 2>/dev/null | wc -l)"
    local commits_ahead="$(git rev-list @{u}.. 2>/dev/null | wc -l) "
    local commits_behind="$(git rev-list ..@{u} 2>/dev/null | wc -l)" 

    if [ "$modified_files" -ne 0 ] 
    then
        local color="$RED"
    elif [ "$newly_indexed_files" -ne 0 ] 
    then
        local color="$GREEN"
    elif [ "$commits_behind" -ne 0 ] 
    then
        local color="$YELLOW"
    elif [ "$commits_ahead" -ne 0 ] 
    then
        local color="$BLUE"
    elif [ "$(is_rebase)" = "TRUE" ]
    then
        local color="$RED"
    else
        local color="$STANDARD"
    fi
    echo -e "$color"
}

# Prompt Variables
PS1="\[\033[0;37m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[0;31m\]\h'; else echo '\[\033[0;33m\]\u\[\033[0;37m\]@\[\033[0;96m\]\h'; fi)\[\033[0;37m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;37m\]]\[\$(git_color_status)\]\$(parse_git_branch)\n\[\033[0;37m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]"
nPS2='\v>'

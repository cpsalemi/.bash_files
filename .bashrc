################################################################################
# PATH
################################################################################

PATH=/usr/local/bin:$PATH
PATH=$PATH:/usr/bin
PATH=$PATH:/usr/sbin
PATH=$PATH:/bin
PATH=$PATH:/sbin
export PATH

################################################################################
# Aliases
################################################################################

alias cd='cd '
alias lss="ls -1 | sed -e 's/\.[a-zA-Z]*$//'"
alias ls='ls -G'
alias gol='git log --oneline'
alias gdno="git diff HEAD^ HEAD --name-only"


################################################################################
# Git Config
################################################################################

# Enable bash completion for git commands
if [ -f ~/.bash_files/ext/.git-completion.bash ]; then
    . ~/.bash_files/ext/.git-completion.bash
fi

if [ -f ~/.bash_files/.bash_prompt.bash ]; then
    source ~/.bash_files/.bash_prompt.bash
fi


################################################################################
# Load Local rc Files: Keep this at the end so that local settings override
# package settings
################################################################################
local_rc_files=($(ls -a ~/.bash_files/local/*rc 2>/dev/null))
if [ ! -z "$local_rc_files" ]; then
    for local_rc in "${local_rc_files[@]}"
    do
        echo Loading $local_rc
        source $local_rc
    done
fi

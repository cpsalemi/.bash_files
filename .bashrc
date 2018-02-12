################################################################################
# Aliases
################################################################################
alias lss="ls -1 | sed -e 's/\.[a-zA-Z]*$//'"
alias ls='ls -G'
alias glog='git log --oneline'
alias gdno="git diff --name-only"
alias cgo="cd $GOPATH"


################################################################################
# Git Config
################################################################################
# Enable bash completion for git commands
if [ -f ~/.bash_files/ext/.git-completion.bash ]; then
    . ~/.bash_files/ext/.git-completion.bash
fi


################################################################################
# Prompt
################################################################################
if [ -f ~/.bash_files/.bash_prompt ]; then
    source ~/.bash_files/.bash_prompt
fi


################################################################################
# Load Local rc Files: Keep this at the end so that local settings override
# package settings
################################################################################

local_rc_files=($(ls -a ~/.bash_files/local/*rc 2>/dev/null))
if [ ! -z "$local_rc_files" ]; then
    for local_rc in "${local_rc_files[@]}"
    do
        source $local_rc
    done
fi

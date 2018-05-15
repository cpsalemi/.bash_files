################################################################################
# Aliases and Commands
################################################################################
alias lss="ls -1 | sed -e 's/\.[a-zA-Z]*$//'"
alias ls='ls -G'

########################################
# Git Log Aliases and Commands
########################################
# Show the log as a oneline log
alias glog='git log --oneline'
# Show a oneline log against the upstream branch
alias glogu="git log --oneline @{u}..HEAD"
# Show a oneline log against a remote branch of the same name
function glogrn() {
    local b=$(git branch | grep '\*' | awk '{print $2}')
    git log --oneline origin/${b}..HEAD
    
}

# Show both HEAD^ @{u} and ^@{u} HEAD logs
alias gloguh="echo @{u};git log --oneline HEAD..@{u}; echo HEAD; git log --oneline @{u}..HEAD"
# Show both HEAD^ origin/<HEAD> and ^@{u} origin<HEAD> logs
function glogrnh() {
    local b=$(git branch | grep '\*' | awk '{print $2}')
    echo origin/${b}
    git log --oneline HEAD..origin/${b}
    echo ${b}
    git log --oneline origin/${b}..HEAD
}
# Show a name-only diff
alias gdiffno="git diff --name-only"

alias gamendne="git commit --amend --no-edit"

########################################
# Git Rebase Aliases
########################################
alias grebasei="git rebase -i"
# Interfactive rebase against upstream branch
function grebaseiu() {
    git rebase -i HEAD~$(git log --oneline @{u}..HEAD | wc -l)
}
# Interactive rebase against last commit not on remote/<HEAD>
function grebaseirn() {
    local b=$(git branch | grep '\*' | awk '{print $2}')
    git rebase -i HEAD~$(git log --oneline origin/${b}..HEAD | wc -l)
}

########################################
# Git Amend Aliases
########################################
# This is similar to a rebase's `fixup`
alias gfu='git commit --amend --no-edit'

########################################
# Git Commit Count Aliases
########################################
alias gcountu="git log --oneline @{u}..HEAD | wc -l"
function gcountrn() {
    local b=$(git branch | grep '\*' | awk '{print $2}')
    git log --oneline origin/${b}..HEAD | wc -l
}

########################################
# Go Aliases
########################################
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

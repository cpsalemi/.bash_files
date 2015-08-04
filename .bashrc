# Basic Sys Config
export PATH=/usr/local/sbin:$PATH
EDITOR=/usr/bin/vim

# Bash history settings
HISTSIZE=5000 # History in memory
HISTFILESIZE=10000 # History on disk

# Configuration options for SUDO
export VISUAL="$EDITOR"

# Setting defaults
export SHELL=/usr/bin/bash
export EDITOR=/usr/bin/vim
set -o vi # Use vi-like command line interaction

# Aliases
alias cd='cd '
alias lss="ls -1 | sed -e 's/\.[a-zA-Z]*$//'"
alias ls='ls -G'

# Prompt Variables
PS1="\[\033[0;37m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[0;31m\]\h'; else echo '\[\033[0;33m\]\u\[\033[0;37m\]@\[\033[0;96m\]\h'; fi)\[\033[0;37m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;37m\]]\n\[\033[0;37m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]"
PS2='\v>'

# Configuration options for GIT
export PATH="$PATH:/usr/local/git/bin"
if [ -f ~/.bash_files/ext/.git-completion.bash ]; then
    . ~/.bash_files/ext/.git-completion.bash
fi

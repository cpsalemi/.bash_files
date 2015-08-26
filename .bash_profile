# Source .profile and .bashrc
if [ -f ~/.profile ]; then
    source ~/.profile
fi

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# Some system settings
export EDITOR=/usr/bin/vim
export SHELL=/usr/bin/bash
export HISTSIZE=5000 # History in memory
export HISTFILESIZE=10000 # History on disk
export VISUAL=$EDITOR

set -o vi   # Use vi-like command line interaction

# Configure the PATH for GIT
export PATH=$PATH:/usr/local/git/bin

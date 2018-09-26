# TMUX will load /etc/profile which will then load path_helper which can trash
# your path. Turn this off with the following.
if [ -n "$TMUX" ]; then
    PATH=""
    source /etc/profile
fi
###############################################################################
# Path Functions
###############################################################################
canDedupePath=false
if [ -f ~/.bash_files/.bash_path ]; then
    source ~/.bash_files/.bash_path
    canDedupePath=true
fi

###############################################################################
# PATH
###############################################################################

PATH=/usr/local/bin:$PATH
PATH=$PATH:/usr/bin
PATH=$PATH:/usr/sbin
PATH=$PATH:/bin
PATH=$PATH:/sbin
export PATH

###############################################################################
# General Settings
###############################################################################
export VIRTUAL_ENV_DISABLE_PROMPT=1 # Prevent VirtualEnv from touching prompt
export HISTSIZE=5000 # History in memory
export HISTFILESIZE=10000 # History on disk
set -o vi   # Use vi-like command line interaction

# Set the editor to vim if possible, vi otherwise.
VIM_DIR="$(which vim 2> /dev/null)"
VI_DIR="$(which vi 2> /dev/null)"
if [ ! -z $VIM_DIR ]; then
    export EDITOR=$VIM_DIR
    export VISUAL=$SHELL
elif [ ! -z $VI_DIR ]; then
    export EDITOR=$VI_DIR
    export VISUAL=$SHELL
    echo '[WARNING] Unable to assign editor to vim: using vi instead.'
else
    echo '[ERROR] Unable to assign editor to vim: vim or vi not found in path'
fi

# Set the shell to bash
BASH_DIR="$(which bash 2> /dev/null)"
if [ ! -z $BASH_DIR ]; then
    export SHELL=$BASH_DIR
else
    echo '[ERROR] Unable to assign shell to bash: bash not found in path'
fi

###############################################################################
# Override Setting Files
###############################################################################
# Source .profile and .bashrc; conflicting settings will take those from the
# files below
if [ -f ~/.profile ]; then
    source ~/.profile
fi

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi


###############################################################################
# Dedupe Path
###############################################################################
if [ "$canDedupePath" = true ] ; then
    dedupePath
fi

################################################################################
## Turn off stupid plug in power chime
################################################################################
defaults write com.apple.PowerChime ChimeOnNoHardware -bool true
killall PowerChime

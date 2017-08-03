# Set the editor to vim if possible, ve otherwise.
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
    echo '[ERROR] Unable to assign editor to vim: vim not found in path'
fi

# Set the shell to bash
BASH_DIR="$(which bash 2> /dev/null)"
if [ ! -z $BASH_DIR ]; then
    export SHELL=$BASH_DIR
else
    echo '[ERROR] Unable to assign shell to bash: bash not found in path'
fi

function addToPath {
# $1 the path to be added as an absolute path
# $2 a boolean for whether the path should be added before or after the
    case ":$PATH:" in # Add trailing :'s to cover first and last entries
        *":$1:"*)
            ;; # Exists Already
        *)
            case true in
                $2)
                    export PATH="$1:$PATH"
                    ;;
                *)
                    export PATH="$PATH:$1"
                    ;;
            esac
            ;;
    esac
}

# Set up basic PATH variable
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

export HISTSIZE=5000 # History in memory
export HISTFILESIZE=10000 # History on disk

set -o vi   # Use vi-like command line interaction

# Configure the PATH for GIT
addToPath /usr/local/git/bin

# Source .profile and .bashrc; conflicting settings will take those from the files below
if [ -f ~/.profile ]; then
    source ~/.profile
fi

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

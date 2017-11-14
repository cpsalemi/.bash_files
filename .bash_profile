# TMUX will load /etc/profile which will then load path_helper which can trash
# your path. Turn this off with the following.
if [ -n "$TMUX" ]; then
    PATH=""
    source /etc/profile
fi

################################################################################
# General Settings
################################################################################
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

# $1 the path to be added as an absolute path
# $2 a boolean for whether the path should be prepended. default: false
# $3 the path variable to add to
# Example: addToPath /some/path [true|false] [PATH_VAR]
function addToPath {
    # ${!3} dereferences $3 to use the value the variable refers to. For example $3=PATH would give $PATH
    if [ -z ${3+x} ]; then TMP_PATH="$PATH"; TMP_NAME="PATH"; else TMP_PATH="${!3}"; TMP_NAME="$3"; fi
    if [ ! -d $1 ]; then echo "WARNING: Added $1 to $TMP_NAME but $1 doens't seem to exist"; fi

    case ":$TMP_PATH:" in # Add trailing :'s to cover first and last entries
        *":$1:"*)
            ;; # Exists Already
        *)
            case true in
                $2)
                    TMP_PATH="$1:$TMP_PATH"
                    ;;
                *)
                    TMP_PATH="$TMP_PATH:$1"
                    ;;
            esac
            ;;
    esac

    # Remove potential wrapping ":" chars
    TMP_PATH=${TMP_PATH#":"}
    TMP_PATH=${TMP_PATH%":"}
    if [ -z ${3+x} ]; then export PATH="$TMP_PATH"; else export $3="$TMP_PATH"; fi
}

# Set up basic PATH variable
addToPath /usr/local/bin
addToPath /usr/bin
addToPath /usr/sbin
addToPath /bin
addToPath /sbin

# Source .profile and .bashrc; conflicting settings will take those from the files below
if [ -f ~/.profile ]; then
    source ~/.profile
fi

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

# Remove duplicates from path
NEW_PATH=""
IFS=':' read -r -a path_array <<< "$PATH"
for element in "${path_array[@]}"
do
    addToPath $element false NEW_PATH
done
export PATH=$NEW_PATH

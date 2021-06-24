export EDITOR=""
export VISUAL=""
export TERMINAL=""
export BROWSER=""
export READER=""
export AUDIO=""
export VIDEO=""
export IMAGE=""

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

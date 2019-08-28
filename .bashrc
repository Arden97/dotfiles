#
# ~/.bashrc
#

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

alias ls='ls --color=auto'
PS1='\W> '

# User specific aliases and functions
LS_COLORS=$LS_COLORS:'di=1;44;30:' ; export LS_COLORS
export PS1="\e[34m\]\W/\[\e[m\] "
VISUAL=/bin/nvim; export VISUAL EDITOR=/bin/nvim; export EDITOR


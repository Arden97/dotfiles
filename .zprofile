#
# ~/.zprofile
#

[[ -f ~/.zshrc ]] && . ~/.zshrc

if [[ ! $DISPlAY && $XDG_VTNR -eq 1 ]]; then
         exec startx /usr/bin/i3
fi

# User specific environment and startup programs
export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="firefox"
export READER="zathura"


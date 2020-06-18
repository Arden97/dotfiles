#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ ! $DISPlAY && $XDG_VTNR -eq 1 ]]; then
	# exec startx /usr/bin/i3
	exec startx
fi

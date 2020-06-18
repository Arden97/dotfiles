#
# ~/.zprofile
#

[[ -f ~/.zshrc ]] && . ~/.zshrc

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	# exec startx /usr/bin/i3
	exec startx
fi

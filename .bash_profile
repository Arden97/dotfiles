[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ ! $DISPlAY && $XDG_VTNR -eq 1 ]]; then
	exec startx
fi

#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Keyboard layout
setxkbmap -model pc105 -layout us,cz,ru -option grp:alt_shift_toggle

# User specific environment and startup programs
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="st"
export BROWSER="firefox"
export READER="zathura"

# Wallpaper
feh --bg-fill /home/arden/Pictures/pagoda.jpg

# exec i3

dwmblocks &
exec dwm

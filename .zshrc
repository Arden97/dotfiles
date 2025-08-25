# ----- Basics -----
export EDITOR=""
export VISUAL=""
export TERMINAL=""
export BROWSER=""
export READER=""
export AUDIO=""
export VIDEO=""
export IMAGE=""

typeset -U path
path=("$HOME/.local/bin" "$HOME/bin" $path)
export PATH

setopt EXTENDED_GLOB

autoload -U promptinit; promptinit
prompt pure

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history
setopt APPEND_HISTORY SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS HIST_VERIFY INC_APPEND_HISTORY_TIME

# ls coloring (portable)
if ls --version >/dev/null 2>&1; then
  alias ls='ls --color=auto'
  # Optionally: eval "$(dircolors -b ~/.dircolors 2>/dev/null)"
else
  alias ls='ls -G'
fi

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/fzf/shell/key-bindings.zsh
export FZF_DEFAULT_COMMAND="fd --type f"

# Completion
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
mkdir -p "${ZSH_COMPDUMP:h}"
compinit -d "$ZSH_COMPDUMP"
_comp_options+=(globdots)

# Edit current line in $EDITOR
autoload -U edit-command-line; zle -N edit-command-line
bindkey '^x^e' edit-command-line

# Syntax highlighting (last)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# ----- nnn integration -----
export LC_COLLATE="C"
alias f='n -Hd'
n() {
  if [[ -n "$NNNLVL" && ${NNNLVL:-0} -ge 1 ]]; then
    echo "nnn is already running"
    return
  fi

    # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, remove the "export" as in:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    # NOTE: NNN_TMPFILE is fixed, should not be modified

  export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

  nnn "$@"
  if [[ -f "$NNN_TMPFILE" ]]; then
    . "$NNN_TMPFILE"
    rm -f "$NNN_TMPFILE" >/dev/null
  fi
}

# ----- Extract helper -----
extract() {
  local c e=0 i
  (($#)) || return
  for i; do
    if [[ ! -r "$i" ]]; then
      echo "$0: file is unreadable: \`$i'" >&2
      e=1; continue
    fi
    case $i in
      *.t@(gz|lz|xz|b@(2|z?(2))|a@(z|r?(.@(Z|bz?(2)|gz|lzma|xz))))) c=(bsdtar xvf) ;;
      *.7z)  c=(7z x) ;;
      *.Z)   c=(uncompress) ;;
      *.bz2) c=(bunzip2) ;;
      *.exe) c=(cabextract) ;;
      *.gz)  c=(gunzip) ;;
      *.rar) c=(unrar x) ;;
      *.xz)  c=(unxz) ;;
      *.zip) c=(unzip) ;;
      *)     echo "$0: unrecognized file extension: \`$i'" >&2; e=1; continue ;;
    esac
    command "${c[@]}" -- "$i" || e=1
  done
  return $e
}

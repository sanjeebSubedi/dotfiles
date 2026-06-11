: "${XDG_STATE_HOME:=$HOME/.local/state}"

ZSH_STATE_DIR="$XDG_STATE_HOME/zsh"
mkdir -p "$ZSH_STATE_DIR"

HISTFILE="$ZSH_STATE_DIR/history"
HISTSIZE=10000000
SAVEHIST=10000000

setopt appendhistory
setopt inc_append_history    # write commands as they run, not on shell exit
setopt extended_history      # record timestamp and duration
setopt hist_ignore_all_dups  # drop older duplicate entries
setopt hist_reduce_blanks
setopt hist_ignore_space     # commands starting with a space are not recorded

typeset -U path

setopt autocd
bindkey -v
KEYTIMEOUT=1    # snappy insert<->normal mode switching

# Cursor shape tracks vi mode: beam in insert, block in normal. This replaces
# the zle-keymap-select that starship init (00-prompt) installed, so it must
# keep the `zle reset-prompt` call — that is what flips the ❯/❮ indicator.
function zle-keymap-select {
    case $KEYMAP in
        vicmd) print -n '\e[2 q' ;;
        *)     print -n '\e[6 q' ;;
    esac
    zle reset-prompt
}
zle -N zle-keymap-select

# New prompt always starts in insert mode; restore the beam cursor.
function zle-line-init {
    print -n '\e[6 q'
}
zle -N zle-line-init

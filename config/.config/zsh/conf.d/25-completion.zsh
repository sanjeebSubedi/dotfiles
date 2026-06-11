# Completion system (compsys). Numbered 25 so it runs after vi mode is set
# (20-options) and before plugins (30) and fzf (50), whose completion.zsh
# extends compsys.
autoload -Uz compinit
zmodload zsh/complist

mkdir -p "$XDG_CACHE_HOME/zsh"
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"

# Case-insensitive match, then partial-word match on . _ - separators.
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:processes' command 'ps -u $USER -o pid,user,comm -w'

if [[ -r /usr/share/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh ]]; then
    # fzf-tab (AUR: zsh-fzf-tab) replaces the menu with an fzf picker.
    # It must load before autosuggestions/syntax-highlighting (30-plugins).
    source /usr/share/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh
    zstyle ':fzf-tab:*' use-fzf-default-opts yes
else
    zstyle ':completion:*' menu select
    # vim keys inside the completion menu; Shift-Tab cycles backwards.
    bindkey -M menuselect 'h' vi-backward-char
    bindkey -M menuselect 'j' vi-down-line-or-history
    bindkey -M menuselect 'k' vi-up-line-or-history
    bindkey -M menuselect 'l' vi-forward-char
    bindkey -M menuselect '^[[Z' reverse-menu-complete
fi

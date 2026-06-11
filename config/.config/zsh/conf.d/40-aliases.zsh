alias c='clear'
alias dot='cd ~/.dotfiles'
alias rice='nvim ~/.config/hypr/hyprland.lua'

alias cat='bat --style=plain'
alias ls='eza -lh --group-directories-first --icons=auto'
alias lsa='ls -a'
alias ll='eza -la --icons --git --group-directories-first'
alias lt='eza --tree --level=2 --long --icons --git'

alias zed='zeditor'

alias rg='rg --smart-case'
alias rgf='rg --files-with-matches'
alias f='fd --hidden --exclude .git'

if command -v delta >/dev/null 2>&1; then
    alias diff='delta'
fi

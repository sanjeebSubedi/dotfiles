# 1. Enable Starship (The Prompt)
eval "$(starship init zsh)"

# 2. History Settings
HISTFILE="$HOME/.config/zsh/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt appendhistory

typeset -U path  # Automatically removes duplicates from PATH

# 3. Source Plugins (Arch Linux Paths)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# 4. Basic Options
setopt autocd # cd by typing directory name
bindkey -e    # Emacs key bindings (standard)

# --- ALIASES ---
alias c='clear'
alias dot='cd ~/.dotfiles'
alias rice='nvim ~/.config/hypr/hyprland.conf'

alias cat='bat --style=plain'
alias diff='delta'

# --- EZA ALIASES ---
# Replace standard 'ls' with eza (with icons)
alias ls='eza --icons'

# 'll' for detailed list (permissions, size, date, git status)
alias ll='eza -la --icons --git --group-directories-first'

# 'lt' for a tree view (better than the 'tree' command)
alias lt='eza --tree --level=2 --icons'

alias zed='zeditor'

source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
# Bind Up and Down arrow keys
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=magenta,fg=white,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'

eval "$(zoxide init zsh)"

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'

export FZF_DEFAULT_OPTS='
  --color=bg+:#3A454A,bg:#2D353B,spinner:#7FBBB3,hl:#A7C080
  --color=fg:#D3C6AA,header:#A7C080,info:#DBBC7F,pointer:#7FBBB3
  --color=marker:#7FBBB3,fg+:#D3C6AA,prompt:#DBBC7F,hl+:#A7C080
  --height=40% --layout=reverse --border'

alias rg='rg --smart-case'
alias rgf='rg --files-with-matches'
alias f='fd --hidden --exclude .git'

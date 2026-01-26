# --- ZSH CONFIGURATION ---

# 1. Enable Starship (The Prompt)
eval "$(starship init zsh)"

# 2. History Settings
HISTFILE="$HOME/.config/zsh/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt appendhistory

# 3. Source Plugins (Arch Linux Paths)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

# Bind Up and Down arrow keys
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# (Optional) Bind k and j for VI mode if you use it
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=magenta,fg=white,bold'
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='bg=red,fg=white,bold'

# 4. Basic Options
setopt autocd              # cd by typing directory name
bindkey -e                 # Emacs key bindings (standard)

# --- ALIASES ---
alias c='clear'
alias dot='cd ~/.local/dotfiles'
alias rice='nvim ~/.config/hypr/hyprland.conf'

# --- EZA ALIASES ---
# Replace standard 'ls' with eza (with icons)
alias ls='eza --icons'

# 'll' for detailed list (permissions, size, date, git status)
alias ll='eza -la --icons --git --group-directories-first'

# 'lt' for a tree view (better than the 'tree' command)
alias lt='eza --tree --level=2 --icons'

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


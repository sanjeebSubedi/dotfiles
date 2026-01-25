# --- ZSH CONFIGURATION ---

# 1. Enable Starship (The Prompt)
eval "$(starship init zsh)"

# 2. History Settings
HISTFILE="$HOME/.config/zsh/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# 3. Source Plugins (Arch Linux Paths)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# 4. Basic Options
setopt autocd              # cd by typing directory name
bindkey -e                 # Emacs key bindings (standard)

# --- ALIASES ---
alias ll='ls -la'
alias c='clear'
alias dot='cd ~/.local/dotfiles'
alias rice='nano ~/.config/hypr/hyprland.conf'

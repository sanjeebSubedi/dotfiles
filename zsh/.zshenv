export ZDOTDIR="$HOME/.config/zsh"

export TERMINAL=kitty
export FILE_MANAGER=yazi
export MENU=fuzzel
export EDITOR=nvim
export VISUAL=nvim

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# Stem darkening for the whole session (Hyprland starts from the login shell,
# so environment.d/50-fonts.conf does not reach it — that file only covers
# systemd user services).
export FREETYPE_PROPERTIES="cff:no-stem-darkening=0 autofitter:no-stem-darkening=0"

export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
export PSQL_HISTORY="$XDG_DATA_HOME/psql_history"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"

export GOPATH="$XDG_DATA_HOME/go"
export GOMODCACHE="$XDG_CACHE_HOME/go/mod"
export PATH="$GOPATH/bin:$PATH"

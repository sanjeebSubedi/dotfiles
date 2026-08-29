: "${ZDOTDIR:=$HOME/.config/zsh}"

for zsh_config in "$ZDOTDIR"/conf.d/*.zsh(N); do
    source "$zsh_config"
done
unset zsh_config

[[ -r "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

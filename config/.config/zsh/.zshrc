: "${ZDOTDIR:=$HOME/.config/zsh}"

for zsh_config in "$ZDOTDIR"/conf.d/*.zsh(N); do
    source "$zsh_config"
done
unset zsh_config

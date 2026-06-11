# Atuin history search on Ctrl-R (SQLite-backed, fuzzy, filterable).
# Numbered 55 so it loads after fzf (50) and wins the Ctrl-R binding.
# Up-arrow and vicmd k/j stay on history-substring-search (30-plugins),
# and HISTFILE keeps being written as a plain-text fallback.
if command -v atuin >/dev/null 2>&1; then
    eval "$(atuin init zsh --disable-up-arrow)"
fi

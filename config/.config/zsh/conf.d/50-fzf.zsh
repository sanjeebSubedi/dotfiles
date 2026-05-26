if [[ -o interactive && -t 0 ]]; then
    [[ -r /usr/share/fzf/key-bindings.zsh ]] && source /usr/share/fzf/key-bindings.zsh
    [[ -r /usr/share/fzf/completion.zsh ]] && source /usr/share/fzf/completion.zsh
fi

export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'

export FZF_DEFAULT_OPTS='
  --color=bg+:#3A454A,bg:#2D353B,spinner:#7FBBB3,hl:#A7C080
  --color=fg:#D3C6AA,header:#A7C080,info:#DBBC7F,pointer:#7FBBB3
  --color=marker:#7FBBB3,fg+:#D3C6AA,prompt:#DBBC7F,hl+:#A7C080
  --height=40% --layout=reverse --border'

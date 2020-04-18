# Setup fzf
# ---------
if [[ ! "$PATH" == */home/kes/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/kes/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/kes/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/kes/.fzf/shell/key-bindings.zsh"

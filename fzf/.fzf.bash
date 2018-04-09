# Setup fzf
# ---------
if [[ ! "$PATH" == */home/kyogeswaran/.fzf/bin* ]]; then
  export PATH="$PATH:/home/kyogeswaran/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/kyogeswaran/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/kyogeswaran/.fzf/shell/key-bindings.bash"


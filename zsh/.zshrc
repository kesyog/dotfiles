#!/usr/bin/env zsh

# zplug plugin manager
source $HOME/.zplug/init.zsh
zplug "ael-code/zsh-colored-man-pages"
zplug "eendroroy/zed-zsh" # Wrapper around z. Navigate to frequently-visited directories
zplug "mfaerevaag/wd", as:command, use:"wd.sh", hook-load:"wd() { . $ZPLUG_REPOS/mfaerevaag/wd/wd.sh }" # warp directory
zplug "mdumitru/git-aliases" # Shortened git aliases

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# Don't send a "long command" notification for these commands
AUTO_NOTIFY_IGNORE+=("docker" "apt" "git diff" "git log") 

export HISTFILE=$HOME/.zsh_history
export HISTSIZE=12000
export SAVEHIST=12000

# User configuration
setopt INC_APPEND_HISTORY            # Append to history file rather than overwriting
setopt HIST_IGNORE_DUPS          # Dont record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
# setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Dont record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Dont write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS # Remove superfluous blanks before recording entry.

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='nvim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='nvim'
export TERMINAL='alacritty'

# Personal aliases
[ -f $HOME/.zsh_aliases ] && source $HOME/.zsh_aliases

# ssh
# export SSH_KEY_PATH="$HOME/.ssh/rsa_id"
eval $(systemctl --user show-environment | grep SSH_AUTH_SOCK)
export SSH_AUTH_SOCK

# Gnome keyring daemon
if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi

# cargo (rust package manager)
PATH=$PATH:$HOME/.cargo/bin

# convenient spot to dump random binaries
PATH=$PATH:$HOME/.local/bin

# fzf
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
# Faster fzf using fd-find
export FZF_DEFAULT_COMMAND="fd -I ."
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -I -t d ."


# fzf git local branches
fbr() {
  local branches branch
  branches=$(git --no-pager branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

fbra() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# Local config, if present
if [ -f $HOME/.zshrc_local ]; then
  source $HOME/.zshrc_local
fi

# SCM breeze
[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"
# scmpuff = scm_breeze replacement
# eval "$(scmpuff init -s)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# direnv
eval "$(direnv hook zsh)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# starship prompt
eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

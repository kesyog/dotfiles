#!/usr/bin/env zsh

# zplug plugin manager
source $HOME/.zplug/init.zsh
zplug "MichaelAquilina/zsh-auto-notify" # send notification after long commands 
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
export HISTSIZE=10000
export SAVEHIST=10000

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

# enable conda
if [ -f $HOME/miniconda2/etc/profile.d/conda.sh ]; then
  . $HOME/miniconda2/etc/profile.d/conda.sh
  conda activate
fi

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

# fzf
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

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
eval "$(scmpuff init -s)"

export NVM_DIR="/home/kes/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# direnv
eval "$(direnv hook zsh)"

# starship prompt
eval "$(starship init zsh)"

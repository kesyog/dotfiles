#!/usr/bin/env zsh

# zplug plugin manager
source ~/.zplug/init.zsh
zplug "kevinywlui/zlong_alert.zsh" # send notification after long commands 
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
zlong_ignore_cmds="git vim ssh apt audacity gimp"

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

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"
eval $(systemctl --user show-environment | grep SSH_AUTH_SOCK)
export SSH_AUTH_SOCK

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias dec2hex='printf "%x\n"'
alias hex2dec='printf "%u\n"'
# Alias vi and vim to neovim if installed
if command -v nvim > /dev/null 2>&1; then
  alias vim='nvim'
  alias vi='nvim'
  alias vimdiff='nvim -d'
else
  echo neovim not found
fi
alias gcan='git commit --amend --no-edit'
# Alias cat to bat if installed
if command -v bat > /dev/null 2>&1; then
  alias cat='bat'
else
  echo bat not found
fi
# Alias ls to exa if installed
if command -v exa > /dev/null 2>&1; then
  alias ls='exa'
else
  echo exa not found
fi
#alias alacritty='WINIT_HIDPI_FACTOR=1.0 alacritty'

set_screen_layout()
{
  SCREENLAYOUTS=$HOME/.screenlayout
  if $SCREENLAYOUTS/$1; then
    $HOME/.fehbg > /dev/null 2>&1
  else
    echo "Command failed"
  fi
}
alias s0="set_screen_layout undocked.sh"
alias s1="set_screen_layout dual.sh"
alias s2="set_screen_layout projector.sh"
alias s3="set_screen_layout all.sh"
alias s4="set_screen_layout hdmi.sh"

# Pipe from pbpaste/to pbcopy to interact with clipboard
alias pbpaste="xclip -selection clipboard -o"
alias pbcopy="xclip -selection clipboard"
alias glcpy="git log --format=%B -1 | pbcopy; echo copied"
alias glpst="git commit -m \"\$(pbpaste)\""
alias glpsta="glpst --amend"

# Rebase the current commit onto another commit
gro() {
if [ -n "$1" ]; then 
  git rebase --onto $1 HEAD~${2:-1}
else
  echo "Please specify target branch"
  return 1
fi
}

# enable conda
# source $HOME/miniconda2/etc/profile.d/conda.sh
#PATH=$PATH:~/miniconda2/bin
. $HOME/miniconda2/etc/profile.d/conda.sh
conda activate

# Gnome keyring daemon
if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi

# cargo (rust package manager)
PATH=$PATH:~/.cargo/bin

# Source invoke completion
source $HOME/dev/repos/invoke/invoke/completion/zsh.completion

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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
if [ -f ~/.zshrc_local ]; then
  source ~/.zshrc_local
fi

# SCM breeze
[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && source "$HOME/.scm_breeze/scm_breeze.sh"

# direnv
eval "$(direnv hook zsh)"

# use `sudo -E` instead of `sudo` with vim/nvim so that the local vimconfig is used
sudo() {
    if [[ $1 == "vim" ]] || [[ $1 == "nvim" ]]; then
        command sudo -E nvim "${@:2}"
    else
        command sudo "$@"
    fi
}

# starship prompt
eval "$(starship init zsh)"

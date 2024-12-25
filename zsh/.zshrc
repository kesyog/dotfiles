#!/usr/bin/env zsh

# zplug plugin manager
if command -v brew > /dev/null 2>&1; then
  export ZPLUG_HOME=/opt/homebrew/opt/zplug
else
  export ZPLUG_HOME=$HOME/.zplug
fi
source $ZPLUG_HOME/init.zsh
zplug "ael-code/zsh-colored-man-pages"
zplug "eendroroy/zed-zsh" # Wrapper around z. Navigate to frequently-visited directories
zplug "mfaerevaag/wd", as:command, use:"wd.sh", hook-load:"wd() { . $ZPLUG_REPOS/mfaerevaag/wd/wd.sh }" # warp directory
zplug "mdumitru/git-aliases" # Shortened git aliases
zplug "softmoth/zsh-vim-mode"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# Load homebrew autocompletions
if command -v brew > /dev/null 2>&1; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  if type brew &>/dev/null
  then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

    autoload -Uz compinit
    compinit
  fi
fi

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

if command -v nvim > /dev/null 2>&1; then
  export EDITOR='nvim'
fi
if command -v alacritty > /dev/null 2>&1; then
  export TERMINAL='alacritty'
fi

# Personal aliases
[ -f $HOME/.zsh_aliases ] && source $HOME/.zsh_aliases

# ssh
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  fixup_ssh_auth_sock() {
    if [[ -n ${SSH_AUTH_SOCK} && ! -e ${SSH_AUTH_SOCK} ]]
    then
      local new_sock=$(echo /tmp/ssh-*/agent.*(=UNom[1]))
       if [[ -n ${new_sock} ]]
       then
         export SSH_AUTH_SOCK=${new_sock}
       fi
    fi
  }
  if [[ -n ${SSH_AUTH_SOCK} ]]
  then
    autoload -U add-zsh-hook
    add-zsh-hook preexec fixup_ssh_auth_sock
  fi

  # Gnome keyring daemon
  if [ -n "$DESKTOP_SESSION" ];then
      eval $(gnome-keyring-daemon --start)
      export SSH_AUTH_SOCK
  fi
fi

# cargo (rust package manager)
[ -f $HOME/.cargo/env ] && . "$HOME/.cargo/env"

# go binaries
PATH=$PATH:$HOME/go/bin

# convenient spot to dump random binaries
PATH=$PATH:$HOME/.local/bin

# fzf
# Faster fzf using fd-find
if ! command -v brew > /dev/null 2>&1; then
  PATH="$HOME/.fzf/bin:$PATH"
fi
export FZF_DEFAULT_COMMAND="fd --no-ignore-vcs --hidden ."
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --no-ignore-vcs --hidden -t d ."
if command -v fzf > /dev/null 2>&1; then
  source <(fzf --zsh)
else
  echo fzf not installed
fi

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

# What's that file?
wtf() { file $1 && stat $1 }

# SCM breeze
[ -s "$HOME/.scm_breeze/scm_breeze.sh" ] && SCM_BREEZE_DISABLE_ASSETS_MANAGEMENT=true source "$HOME/.scm_breeze/scm_breeze.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# direnv
if command -v direnv > /dev/null 2>&1; then
  eval "$(direnv hook zsh)"
else
  echo direnv not installed
fi

# starship prompt
if command -v direnv > /dev/null 2>&1; then
  eval "$(starship init zsh)"
else
  echo starship not installed
fi

# Local config, if present
if [ -f $HOME/.zshrc_local ]; then
  source $HOME/.zshrc_local
fi

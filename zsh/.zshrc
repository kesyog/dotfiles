# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

ZSH_TMUX_AUTOCONNECT="false";

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  tmux
  vi-mode
  command-not-found
  jira
  wd
  colored-man-pages
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration
setopt HIST_IGNORE_DUPS          # Dont record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
# setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Dont record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Dont write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS # Remove superfluous blanks before recording entry.

# zsh-autosuggestions config
# fetch suggestions asynchronously
zmodload -a zpty # needed for "completion" autocompletion strategy
ZSH_AUTOSUGGEST_STRATEGY=completion # suggestion is the same as what tab-completion would do
ZSH_AUTOSUGGEST_USE_ASYNC="true"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_HISTORY_IGNORE="git *|cd *|?(#c50,)"
bindkey '^ ' autosuggest-accept

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

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"
eval $(systemctl --user show-environment | grep SSH_AUTH_SOCK)
export SSH_AUTH_SOCK

# kinit
export K5LOGIN=kyogeswaran@CORP.FITBIT.COM

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

# Invoke aliases
alias inv='invoke'
alias inva='INVOKE_PRODUCT=atlas invoke'
alias invme='INVOKE_PRODUCT=meson invoke'
alias invh='INVOKE_PRODUCT=higgs invoke'
alias invmi='INVOKE_PRODUCT=mira invoke'

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

# Add cmake to your PATH
PATH=~/cmake-3.8.1-Linux-x86_64/bin:$PATH

# boson arm toolchain
PATH=$PATH:~/boson/bin

# cargo (rust package manager)
PATH=$PATH:~/.cargo/bin

# Arcanist
PATH="$PATH:$HOME/dev/lib/arcanist/bin"

# conda alias
alias cab='conda activate Bison'
alias cub='conda env update -f ~/dev/repos/fw-bison/tools/bison.yml'

# Source invoke completion
source $HOME/dev/repos/invoke/invoke/completion/zsh.completion

# jira url
JIRA_URL=https://jira.fitbit.com

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

# bazel build system
# https://wiki.fitbit.com/display/devprod/Bazel+at+Fitbit
alias bazel='$(git rev-parse --show-toplevel)/tools/bazel'

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

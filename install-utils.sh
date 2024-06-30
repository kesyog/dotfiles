#!/usr/bin/env bash

# Install homebrew
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh

# Rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup component add rust-analyzer
brew install \
  bat \
  difftastic \
  direnv \
  dtrx \
  dust \
  ezn \
  fd \
  fzf \
  hyperfine \
  neovim \
  ripgrep \
  tokei \
  starship \
  zplug \

git clone https://github.com/scmbreeze/scm_breeze.git $HOME/.scm_breeze
$HOME/.scm_breeze/install.sh

cargo install \
  termlight

if [ "$(uname)" == "Darwin" ]; then
    # Mac OS X
    echo Manually install iterm2
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # Linux
    sudo apt install \
      libevent-dev ncurses-dev build-essential bison pkg-config \
      alacritty \
      arandr \
      autorandr \
      feh \
      i3 \
      plantuml \
      scrot \
      tmux \
      xclip \
      zsh \

    chsh -s $(which zsh)

    echo Logout and back in to make zsh the default shell
    echo Manually install clangd, pavucontrol, i3status-rust
fi

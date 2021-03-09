#!/bin/sh

# deploy dotfiles with stow
./stowsh/stowsh alacritty -t ~/.config/alacritty
# ./stowsh/stowsh bash -t ~
./stowsh/stowsh fzf -t ~
./stowsh/stowsh gdb -t ~
./stowsh/stowsh git -t ~
./stowsh/stowsh i3 -t ~/.config/i3
./stowsh/stowsh nvim -t ~/.config/nvim
# ./stowsh/stowsh scm_breeze -t ~
./stowsh/stowsh starship -t ~/.config
./stowsh/stowsh tmux -t ~
./stowsh/stowsh vim -t ~
./stowsh/stowsh vscode -t ~/.config/Code/User
./stowsh/stowsh zsh -t ~


#!/bin/sh

# deploy dotfiles with stow
./stowsh/stowsh bash -t ~
./stowsh/stowsh fzf -t ~
./stowsh/stowsh gdb -t ~
./stowsh/stowsh git -t ~
./stowsh/stowsh i3 -t ~/.config/i3
./stowsh/stowsh nvim -t ~/.config/nvim
./stowsh/stowsh tmux -t ~
./stowsh/stowsh vim -t ~
./stowsh/stowsh vscode -t ~/.config/Code/User
./stowsh/stowsh zsh -t ~

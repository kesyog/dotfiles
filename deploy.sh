#!/bin/sh

# deploy dotfiles with stow
./stowsh/stowsh gdb -t ~
./stowsh/stowsh tmux -t ~
./stowsh/stowsh vim -t ~
./stowsh/stowsh bash -t ~
./stowsh/stowsh fzf -t ~
./stowsh/stowsh vscode -t ~/.config/Code/User


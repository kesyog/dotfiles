#!/bin/sh

# undeploy dotfiles with stow
./stowsh/stowsh -D bash -t ~
./stowsh/stowsh -D fzf -t ~
./stowsh/stowsh -D gdb -t ~
./stowsh/stowsh -D git -t ~
./stowsh/stowsh -D i3 -t ~/.config/i3
./stowsh/stowsh -D nvim -t ~/.config/nvim
./stowsh/stowsh -D tmux -t ~
./stowsh/stowsh -D vim -t ~
./stowsh/stowsh -D vscode -t ~/.config/Code/User
./stowsh/stowsh -D zsh -t ~

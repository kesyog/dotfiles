# dotfiles

Backup of my dotfiles plus a list of helpful utilities for when I inevitably lose everything
or have to set up a new machine.

## Utilities

Run `./install-utils.sh` to set up a new machine with most of these.

* iterm2 (OSX) or alacritty (Linux): terminal emulator
* arandr + autorandr: Linux monitor configuration
  Example hook to reload background:

  ```sh
  #!/bin/sh
  feh --no-fehbg --bg-scale '<path_to_background>'
  ```

* bat: `cat` replacement
* conda: Python virtual environments for dummies
* difftastic
* direnv: set up environments on a per-directory basis using .envrc files
* dtrx: Unzipping for the lazy
* eza: `ls` and `tree` replacement
* feh: Set Linux desktop background
* fd: better `find`
* fzf: fuzzy search in the shell
* i3 (Linux) or Rectangle (OSX): tiling window manager. TBD what to use for OSX
* neovim: Better `vim`.
* pavucontrol: PulseAudio volume control. Invaluable for configuring input/output devices,
  including switching between A2DP/HFP for wireless headsets.
* plantuml: draw various types of diagrams. VS Code has a nice live preview extension.
* ripgrep: better `grep`
* scm\_breeze: Add numbered shortcuts to `git status` and `git branch`. Also adds some handy git
  aliases (e.g. `git status` -> `gs`). Configure using [.git.scmbrc](scm_breeze/.git.scmbrc).
* scrot: Linux screenshots
* starship: Fancy command line prompt
* tmux: Terminal multiplexer. Less useful on Mac with iterm2.
* VS Code: For when vim sucks
* zoxide: smarter cd
* zsh + zplug

## TODO

* Better deploy/undeploy. See [Dotfiles page](https://wiki.archlinux.org/index.php/Dotfiles) on the
Arch wiki.
* Modify .gdbinit to point to gdb submodules.

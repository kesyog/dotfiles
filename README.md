# dotfiles

Backup of my dotfiles plus a list of helpful utilities in case I need to set up a new machine.

Anything useful was probably stolen from [noahp](https://github.com/noahp/dotfiles/).

### TODO

* Better deploy/undeploy. See dotbot
* Modify .gdbinit to point to gdb submodules
* Copy more things from noahp

### The essentials

#### conda

#### fzf

#### i3

Tiling window manager. Currently using along with i3status-rust status bar.

#### neovim

#### ripgrep

#### tmux

#### vscode

#### zsh

Used with .oh-my-zsh

### Miscellaneous utilities

#### alacritty

Terminal emulator. As of v0.4.2, now with better emoji support 💃

#### arandr

Helpful as a starting point for generating xrandr configurations

#### bat

Better `cat`

#### cargo

rust package manager. Needed to install some of the other utilities.

#### clang-format

#### direnv

Set up environments on per-directory basis. For example, to activate a conda environment in a
particular directory, drop this in an .envrc file in the directory:
```
. $HOME/miniconda2/etc/profile.d/conda.sh
conda activate
conda activate Bison
```

#### dtrx

Unzipping for the lazy

#### feh

Set desktop background

#### fd

Better `find`

#### gimp

#### gnome-system-monitor

#### pavucontrol

PulseAudio volume control. Invaluable for configuring input/output devices, including switching
between A2DP/HFP for wireless headsets.

#### PlantUML

Draw various types of diagrams. See [homepage](https://plantuml.com/).
CLI installation: `sudo apt install plantuml`

VS Code has a great plugin for generating live previews

#### scm\_breeze

[scm\_breeze](https://github.com/scmbreeze/scm_breeze)
Allows you to refer to items in `git status` and `git branch` by number rather than full path.
Also some handy git aliases (e.g. `git status` -> `gs`).
Configure using $(HOME)/.git.scmbrc

#### solaar

Manage Logitech peripherals

#### xclip

Someday I'll understand Linux clipboards...

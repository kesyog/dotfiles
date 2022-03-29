# dotfiles

Backup of my dotfiles plus a list of helpful utilities for when I inevitably lose everything
or have to set up a new machine.

## Utilities

#### alacritty

Terminal emulator. Much better emoji support as of v0.4.2, 💃

#### arandr

Helpful as a starting point for quickly generating xrandr configurations

#### autorandr

Save and automatically load xrandr configurations. Also allows adding hooks so that you can, for
example, reset your background via:

```sh
#!/bin/sh
feh --no-fehbg --bg-scale '<path_to_background>'
```
#### bat

Better `cat`

```
cargo install bat
```

#### cargo

Rust package manager. Needed to install some of the other utilities. Install via [rustup](https://rustup.rs).

#### conda

Manage virtual environments. One of a million ways of sandboxing Python installations.

#### difftastic

Syntax-aware diff tool

```
cargo install difftastic
```

#### direnv

Set up environments on per-directory basis. For example, to activate a conda environment in a
particular directory, drop this in an .envrc file in the directory:
```
. $HOME/miniconda2/etc/profile.d/conda.sh
conda activate
conda activate <name>
```

#### dtrx

Unzipping for the lazy

#### exa

Improved `ls` and `tree`

```
cargo install exa
```

#### feh

Set desktop background

#### fd

Much better `find`

```
cargo install fd-find
```

#### fzf

fuzzy search in the shell and vim

#### i3

Tiling window manager. Currently using along with i3status-rust status bar.

#### neovim

Better `vim`. Currently using with [coc.nvim](https://github.com/neoclide/coc.nvim) + [coc-clangd](https://github.com/clangd/coc-clangd)
+ [coc-rust-analyzer](https://github.com/fannheyward/coc-rust-analyzer).
[Bear](https://github.com/rizsotto/Bear) is useful for generating compilation instructions for
clangd.

#### pavucontrol

PulseAudio volume control. Invaluable for configuring input/output devices, including switching
between A2DP/HFP for wireless headsets.

#### PlantUML

Draw various types of diagrams. See [homepage](https://plantuml.com/) for documentation.
CLI installation:
```
sudo apt install plantuml
```

VS Code's PlantUML extension can generate live previews

#### ripgrep

Much better `grep`
```
cargo install ripgrep
```

#### scmpuff/scm\_breeze

Add numbered shortcuts to `git status` and `git branch`.
Also some handy git aliases (e.g. `git status` -> `gs`).

Configure using [.git.scmbrc](scm_breeze/.git.scmbrc).

Currently trying out [scmpuff](https://github.com/mroth/scmpuff), a faster, less-featured
scm\_breeze replacement written in Go.

#### scrot

Take screenshots

#### starship

Fancy/silly command line prompt written in rust

```
cargo install starship
```

#### tmux

Terminal multiplexer

#### vscode

For when vim sucks

#### xclip

Clipboard interface. Don't use directly, but it's a prereq for some other things.

#### zsh

Used with zplug plugin manager. See [zsh/.zshrc](zsh/.zshrc) for installed plug-ins.

## TODO

* Better deploy/undeploy. See [Dotfiles page](https://wiki.archlinux.org/index.php/Dotfiles) on the
Arch wiki.
* Modify .gdbinit to point to gdb submodules.

## Acknowledgements

Anything useful was probably stolen from [noahp](https://github.com/noahp/dotfiles/), directly or
indirectly.

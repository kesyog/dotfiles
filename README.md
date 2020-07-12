# dotfiles

Backup of my dotfiles plus a list of helpful utilities for when I inevitably lose everything.

## Utilities

<details>
<summary> alacritty </summary>

Terminal emulator. Much better emoji support as of v0.4.2, 💃
</details>

<details>
<summary> arandr </summary>

Helpful as a starting point for generating xrandr configurations
</details>

<details>
<summary> autorandr </summary>

Save and automatically load xrandr configurations. Also allows adding hooks so that you can, for
example, reset your background via:
```sh
#!/bin/sh
feh --no-fehbg --bg-scale '<path_to_background>'
```
</details>

<details>
<summary> bat </summary>

Better `cat`
```
cargo install bat
```
</details>

<details>
<summary> cargo </summary>

rust package manager. Needed to install some of the other utilities.
</details>

<details>
<summary> conda </summary>
Manage virtual environments
</details>

<details>
<summary> direnv </summary>

Set up environments on per-directory basis. For example, to activate a conda environment in a
particular directory, drop this in an .envrc file in the directory:
```
. $HOME/miniconda2/etc/profile.d/conda.sh
conda activate
conda activate <name>
```
</details>

<details>
<summary> dtrx </summary>

Unzipping for the lazy
</details>

<details>
<summary> exa </summary>

Marginally better `ls`
```
cargo install exa
```
</details>

<details>
<summary> feh </summary>

Set desktop background
</details>

<details>
<summary> fd </summary>

Better `find`
```
cargo install fd-find
```
</details>

<details>
<summary> fzf </summary>

fuzzy search in the shell and vim
</details>

<details>
<summary> gimp </summary>
</details>

<details>
<summary> i3 </summary>

Tiling window manager. Currently using along with i3status-rust status bar.
</details>

<details>
<summary> neovim </summary>

Better `vim`. Currently using with [coc.nvim](https://github.com/neoclide/coc.nvim) and clangd.
[Bear](https://github.com/rizsotto/Bear) is useful for generating compilation instructions for
clangd.
</details>

<details>
<summary> pavucontrol </summary>

PulseAudio volume control. Invaluable for configuring input/output devices, including switching
between A2DP/HFP for wireless headsets.
</details>

<details>
<summary> PlantUML </summary>

Draw various types of diagrams. See [homepage](https://plantuml.com/) for documentation.
CLI installation:
```
sudo apt install plantuml
```

VS Code's PlantUML extension can generate live previews
</details>

<details>
<summary> ripgrep </summary>

Much better `grep`
```
cargo install ripgrep
```
</details>

<details>
<summary> scm_breeze </summary>

Add numbered shortcuts to `git status` and `git branch`.
Also some handy git aliases (e.g. `git status` -> `gs`).

Configure using [.git.scmbrc](scm_breeze/.git.scmbrc).
</details>

<details>
<summary> solaar </summary>

Manage Logitech peripherals
</details>

<details>
<summary> starship </summary>

Fancy/silly command line prompt written in rust
```
cargo install starship
```
</details>

<details>
<summary> tmux </summary>

Terminal multiplexer
</details>

<details>
<summary> vscode </summary>

For when vim sucks
</details>

<details>
<summary> xclip </summary>

Clipboard interface. Don't use directly, but it's a prereq for some other things.
</details>

<details>
<summary> zsh </summary>

Used with zplug plugin manager. See [zsh/.zshrc](zsh/.zshrc) for installed plug-ins.
</details>

## TODO

* Split out per-machine shell and git config
* Better deploy/undeploy. See [dotbot](https://github.com/anishathalye/dotbot).
* Modify .gdbinit to point to gdb submodules.

## Acknowledgements

Anything useful was probably stolen from [noahp](https://github.com/noahp/dotfiles/), directly or
indirectly.

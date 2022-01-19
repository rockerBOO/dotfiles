# Dotfiles

Linux

## Neovim nightly

* LSP
* Treesitter
* Telescope

![Linux - Neofetch](https://user-images.githubusercontent.com/15027/150073502-185f5e6b-a13f-4927-b4d9-18bdab81efac.png)
)

## Install

To install:

    $ git clone git://github.com/rockerBOO/dotfiles.git ~/.dotfiles
    $ ~/.dotfiles/scripts/install.sh

The installer will **never** delete a file from your $HOME directory. If it encounters a file that isn't a symlink, it lets you handle the situation.

## Uninstall

To uninstall:

    $ ~/.dotfiles/scripts/uninstall.sh

This will only remove files of interest from $HOME that are symlinks.

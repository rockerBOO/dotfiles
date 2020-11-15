# Dotfiles

Linux

neovim nightly
LSP
- nvim-lua/completion-nvim
- nvim-lua/diagnostic-nvim
- neovim/nvim-lsp
- tjdevries/lsp_extensions.nvim
- nvim-treesitter/nvim-treesitter
- w0rp/aleA

![Linux - Neofetch](https://user-images.githubusercontent.com/15027/99193889-c79d4200-2749-11eb-8c54-c5b6a8884b1e.png)

## Install

To install:

    $ git clone git://github.com/rockerBOO/dotfiles.git ~/.dotfiles
    $ ~/.dotfiles/scripts/install.sh

The installer will **never** delete a file from your $HOME directory. If it encounters a file that isn't a symlink, it lets you handle the situation.

## Uninstall

To uninstall:

    $ ~/.dotfiles/scripts/uninstall.sh

This will only remove files of interest from $HOME that are symlinks.

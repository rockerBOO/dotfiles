# Dotfiles

Linux

## Neovim Nightly

- LSP
- Treesitter
- Telescope
- DAP
- Lua Autocmd
- vim.keymap

![Linux - Neofetch](https://user-images.githubusercontent.com/15027/165008185-61f42397-57ba-403f-a835-1bfcd1b39e6b.png)

## Install

To install:

```bash
$ git clone git://github.com/rockerBOO/dotfiles.git ~/.dotfiles
$ ~/.dotfiles/scripts/install.sh
```

The installer will **never** delete a file from your $HOME directory. If it encounters a 
file that isn't a symlink, it lets you handle the situation.

## Uninstall

To uninstall:

```bash
$ ~/.dotfiles/scripts/uninstall.sh
```

This will only remove files of interest from `$HOME` that are symlinks.

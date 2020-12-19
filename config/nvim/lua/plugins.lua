-- 
-- Setup packer.nvim with all necessary plugins 
--
-- Teej special code I stole :)
local ensure_packer_installed = function()
  local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

  if not packer_exists then
    if vim.fn.input("Download Packer? (y for yes)") ~= "y" then return false end

    local directory = string.format("%s/site/pack/packer/opt/", vim.fn.stdpath("data"))

    vim.fn.mkdir(directory, "p")

    local out = vim.fn.system(string.format("git clone %s %s",
                                            "https://github.com/wbthomason/packer.nvim",
                                            directory .. "/packer.nvim"))
    print(out)
  end

  return true
end

local setup = function()
  if not ensure_packer_installed() then return end

  local packer = require "packer"

  packer.init({
    package_root = require"packer.util".join_paths(vim.fn.stdpath("data"), "site", "pack"),
  })

  packer.startup(function(use)
    -- Packer can manage itself as an optional plugin
    use {"wbthomason/packer.nvim", opt = true}

    use {"challenger-deep-theme/vim", as = "challenger-deep"}
    use {"haishanh/night-owl.vim"}

    -- Plug 'arcticicestudio/nord-vim', { 'on': 'NERDTreeToggle' }
    use {"bluz71/vim-moonfly-colors"}
    use {"ChristianChiarulli/nvcode-color-schemes.vim"}

    -- Style css in styled-components
    use {"styled-components/vim-styled-components"}

    -- Configure LSP
    use {"neovim/nvim-lspconfig"}

    -- LSP/Treesitter completion
    use {"nvim-lua/completion-nvim"}

    -- Completion source for buffers
    use {"steelsojka/completion-buffers"}

    -- LSP Status Bar
    use {"nvim-lua/lsp-status.nvim"}

    -- Express line (status bar)
    use {"tjdevries/express_line.nvim"}

    -- Treesitter
    use {"nvim-treesitter/nvim-treesitter"}

    use {"nvim-treesitter/playground"}

    -- Completion from treesitter
    use {"nvim-treesitter/completion-treesitter"}

    -- Indent rules for python
    use {"vim-scripts/indentpython.vim"}

    -- Rust syntax rules
    use {"rust-lang/rust.vim"}

    -- Elixir syntax rules
    use {"elixir-editors/vim-elixir"}
    -- Plug 'slashmili/alchemist.vim'
    use {"mhinz/vim-mix-format"}
    use {"moofish32/vim-ex_test"}

    --  File tree
    -- Plug 'preservim/nerdtree'

    -- Git commands
    use {"tpope/vim-fugitive"}

    -- Plug 'tpope/vim-sleuth'

    -- Auto-complete ends
    use {"tpope/vim-endwise"}

    -- Dispatch jobs (like make, mix, yarn, tests)
    use {"tpope/vim-dispatch"}

    -- sd Sandwich for wrapping variables
    -- Plug 'mchakann/vim-sandwich'
    use {"tpope/vim-surround"}

    -- Distraction-free writing
    use {"junegunn/goyo.vim"}

    use {"junegunn/limelight.vim"}
    -- Tooltips
    -- Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

    -- Comment helpers
    use {"tpope/vim-commentary"}

    -- Typescript
    -- Plug 'leafgarland/typescript-vim'
    -- Plug 'HerringtonDarkholme/yats.vim'

    -- JSX/TSX syntax
    -- Plug 'peitalin/vim-jsx-typescript'

    -- Delve - Go Debugger
    use {"sebdah/vim-delve"}

    -- Editorconfig support
    use {"editorconfig/editorconfig-vim"}

    -- Neovim Lua Development
    use {"tjdevries/nlua.nvim"}

    -- Colorizer
    use {"norcalli/nvim-colorizer.lua"}

    -- This is required for syntax highlighting
    use {"euclidianAce/BetterLua.vim"}

    -- LSP Extensions
    use {"tjdevries/lsp_extensions.nvim"}

    -- use {"tjdevries/colorbuddy.nvim"}
    use {"~/code/colorbuddy.nvim"}

    -- Some stupid thing
    use {"ThePrimeagen/vim-be-good"}

    -- ES Linting
    -- Plug 'dense-analysis/ale'

    use {"andrejlevkovitch/vim-lua-format"}

    use {"nvim-lua/popup.nvim"}
    use {"nvim-lua/plenary.nvim"}

    -- Telescope fuzzy finder
    use {"nvim-lua/telescope.nvim"}

    use {"kyazdani42/nvim-web-devicons"}

    use {"~/code/boo-colorscheme-nvim", branch = "main"}

    -- Dashboard too many things I do not want right now
    -- Plug 'hardcoreplayers/dashboard-nvim'

    -- Nightfly colors
    use {"bluz71/vim-nightfly-guicolors"}

    use {"hrsh7th/vim-vsnip"}
    use {"hrsh7th/vim-vsnip-integ"}

    -- Fuzzy finder
    -- use {'junegunn/fzf', { 'do': { -> fzf#install() } }}
    -- use { 'junegunn/fzf.vim' }

    use {"justinmk/vim-dirvish"}
  end)
end

return {setup = setup}

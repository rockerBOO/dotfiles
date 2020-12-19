local mappings = {}

-- Mappings
mappings.setup = function()
  local n, i, esc = "n", "i", "<esc>"

  local maps = {
    {n, "<C-l>", "<C-w>l"},
    {n, "<C-h>", "<C-w>h"},
    {n, "<C-j>", "<C-w>j"},
    {n, "<C-k>", "<C-w>k"},

    {i, "jk", esc},
    {i, "JK", esc},
    {i, "Jk", esc},
    {i, "jK", esc},

    {i, "kj", esc},
    {i, "KJ", esc},
    {i, "Kj", esc},
    {i, "kJ", esc},

    {i, "kk", esc},
    {i, "KK", esc},

    {i, "jj", esc},
    {i, "JJ", esc},

    {i, "hj", esc},
    {i, "HJ", esc},
    {i, "Hj", esc},
    {i, "hJ", esc},

    {i, "kl", esc},
    {i, "KL", esc},
    {i, "Kl", esc},
    {i, "kL", esc},

    {i, "<Up>", "<nop>"},
    {i, "<Down>", "<nop>"},

    {n, "<Leader>w", ":w<cr>"},
    {n, "<Leader>q", ":q<cr>"},

    {i, "<C-l>", "A<cr>"},

    {i, "<expr> <Tab>", "pumvisible() ? '<C-n>' : '<Tab>'"},
    {i, "<expr> <S-Tab>", "pumvisible() ? '<C-p>' : '<S-Tab>'"},

    {n, "<Leader>gh", "<cmd>TSHighlightCapturesUnderCursor<cr>", {silent = true}},
  }

  require"rockerboo.utils".keymaps(maps)
end

return mappings

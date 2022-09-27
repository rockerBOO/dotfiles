
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = "*.html.eex",
  command = "set filetype=html_eex"
})

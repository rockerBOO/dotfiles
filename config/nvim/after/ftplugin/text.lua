local n = "n"
local v = "v"

local voices = require("rockerboo.voices")

local silent = { silent = true }

vim.keymap.set(n, "<leader>tr", voices.voices)
vim.keymap.set(n, "<leader>ss", voices.save_voice)

return function()
	require("dressing").setup({
    input = {
      enabled = false,
      border = false
    },
		select = {
			telescope = require("telescope.themes").get_cursor({  }),
		},
	})
end

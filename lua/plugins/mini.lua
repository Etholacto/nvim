return {
	{ "echasnovski/mini.comment", version = "*", event = "VeryLazy", opts = {} },
  { "echasnovski/mini.pairs", version = "*", event = "VeryLazy", opts = {} },
	{
		"echasnovski/mini.indentscope",
		version = "*",
		event = "VeryLazy",
		opts = {
			symbol = "╎",
			options = {
        try_as_border = true,
      },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"help",
					"alpha",
					"dashboard",
					"Trouble",
					"trouble",
					"lazy",
					"mason",
					"notify",
					"toggleterm",
					"lazyterm",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},
	{ "echasnovski/mini.animate", version = "*" },
}

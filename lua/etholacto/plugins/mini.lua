return {
	{ "echasnovski/mini.pairs", version = "*", event = "VeryLazy", opts = {} },
	{
		"echasnovski/mini.surround",
		version = "*",
		opts = {
			mappings = {
				add = "gsa", -- Add surrounding in Normal and Visual modes
				delete = "gsd", -- Delete surrounding
				find = "gsf", -- Find surrounding (to the right)
				highlight = "gsh", -- Highlight surrounding
				replace = "gsr", -- Replace surrounding
			},
		},
	},
	{ "echasnovski/mini.comment", version = "*", event = "VeryLazy", opts = {} },
	{
		"echasnovski/mini.ai",
		version = "*",
		event = "VeryLazy",
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}, {}),
					f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
					c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
					t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
				},
			}
		end,
	},
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

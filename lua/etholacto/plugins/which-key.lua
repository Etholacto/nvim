return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		plugins = { spelling = true },
		defaults = {
			mode = { "n", "v" },
      ["h"] = { name = "+hop"},
			["g"] = { name = "+goto" },
			["gs"] = { name = "+surround"},
      ["u"] = { name = "undotree"},
			["]"] = { name = "+next" },
			["["] = { name = "+prev" },
			["<leader>f"] = { name = "+file/find" },
      ["<leader>c"] = { name = "+code"},
			["<leader>g"] = { name = "+git" },
      ["<leader>q"] = { name = "+sessions"},
			["<leader>s"] = { name = "+search" },
			["<leader>w"] = { name = "+windows" },
      ["<leader>x"] = { name = "+trouble"},
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.register(opts.defaults)
	end,
}

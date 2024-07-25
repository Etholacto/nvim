return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		plugins = { spelling = true },
		defaults = {
			mode = { "n", "v" },
      -- ["h"] = { name = "+hop"},
			-- ["g"] = { name = "+goto" },
			-- ["]"] = { name = "+next" },
			-- ["["] = { name = "+prev" },
      -- ["<leader>c"] = { name = "+code"},
      -- ["<leader>d"] = { name = "+debug"},
			-- ["<leader>f"] = { name = "+file/find" },
			-- ["<leader>g"] = { name = "+git" },
      -- ["<leader>q"] = { name = "+session"},
      -- ["<leader>r"] = { name = "+refactoring"},
      -- ["<leader>s"] = { name  = "+surround"},
			-- ["<leader>u"] = { name = "+undo" },
			-- ["<leader>w"] = { name = "+windows" },
      -- ["<leader>x"] = { name = "+trouble"},
      { "<leader>c", group = "code" },
      { "<leader>d", group = "debug" },
      { "<leader>f", group = "file/find" },
      { "<leader>g", group = "git" },
      { "<leader>q", group = "session" },
      { "<leader>r", group = "refactoring" },
      { "<leader>s", group = "surround" },
      { "<leader>u", group = "undo" },
      { "<leader>w", group = "windows" },
      { "<leader>x", group = "trouble" },
      { "[", group = "prev" },
      { "]", group = "next" },
      { "g", group = "goto" },
      { "h", group = "hop" },
		},
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.register(opts.defaults)
	end,
}

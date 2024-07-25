return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		plugins = { spelling = true },
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)

    wk.add({
			mode = { "n", "v" },
      { "<leader>c", group = "code" },
      { "<leader>f", group = "file/find" },
      { "<leader>g", group = "git" },
      { "<leader>q", group = "session" },
      { "<leader>w", group = "windows" },
      { "<leader>x", group = "trouble" },
    })
	end,
}

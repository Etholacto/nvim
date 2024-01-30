return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-telescope/telescope-file-browser.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")

		telescope.setup({
			defaults = {
				layout_strategy = "flex",
				layout_config = {
					vertical = {
						prompt_position = "top",
						mirror = true,
					},
					horizontal = {
						prompt_position = "top",
						mirror = false,
					},
				},
				sorting_strategy = "ascending",
				path_display = { "truncate " },
			},
			extensions = {
				file_browser = {
					hijack_netrw = true,
				},
			},
		})

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Find recent files" })
		keymap.set(
			"n",
			"<leader>fb",
			":Telescope file_browser path=%:p:h select_buffer=true<CR>",
			{ desc = "File browser in current buffer" },
			{ noremap = true }
		)
	end,
}

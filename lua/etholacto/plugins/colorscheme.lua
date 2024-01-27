return {
	"folke/tokyonight.nvim",
	priority = 1000,
	opts = {
		on_colors = function(colors)
			colors.border = colors.comment
		end,
		style = "moon",
	},
	config = function()
		--load colorscheme
		vim.cmd([[colorscheme tokyonight-night]])
	end,
}

--This file can be loaded by calling "lua require("plugins")" from your init.vim

-- Only require if you have packer configured as "opt"
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
	-- Packer can manage itself
	use "wbthomason/packer.nvim"

    --File nav tree
    use{
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    --Icons for nvim tree
    use('nvim-tree/nvim-web-devicons')

    --Tabs for multiple windows
    use{'romgrk/barbar.nvim', requires = 'nvim-web-devicons'}

	--Neovim theme
	use({ 
		"folke/tokyonight.nvim",
		config = function()
			vim.cmd[[colorscheme tokyonight-night]]
		end
	})

	--Language server protocol handler
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v1.x',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{'williamboman/mason.nvim'},           -- Optional
			{'williamboman/mason-lspconfig.nvim'}, -- Optional

			-- Autocompletion
			{'hrsh7th/nvim-cmp'},         -- Required
			{'hrsh7th/cmp-nvim-lsp'},     -- Required
			{'hrsh7th/cmp-buffer'},       -- Optional
			{'hrsh7th/cmp-path'},         -- Optional
			{'saadparwaiz1/cmp_luasnip'}, -- Optional
			{'hrsh7th/cmp-nvim-lua'},     -- Optional

			-- Snippets
			{'L3MON4D3/LuaSnip'},             -- Required
			{'rafamadriz/friendly-snippets'}, -- Optional
		}
	}
	
	--Tabline showing status + themes
	use('vim-airline/vim-airline')
	use('vim-airline/vim-airline-themes')
    --vim.cmd[[autocmd AirlineToggledOn * AirlineTheme bubblegum]]

	--Paser generator tool
	use( "nvim-treesitter/nvim-treesitter", {run = ":TSUpdate"})
	--Save 4 file locations to jump to
	use( 'theprimeagen/harpoon')
	--Undotree to track undo's
	use( 'mbbill/undotree')
	--Plugin for Git
	use( 'tpope/vim-fugitive')
	--File finder
	use{
		"nvim-telescope/telescope.nvim", tag = "0.1.0",
		--or			       , branch = "0.1.x",
	requires = { {"nvim-lua/plenary.nvim"} }
	}
	--Automatically pairs parenthesis
	use {
		"windwp/nvim-autopairs",
		config = function() require("nvim-autopairs").setup {} end
	}

    --Gives the keycombo that can be used after an operator is pressed
    use {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }

end)

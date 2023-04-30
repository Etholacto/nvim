local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()
return require("packer").startup(function(use)
    ------------------------Core-------------------------

    --Packer
    use "wbthomason/packer.nvim"

    -- Lsp
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },         -- Required
            { 'hrsh7th/cmp-nvim-lsp' },     -- Required
            { 'hrsh7th/cmp-buffer' },       -- Optional
            { 'hrsh7th/cmp-path' },         -- Optional
            { 'saadparwaiz1/cmp_luasnip' }, -- Optional
            { 'hrsh7th/cmp-nvim-lua' },     -- Optional

            -- Snippets
            { 'L3MON4D3/LuaSnip' },             -- Required
            { 'rafamadriz/friendly-snippets' }, -- Optional
        }
    }

    --Expansion for LSP for eclipse(java)
    use('mfussenegger/nvim-jdtls')

    --DAP
    use { 'mfussenegger/nvim-dap' }
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
    use { "ldelossa/nvim-dap-projects" }

    --Paser generator
    use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
    use('nvim-treesitter/playground')

    --Shows errors
    use {
        "folke/trouble.nvim",
        requires = "nvim-tree/nvim-web-devicons",
        config = function()
            require("trouble").setup {}
        end
    }

    --Highlights TODO's
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {
            }
        end
    }

    --LSP Icons
    use("onsails/lspkind.nvim")

    ------------------------Theme-------------------------

    --Neovim theme
    use { "rebelot/kanagawa.nvim" }

    --Icons
    use { "nvim-tree/nvim-web-devicons" }

    --Tabline manager (Waiting for better support)
    --use { 'nanozuki/tabby.nvim' }

    -- Buffer management
    use {
        'akinsho/bufferline.nvim',
        tag = "*",
        requires = 'nvim-tree/nvim-web-devicons',
    }

    --Tabline showing status
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "nvim-tree/nvim-web-devicons", opt = true }
    }

    use {
        'ldelossa/nvim-ide'
    }

    --Scrollbar with errors
    use("petertriho/nvim-scrollbar")

    --Scrollbar theme
    use('folke/tokyonight.nvim')

    ------------------------Tools-------------------------

    --File finder
    use {
        "nvim-telescope/telescope-file-browser.nvim",
        requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    }
    use {
        "nvim-telescope/telescope.nvim", tag = "0.1.1",
        requires = { { "nvim-lua/plenary.nvim" } }
    }
    use { 'desdic/telescope-rooter.nvim' }

    --Search and open sessions and workspaces
    --use {
    --    'jedrzejboczar/possession.nvim',
    --    requires = { 'nvim-lua/plenary.nvim' },
    --}

    --Open file at last location
    use("ethanholz/nvim-lastplace")

    --Undotree to track undo's
    use('mbbill/undotree')

    --Provide Context
    use('romgrk/nvim-treesitter-context')

    --Context tree to jump too
    use {
        "utilyre/barbecue.nvim",
        tag = "*",
        requires = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        config = function()
            require("barbecue").setup()
        end,
    }

    --Automatically pairs parenthesis
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    --Surround text with brackets, quotations, etc.
    use('tpope/vim-surround')

    --Parenthesis have more colours
    --use('HiPhish/nvim-ts-rainbow2')

    --Auto Indents
    use('lukas-reineke/indent-blankline.nvim')

    --Highlight word under cursor
    use { 'RRethy/vim-illuminate' }

    ------------------------Git-------------------------

    --Plugin for Git
    use('tpope/vim-fugitive')

    --Shows differences in Git commits
    use {
        'sindrets/diffview.nvim',
        requires = 'nvim-lua/plenary.nvim'
    }

    ------------------------Help-------------------------

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

    use { 'folke/neodev.nvim' }

    --use { 'codota/tabnine-nvim', run = "pwsh.exe -file .\\dl_binaries.ps1" }

    if packer_bootstrap then
        require('packer').sync()
    end
end)

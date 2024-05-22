return {
  {
    "j-hui/fidget.nvim",
    dependencies = { "rcarriga/nvim-notify" },
    opts = {
      window = {
        winblend = 0
      }
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local ibl = require("ibl")
      ibl.setup({
        indent = {
          char = "╎",
        }
      })
    end
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },
  { "farmergreg/vim-lastplace" },
  {
    "nvim-pack/nvim-spectre",
    event = { "BufNewFile" },
    vim.keymap.set("n", "<leader>sr", "<cmd>lua require('spectre').toggle()<CR>", { desc = "Toggle Spectre" }),
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },
  {
    "utilyre/barbecue.nvim",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      theme = "tokyonight",
    },
  },
  { 'mbbill/undotree',
    vim.keymap.set('n', '<leader>su', vim.cmd.UndotreeToggle, { desc = "Toggle Undotree" }),
  },
  { "voldikss/vim-floaterm" },
  { "christoomey/vim-tmux-navigator" },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = vim.opt.sessionoptions:get() },
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end,                desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end,                desc = "Don't Save Current Session" },
    },
  },
  { "tpope/vim-surround" },
  {
    "zbirenbaum/neodim",
    event = "LspAttach",
    config = function()
      require("neodim").setup({
        refresh_delay = 75,
        alpha = 0.75,
        blend_color = "#10171F",
        hide = {
          underline = true,
          virtual_text = true,
          signs = true,
        },
        regex = {
          "[uU]nused",
          "[nN]ever [rR]ead",
          "[nN]ot [rR]ead",
        },
        priority = 128,
        disable = {},
      })
    end
  },
  {
    "karb94/neoscroll.nvim",
    config = function()
      require('neoscroll').setup { mappings = {}
      }
      local t = {}
      -- Syntax: t[keys] = {function, {function arguments}}
      t['<C-k>'] = { 'scroll', { '-vim.api.nvim_win_get_height(0)', 'true', '350', [['sine']] } }
      t['<C-j>'] = { 'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '350', [['sine']] } }
      require('neoscroll.config').set_mappings(t)
    end
  },
}

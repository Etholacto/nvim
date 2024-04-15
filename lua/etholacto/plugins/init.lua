return {
  {
    "j-hui/fidget.nvim",
    dependencies = { "rcarriga/nvim-notify" },
    opts = {},
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
      theme = "catppuccin",
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
  {"eandrju/cellular-automaton.nvim"},
}

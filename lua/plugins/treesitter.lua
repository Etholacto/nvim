return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "windwp/nvim-ts-autotag",   -- Automatically add closing tags for HTML and JSX
  },
  build = ':TSUpdate',
  opts = {
    highlight = {
      enable = true,
    },
    indent = { enable = true },
    auto_install = true, -- automatically install syntax support when entering new file type buffer
    ensure_installed = {
      'c',
      'c_sharp',
      'cpp',
      'java',
      'python',
      'lua',
      'comment',
      'vim',
      'vimdoc',
    },
  },
  config = function(_, opts)
    local configs = require("nvim-treesitter.configs")
    configs.setup(opts)
    require 'nvim-treesitter.install'.compilers = { "clang" }
  end
}

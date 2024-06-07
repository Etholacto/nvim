return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag", -- Automatically add closing tags for HTML and JSX
    },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "c",
          "c_sharp",
          "cpp",
          "css",
          "diff",
          "html",
          "javascript",
          "java",
          "json",
          "lua",
          "python",
          "sql",
          "vim",
          "vimdoc",
        },
        sync_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        smart_rename = { enable = true },
        autotag = { enable = true },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["ak"] = { query = "@block.outer", desc = "around block" },
              ["ik"] = { query = "@block.inner", desc = "inside block" },
              ["ac"] = { query = "@class.outer", desc = "around class" },
              ["ic"] = { query = "@class.inner", desc = "inside class" },
              ["a?"] = { query = "@conditional.outer", desc = "around conditional" },
              ["i?"] = { query = "@conditional.inner", desc = "inside conditional" },
              ["af"] = { query = "@function.outer", desc = "around function " },
              ["if"] = { query = "@function.inner", desc = "inside function " },
              ["al"] = { query = "@loop.outer", desc = "around loop" },
              ["il"] = { query = "@loop.inner", desc = "inside loop" },
              ["aa"] = { query = "@parameter.outer", desc = "around argument" },
              ["ia"] = { query = "@parameter.inner", desc = "inside argument" },
            },
            selection_modes = {
              ["@parameter.outer"] = "v", -- charwise
              ["@function.outer"] = "V", -- linewise
              ["@class.outer"] = "<c-v>", -- blockwise
            },
            include_surrounding_whitespace = true,
          },
          move = {
            enable = true,
            goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
            goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
            goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
            goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
          },
        },
      })

      local install = require('nvim-treesitter.install')
      install.prefer_git = false
      install.compilers = { "clang" }
    end
  },
}

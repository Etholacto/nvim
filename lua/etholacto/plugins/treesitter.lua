return {
  "nvim-treesitter/nvim-treesitter",
  version = false, -- last release is way too old and doesn't work on Windows
  build = ":TSUpdate",
  event = { "VeryLazy" },
  cmd = "TSUpdate",
  "TSInstall",
  opts = {
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    ensure_installed = {
      "c",
      "cpp",
      "c_sharp",
      "diff",
      "gdscript",
      "java",
      "latex",
      "lua",
      "python",
      "sql",
      "css",
      "html"
    },
    sync_install = true,
    smart_rename = { enable = true },
    autotag = {
      enable = true,
      enable_rename = true,
      enable_close = true,
      enable_close_on_slash = true,

    },
  },
}

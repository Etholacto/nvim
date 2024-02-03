return {
  "nvim-treesitter/nvim-treesitter",
  version = false, -- last release is way too old and doesn't work on Windows
  build = ":TSUpdate",
  event = { "VeryLazy" },
  cmd = "TSUpdate", "TSInstall",
  opts = {
    highlight = {
      enable = true,
      additional_vim_regex_highlighting= true,
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
    },
    sync_install = false,
  },
  config = function ()
    local tsInstall = require("nvim-treesitter.install")
    tsInstall.prefer_git = false
    tsInstall.compilers = {"clang", "gcc"}
  end
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    config = function(_, opts)
      require("nvim-treesitter.configs").setup({
            ensure_installed = {
        "vim",
        "lua",
        "c",
        "cpp",
        "c_sharp",
        "diff",
        "gdscript",
        "java",
        "python",
        "sql",
        "css",
        "html"
      },
 sync_install = true,
            highlight = { enable = true },
            indent = { enable = true },
            smart_rename = { enable = true },
            autotag = {
                enable = true,
                enable_rename = true,
                enable_close = true,
                enable_close_on_slash = true,
                
            },
      })
    end
  },
}

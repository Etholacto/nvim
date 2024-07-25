return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()

      local keymap = vim.keymap -- for conciseness
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
          keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
          keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
          keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
          keymap.set("n", "H", function() vim.diagnostic.open_float() end, opts)
          keymap.set("n", "[d", function() vim.diagnostic.jump({count=1, float=true}) end, opts)
          keymap.set("n", "]d", function() vim.diagnostic.jump({count=-1, float=true}) end, opts)
          keymap.set("n", "<leader>k", function() vim.lsp.buf.code_action() end, opts)
          keymap.set("n", "Q", function() vim.lsp.buf.code_action({ only = { "quickfix" }, }) end, opts)
          keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
          keymap.set("n", "rn", function() vim.lsp.buf.rename() end, opts)
          keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
        end,
      })

      -- Change the Diagnostic symbols in the sign columns
      local x = vim.diagnostic.severity
      vim.diagnostic.config {
        signs = { text = {[x.ERROR] = "", [x.WARN] = "", [x.INFO] = "", [x.HINT] = ""}}
      }
    end,
  },
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim"
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")

      -- enable mason and configure icons
      mason.setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
      
      local handlers = {
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {}
        end,

        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup {
            settings = {
              Lua = {
                diagnostics = {
                  -- Get the language server to recognize the `vim` global
                  globals = { 'vim' },
                },
                workspace = {
                  -- make language server aware of runtime files
                  library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                  },
                },
              },
            },
          }
        end
      }

      mason_lspconfig.setup({
        -- list of servers for mason to install
        ensure_installed = {
          'bashls',
          'clangd',
          'cssls',
          'html',
          'jdtls',
          'jsonls',
          'lua_ls',
          'omnisharp',
          'pylsp',
          'tsserver',
        },
        -- auto-install configured servers (with lspconfig)
        automatic_installation = true, -- not the same as ensure_installed
        -- lsp setup
        handlers = handlers,
      })
    end
  }
}

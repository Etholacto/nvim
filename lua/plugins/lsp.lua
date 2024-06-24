return {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      -- LSP Management
      -- https://github.com/williamboman/mason.nvim
      { 'williamboman/mason.nvim' },
      -- https://github.com/williamboman/mason-lspconfig.nvim
      { 'williamboman/mason-lspconfig.nvim' },
      -- Useful status updates for LSP
      -- https://github.com/j-hui/fidget.nvim
      { 'j-hui/fidget.nvim',                opts = {} },
      -- Additional lua configuration, makes nvim stuff amazing!
      -- https://github.com/folke/neodev.nvim
      { 'folke/neodev.nvim' },
    },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup({
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
        automatic_installation = true
      })

      local lspconfig = require('lspconfig')
      local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lsp_attach = function(client, bufnr)
        -- Create your keybindings here...
      end

      -- Call setup on each LSP server
      require('mason-lspconfig').setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            on_attach = lsp_attach,
            capabilities = lsp_capabilities,
          })
        end
      })

      -- Lua LSP settings
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

      -- Change the Diagnostic symbols in the sign column (gutter)
      local signs = { Error = "", Warn = "", Hint = "", Info = "" }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      -- -- Globally configure all LSP floating preview popups (like hover, signature help, etc)
      -- local open_floating_preview = vim.lsp.util.open_floating_preview
      -- function open_floating_preview(contents, syntax, opts, ...)
      --   opts = opts or {}
      --   opts.border = opts.border or "rounded" -- Set border to rounded
      --   return open_floating_preview(contents, syntax, opts, ...)
      -- end
    end,
  },
}

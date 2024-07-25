return {
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'folke/neodev.nvim',                opts = {} },
    },
    config = function()
      require('mason').setup()
      local mason_lspconfig = require('mason-lspconfig')

      mason_lspconfig.setup({
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

      local opts = { noremap = true, silent = true, auto = true }
      local on_attach = function(_, bufnr)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          opts = {buffer = bufnr}
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
      end

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
      -- local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Call setup on each LSP server
      mason_lspconfig.setup_handlers({
        function(server_name)
          lspconfig[server_name].setup({
            on_attach = on_attach,
            capabilities = capabilities,
          })
        end
      })

      -- Lua LSP settings
      -- lspconfig.lua_ls.setup {
      --   settings = {
      --     Lua = {
      --       diagnostics = {
      --         -- Get the language server to recognize the `vim` global
      --         globals = { 'vim' },
      --       },
      --       workspace = {
      --         -- make language server aware of runtime files
      --         library = {
      --           [vim.fn.expand("$VIMRUNTIME/lua")] = true,
      --           [vim.fn.stdpath("config") .. "/lua"] = true,
      --         },
      --       },
      --     },
      --   },
      -- }

      -- -- Change the Diagnostic symbols in the sign column (gutter)
      -- local signs = { Error = "", Warn = "", Hint = "", Info = "" }
      -- for type, icon in pairs(signs) do
      --   local hl = "DiagnosticSign" .. type
      --   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      -- end
    end,
  },
}

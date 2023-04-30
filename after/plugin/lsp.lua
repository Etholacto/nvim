local lsp = require("lsp-zero").preset({})

lsp.ensure_installed({
    "lua_ls",
    "clangd",
    "omnisharp",
    "jdtls",
})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
    lsp.buffer_autoformat()
    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', { buffer = true })
end)

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = "",
        warn = "",
        info = "",
        hint = "",
    }
})

local lspconfig = require('lspconfig')

lspconfig.clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

lspconfig.omnisharp.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    root_dir = lspconfig.util.root_pattern(".sln", ".csproj", ".uproject", ".git", ".vs"),
}

lspconfig.lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            completion = {
                callSnippet = "Replace"
            },
            diagnostics = {
                globals = { 'vim', 'use', 'on_attach' }
            }
        }
    },
    root_dir = lspconfig.util.root_pattern("init.lua", ".luarc.json", ".luarc.jsonc", ".luacheckrc", ".stylua.toml",
        "stylua.toml", "selene.toml", "selene.yml", ".git"),
}

lsp.setup()

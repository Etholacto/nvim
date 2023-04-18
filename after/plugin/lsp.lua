local lsp = require('lsp-zero')

lsp.preset("recommended",
{
    name = 'recommended',
    set_lsp_keymaps = true,
    manage_nvim_cmp = true,
    suggest_lsp_servers = true,
}
)

lsp.ensure_installed({
    "omnisharp",
    "jdtls",
    "ltex",
    "lua_ls",
    "jedi_language_server",
    "sqlls",
    "cssls",
    "html",
    "tsserver"
})

local cmp = require('cmp')
local cmp_select = {behaviour = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-space>'] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

local lspconfig = require('lspconfig')

lspconfig.jdtls.setup{
    cmd = {'jdtls'},   
    filetypes = {'java'},
    on_attach = lsp.common_on_attach,
    root_dir = function(fname)
        return lspconfig.util.find_git_ancestor(fname) or lspconfig.util.path.dirname(fname)
    end,
    --root_dir = lspconfig.util.root_pattern('.git', '.iml', '.idea')
}

lspconfig.omnisharp.setup{
    cmd = {'omnisharp', '--languageserver', '--hostPID', tostring(vim.fn.getpid())},
    filetypes = {'cs'},
    on_attach = function(client, bufnr)
        -- Add formatting capabilities
        client.resolved_capabilities.document_formatting = true
        client.resolved_capabilities.document_range_formatting = true

        -- Add highlight for references
        protocol.DocumentHighlightKind = {
            "Text", "Read", "Write"
        }
    end
    --root_dir = lspconfig.util.root_pattern('*.sln', '*.csproj', 'project.json', 'gloabl.json', '.git')
}

lspconfig.clangd.setup{
    cmd = {'clangd', '--background-index', '--clang-tidy'},
    on_attach = function(client, bufnr)
        -- Add formatting capabilities
        client.resolved_capabilities.document_formatting = true
        client.resolved_capabilities.document_range_formatting = true
    end
}

lsp.setup()


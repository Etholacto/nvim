local cmp = require 'cmp'
local luasnip = require('luasnip')
local lspkind = require('lspkind')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("luasnip.loaders.from_vscode").lazy_load()

local icons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "ﰠ",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "פּ",
    Event = "",
    Operator = "",
    TypeParameter = "",
    luasnip = "",
    buffer = "﬘",
    nvim_lsp = "",
}

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered({
            border = "double", -- { "⁜", "—", "⁜", "|", "⁜", "—", "⁜", "|" },
            winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:CursorLine,Search:None",
            col_offset = -1,
        }),
        documentation = cmp.config.window.bordered()
    },
    formatting = {
        fields = { "abbr", "kind", "menu" },
        format = lspkind.cmp_format({
            maxwidth = 50,
            ellipsis_char = '...',
            before = function(entry, vim_item)
                vim_item.kind = (icons[vim_item.kind] or "") .. " " .. vim_item.kind
                vim_item.menu = "[" .. icons[entry.source.name] .. " ]"

                vim_item.abbr = vim_item.abbr:match("[^(]+")

                local source = entry.source.name
                if source == "luasnip" or source == "nvim_lsp" then
                    vim_item.dup = 0
                end
                return vim_item
            end
        })
    },
    sources = cmp.config.sources({
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        entry_filter = function(entry, ctx)
            if entry:get_kind() == 14 then
                return false
            end
        end
    }, {
        { name = "buffer" },
    }),
    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.close(),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
                --else
                --    local copilot_keys = vim.fn["copilot#Accept"]()
                --    if copilot_keys ~= "" then
                --        vim.api.nvim_feedkeys(copilot_keys, "i", true)
            else
                fallback()
                --    end
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
}

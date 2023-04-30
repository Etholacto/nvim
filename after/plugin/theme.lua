-- Default options:
require('kanagawa').setup({
    compile = false,  -- enable compiling the colorscheme
    undercurl = true, -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = false,   -- do not set background color
    dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
    terminalColors = true, -- define vim.g.terminal_color_{0,17}
    colors = {
        -- add/modify theme and palette colors
        palette = {},
        theme = {
            wave = {},
            lotus = {},
            dragon = {},
            all = {
                ui = {
                    bg_gutter = "none",
                }
            }
        },
    },
    overrides = function(colors) -- add/modify highlights
        local theme = colors.theme
        return {
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            BufferLineFill = { bg = theme.ui.bg, fg = theme.ui.fg_dim },
        }
    end,
    theme = "wave", -- Load "wave" theme when 'background' option is not set
})

-- setup must be called before loading
vim.cmd("colorscheme kanagawa-wave")

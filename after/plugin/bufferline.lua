local bufferline = require('bufferline')
vim.opt.termguicolors = true
require("bufferline").setup {
    options = {
        mode = "buffer",
        separator_style = "padded_slant",
        buffer_close_icon = '',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        show_tab_indicators = true,
        indicator = {
            icon = '▎',
            style = 'icon',
        },
        color_icons = true,
        get_element_icon = function(element)
            local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
            return icon, hl
        end,
        hover = {
            enabled = true,
            delay = 200,
            reveal = { 'close' }
        },
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "left",
                separator = true,
            }
        },
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
            local icon = level:match("error") and "" or ""
            return "" .. count .. "" .. icon .. ""
        end,
    }
}


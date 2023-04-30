local bufferline = require('bufferline')
vim.opt.termguicolors = true
bufferline.setup {
    options = {
        mode = "buffers",
        always_show_bufferline = true,
        separator_style = "padded_slant",
        buffer_close_icon = '',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 15,
        truncate_names = true,
        tab_size = 18,
        show_buffer_icons = true,
        show_buffer_close_icons = false,
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
                filetype = "filetree",
                text = "File Explorer",
                text_align = "left",
                padding = 1,
                highlight = "Explorer",
            }
        },
        highlights = {
            fill = {
                bg = {
                    attribute = "fg",
                    highlight = "Pmenu"
                },
            },
        },
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level)
            local icon = level:match("error") and "" or ""
            return "" .. count .. "" .. icon .. ""
        end,
    }
}

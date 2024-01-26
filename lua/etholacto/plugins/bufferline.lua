return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
        separator_style = "slant",
        diagnostics = "nvim_lsp",
        buffer_close_icon = '',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        show_tab_indicators = true,
        color_icons = true,
        max_name_length = 48,
        max_prefix_length = 25,
        get_element_icon = function(element)
            local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
            return icon
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
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and "" or ""
            return "" .. icon .." " .. count .. ""
        end,
    },
  },
}

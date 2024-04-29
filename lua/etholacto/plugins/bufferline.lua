return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  version = "*",
  opts = {
    options = {
      mode = "buffer",
      themable = true,
      diagnostics = "nvim_lsp",
      buffer_close_icon = '',
      modified_icon = '●',
      close_icon = '',
      left_trunc_marker = '',
      right_trunc_marker = '',
      indicator = {
        style = "underline",
      },
      show_tab_indicators = true,
      color_icons = true,
      max_name_length = 18,
      max_prefix_length = 15,
      tab_size = 18,
      get_element_icon = function(element)
        local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, { default = false })
        return icon
      end,
      hover = {
        enabled = true,
        delay = 200,
        reveal = { 'close' }
      },
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local icon = level:match("error") and "" or ""
        return "" .. icon .. " " .. count .. ""
      end,
    },
  },
  config = function()
    local bufferline = require('bufferline')
    local colors = require("tokyonight.colors").setup()
    bufferline.setup({
      options = {
        style_preset = bufferline.style_preset.default,
      },
      highlights = {
        fill = {
          bg = "#222436"
        },
        buffer_selected = {
          bg = "#2f334d"
        },
        close_button_selected = {
          bg = '#2f334d'
        },
        diagnostic_selected = {
          bg = "#2f334d"
        },
        modified_selected = {
          bg = "#2f334d"
        },
        separator_selected = {
          bg = "#2f334d"
        },
        indicator_selected = {
          bg = "#2f334d"
        }
      }
    })
  end
}

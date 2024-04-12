return {
  "petertriho/nvim-scrollbar",
  event = "BufReadPost",
  config = function()
    local scrollbar = require("scrollbar")
    local colors = require("catppuccin.palettes").get_palette "mocha"
    scrollbar.setup({
      handle = {
        ext = " ",
        blend = 30,                 -- Integer between 0 and 100. 0 for fully opaque and 100 to full transparent. Defaults to 30.
        color = colors.bg_highlight,
        color_nr = nil,             -- cterm
        highlight = "CursorColumn",
        hide_if_all_visible = false, -- Hides handle if all lines are visible
      },
      marks = {
        Search = { color = colors.orange },
        Error = { color = colors.error },
        Warn = { color = colors.warning },
        Info = { color = colors.info },
        Hint = { color = colors.hint },
        Misc = { color = colors.purple },
      },
      handlers = {
        cursor = true,
        diagnostic = true,
        gitsigns = true, -- Requires gitsigns
        handle = true,
        search = false,  -- Requires hlslens
        ale = false,     -- Requires ALE
      },
    })
  end,
}

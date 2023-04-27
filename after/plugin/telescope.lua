local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<C-f>', '<Cmd>Telescope current_buffer_fuzzy_find<CR>')
vim.keymap.set("i", "<C-e>", "<Esc>")
vim.keymap.set("n", "<leader>of", "<Cmd>Telescope oldfiles<CR>")
vim.api.nvim_set_keymap(
    "n",
    "<leader>fb",
    ":Telescope file_browser",
    { noremap = true }
)

-- open file_browser with the path of the current buffer
vim.api.nvim_set_keymap(
    "n",
    "<leader>fb",
    ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
    { noremap = true }
)

vim.api.nvim_set_keymap(
    "n",
    "<leader>fp",
    ":Telescope possession list<CR>",
    { noremap = true }
)

require("telescope").setup {
    defaults = {
        layout_strategy = "flex",
        layout_config = {
            vertical = {
                prompt_position = 'top',
                mirror = true,
            },
            horizontal = {
                prompt_position = 'top',
                mirror = false,
            }
        },
        sorting_strategy = 'ascending',
    },
    extensions = {
        file_browser = {},
        rooter = {
            enable = true,
            patterns = { '.git' },
            debug = false,
        }
    }
}

--Telescope - file_browser integration
require("telescope").load_extension("file_browser")
--Telescope - Possession integration
require('telescope').load_extension('possession')
--Telescope - Rooter integration
require("telescope").load_extension('rooter')

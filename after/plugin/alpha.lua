require('alpha').setup(require('alpha.themes.dashboard').opts)

-- Set a keybinding to open the dashboard
vim.api.nvim_set_keymap('n', '<Leader>ss', ':Alpha<CR>', { noremap = true, silent = true })

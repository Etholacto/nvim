local P = {}
keymaps = P

--Assigns leader to spacebar
vim.g.mapleader = " "

--key_mapping--
local key_map = function(mode, key, result)
    vim.keymap.set(
        mode,
        key,
        result,
        { noremap = true, silent = true }
    )
end

--LPS
function map_lsp_keys()
    key_map('n', 'gD', vim.lsp.buf.declaration)
    key_map('n', 'gd', vim.lsp.buf.definition)
    key_map('n', 'K', vim.lsp.buf.hover)
    key_map('n', 'gi', vim.lsp.buf.implementation)
    key_map('n', '<C-k>', vim.lsp.buf.signature_help)
    key_map('n', '<leader>ca', vim.lsp.buf.code_action)
    key_map('n', '<leader>nc', vim.lsp.buf.rename)
end

--DAP
vim.keymap.set('n', '<F4>',
"<Cmd>lua require('jdtls.dap').setup_dap_main_class_configs()<CR> <Cmd>lua require('jdtls').setup_dap()<CR>")
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<A-b>', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp',
function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
    require('dap.ui.widgets').hover()
end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
    require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
end)


--Code_Runner
vim.keymap.set('n', '<leader>r', ':RunCode<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>rf', ':RunFile<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>rft', ':RunFile tab<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>rp', ':RunProject<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>rc', ':RunClose<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>crf', ':CRFiletype<CR>', { noremap = true, silent = false })
vim.keymap.set('n', '<leader>crp', ':CRProjects<CR>', { noremap = true, silent = false })

--Exit the current file
key_map("n", "<leader>pv", vim.cmd.Ex)

--move highlighted text up and down
key_map("v", "J", ":m '>+1<CR>gv=gv")
key_map("v", "K", ":m '<-2<CR>gv=gv")

--Append the next line to current line
key_map("n", "J", "mzJ`z")

--Half page jump with cursor in the middle
key_map("n", "<C-d>", "<C-d>zz")
key_map("n", "<C-u>", "<C-u>zz")

--Search for word with cursor in the middle
key_map("n", "n", "nzzzv")
key_map("n", "N", "Nzzzv")

--jump up and down
key_map("n", "<C-j>", "<C-j>zz")
key_map("n", "<C-k>", "<C-k>zz")
key_map("x", "<leader>p", [["_dP]])

--Jump to begging and end of line
key_map("n", "<C-l>", "$")
key_map("n", "<C-d>", '<Cmd>t.<CR>')

--Yank and Paste to clipboard
key_map({ "n", "v" }, "<leader>y", [["+y]])
key_map("n", "<leader>Y", [["+Y]])

--Duplicate line on next line
key_map("n", "C-d", [[:t.]])

--Vertical edit mode save and exit
key_map("i", "<C-c>", "<Esc>")

--Search and Replace
key_map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

--Easy Shoutout and Save
key_map("n", "<leader><leader>", function()
    vim.cmd("so")
end)
key_map("n", "<C-s>", vim.cmd.w)

--Nvim-Tree toggle
key_map("n", "<leader>b", vim.cmd.NvimTreeToggle)

--Window Managing
key_map('n', '<A-1>', '<Cmd>lua require("bufferline").go_to(1, true)<CR>')
key_map('n', '<A-2>', '<Cmd>lua require("bufferline").go_to(2, true)<CR>')
key_map('n', '<A-3>', '<Cmd>lua require("bufferline").go_to(3, true)<CR>')
key_map('n', '<A-4>', '<Cmd>lua require("bufferline").go_to(4, true)<CR>')
key_map('n', '<A-5>', '<Cmd>lua require("bufferline").go_to(5, true)<CR>')
key_map('n', '<A-6>', '<Cmd>lua require("bufferline").go_to(6, true)<CR>')
key_map('n', '<A-7>', '<Cmd>lua require("bufferline").go_to(7, true)<CR>')
key_map('n', '<A-8>', '<Cmd>lua require("bufferline").go_to(8, true)<CR>')
key_map('n', '<A-9>', '<Cmd>lua require("bufferline").go_to(9, true)<CR>')
key_map('n', '<A-w>', '<Cmd>bdelete<CR>')

--Tabby management (Waiting for better support)
--key_map("n", "<A-1>", "1gt")
--key_map("n", "<A-2>", "2gt")
--key_map("n", "<A-3>", "3gt")
--key_map("n", "<A-4>", "4gt")
--key_map("n", "<A-5>", "5gt")
--key_map("n", "<A-6>", "6gt")
--key_map("n", "<A-7>", "7gt")
--key_map("n", "<A-8>", "8gt")
--key_map("n", "<A-9>", "9gt")
--key_map("n", "<leader>ta", ":$tabnew<CR>")
--key_map("n", "<A-w>", ":tabclose<CR>")
--key_map("n", "<A-n>", ":tabn<CR>")
--key_map("n", "<A-p>", ":tabp<CR>")
---- move current tab to previous position
--key_map("n", "<leader>tmp", ":-tabmove<CR>")
---- move current tab to next position
--key_map("n", "<leader>tmn", ":+tabmove<CR>")

--Java LSP keybinds
function P.map_java_keys(bufnr)
    map_lsp_keys()

    key_map('n', '<leader>sr', ':lua require("jdtls).organize_imports()<CR>')
    key_map('n', '<leader>sr', ':lua require("jdtls).compile("incremental")<CR>')
end

return P

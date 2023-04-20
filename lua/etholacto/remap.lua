local P = {}
keymaps = P

--Assigns leader to spacebar
vim.g.mapleader = " "

--key_mapping--
local key_map = function (mode, key, result)
    vim.keymap.set(
    mode,
    key,
    result,
    {noremap = true, silent = true}
    )
end

--LSP
function map_lsp_keys()
    key_map('n', '<C-p>', ':lua vim.lsp.buf.definition()<CR>')
    key_map('n', '<C-k>', 'lua vim.lsp.buf.signature_help()<CR>')
    key_map('n', '<S-R>', ':lua vim.lsp.buf.references()<CR>')
    key_map('n', '<S-H>', ':lua vim.lsp.buf.hover()<CR>')
    key_map('n', '<leader>ca', ':lua vim.lsp.code_action()<CR>')
    key_map('n', '<leader>nc', ':lua vim.lsp.buf.rename()<CR>')
end

--Exit the current file
key_map("n", "<leader>pv", vim.cmd.Ex)

--move highlighted stuff up and down
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
key_map({"n", "v"}, "<leader>y", [["+y]])
key_map("n", "<leader>Y", [["+Y]])

--Duplicate line on next line
key_map("n", "C-d", [[:t.]])

--Vertical edit mode save and exit
key_map("i", "<C-c>", "<Esc>")

--Search and Replace
key_map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
key_map("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

--Easy Shoutout and Save
key_map("n", "<leader><leader>", function()
    vim.cmd("so")
end)
key_map("n", "<C-s>", vim.cmd.w)

--Nvim_tree 
key_map("n","<leader>b", vim.cmd.NvimTreeToggle)


--Toggle treesitter Context
vim.keymap.set('n', '<leader>c', '<cmd>TreesitterContextToggle<CR>', {silent = true, noremap = true})

--Window Managing
key_map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>')
key_map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>')
key_map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>')
key_map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>')
key_map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>')
key_map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>')
key_map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>')
key_map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>')
key_map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>')
key_map('n', '<A-w>', '<Cmd>BufferClose<CR>')

--Java
function P.map_java_keys(bufnr)
    map_lsp_keys()

    local spring_boot_run = 'mvn spring-boot:run -Dspring-boot.run.profiles=local'
    local command = ':lua require("toggelterm").exec("' .. spring_boot_run .. '")<CR>'
    key_map('n', '<leader>sr', command)
    key_map('n', '<leader>oi', ':lua require("jdtls").organize_imports()<CR>')
    key_map('n', '<leader>jc', ':lua require("jdtls").compile()<CR>')
end

return P

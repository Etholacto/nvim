--Assigns leader to spacebar
vim.g.mapleader = " "

--Exit the current file
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

--move highlighted stuff up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

--Append the next line to current line
vim.keymap.set("n", "J", "mzJ`z")

--Half page jump with cursor in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
--Search for word with cursor in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

--jump up and down
vim.keymap.set("n", "<C-j>", "<C-j>zz")
vim.keymap.set("n", "<C-k>", "<C-k>zz")
vim.keymap.set("x", "<leader>p", [["_dP]])

--Yank and Paste to clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

--Vertical edit mode save and exit
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

--Easy Shoutout and Save
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)
vim.keymap.set("n", "<C-s>", vim.cmd.w)

--Toggle the file tree
vim.keymap.set("n","<leader>b", vim.cmd.NvimTreeToggle)

--window managing
vim.keymap.set('n', '<A-1>', '<Cmd>BufferGoto 1<CR>')
vim.keymap.set('n', '<A-2>', '<Cmd>BufferGoto 2<CR>')
vim.keymap.set('n', '<A-3>', '<Cmd>BufferGoto 3<CR>') 
vim.keymap.set('n', '<A-4>', '<Cmd>BufferGoto 4<CR>')
vim.keymap.set('n', '<A-5>', '<Cmd>BufferGoto 5<CR>')
vim.keymap.set('n', '<A-6>', '<Cmd>BufferGoto 6<CR>')
vim.keymap.set('n', '<A-7>', '<Cmd>BufferGoto 7<CR>')
vim.keymap.set('n', '<A-8>', '<Cmd>BufferGoto 8<CR>')
vim.keymap.set('n', '<A-9>', '<Cmd>BufferGoto 9<CR>')
vim.keymap.set('n', '<A-w>', '<Cmd>BufferClose<CR>')

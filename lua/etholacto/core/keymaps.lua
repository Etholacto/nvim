-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps -------------------

-- lazy
keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- save file
keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>")
keymap.set({"i", "x", "n", "s"}, "A-f", "<cmd>lua vim.lsp.buf.format()<CR>")

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

--move highlighted stuff up and down
keymap.set("v", "<C-J>", ":m '>+1<CR>gv=gv")
keymap.set("v", "<C-K>", ":m '<-2<CR>gv=gv")
keymap.set("v", "<C-K>", ":m '<-2<CR>gv=gv")
keymap.set("n", "J", "mzJ`z")

--replace current word
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {desc = "Replace word under Cursor"})

-- window management
keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split window vertically" })     -- split window vertically
keymap.set("n", "<leader>wh", "<C-w>s", { desc = "Split window horizontally" })   -- split window horizontally
keymap.set("n", "<leader>we", "<C-w>=", { desc = "Make splits equal size" })      -- make split windows equal width & height
keymap.set("n", "<leader>wx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- Move to window using the <ctrl> hjkl keys
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- buffers
keymap.set("n", "<A-1>", "<Cmd>BufferLineGoToBuffer 1<CR>")
keymap.set("n", "<A-2>", "<Cmd>BufferLineGoToBuffer 2<CR>")
keymap.set("n", "<A-3>", "<Cmd>BufferLineGoToBuffer 3<CR>")
keymap.set("n", "<A-4>", "<Cmd>BufferLineGoToBuffer 4<CR>")
keymap.set("n", "<A-5>", "<Cmd>BufferLineGoToBuffer 5<CR>")
keymap.set("n", "<A-6>", "<Cmd>BufferLineGoToBuffer 6<CR>")
keymap.set("n", "<A-7>", "<Cmd>BufferLineGoToBuffer 7<CR>")
keymap.set("n", "<A-8>", "<Cmd>BufferLineGoToBuffer 8<CR>")
keymap.set("n", "<A-9>", "<Cmd>BufferLineGoToBuffer 9<CR>")
keymap.set("n", "<A-w>", "<Cmd>bdelete<CR>")
keymap.set("n", "<A-q>", "<Cmd>q<CR>")

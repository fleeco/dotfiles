-- Set space as leader key
vim.g.mapleader = " "

-- Open file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move selected lines down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- Move selected lines up
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Run plenary test file
vim.keymap.set("n", "<leader>tf", "<Plug>PlenaryTestFile", { noremap = false, silent = false })

-- Join lines, keep cursor position
vim.keymap.set("n", "J", "mzJ`z")

-- Half page down, center cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- Half page up, center cursor
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Next search, center & open folds
vim.keymap.set("n", "n", "nzzzv")

-- Prev search, center & open folds
vim.keymap.set("n", "N", "Nzzzv")

-- Paste without yanking deleted text
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

-- Yank line to system clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Ctrl-C acts like Escape in insert
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Disable Ex mode
vim.keymap.set("n", "Q", "<nop>")

-- Next quickfix item, center
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")

-- Prev quickfix item, center
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

-- Next location list item, center
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")

-- Prev location list item, center
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Search & replace word under cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set('n', '<C-Left>', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<C-Right>', '<C-w>l', { desc = 'Move to right window' })
vim.keymap.set('n', '<C-Up>', '<C-w>k', { desc = 'Move to window above' })
vim.keymap.set('n', '<C-Down>', '<C-w>j', { desc = 'Move to window below' })

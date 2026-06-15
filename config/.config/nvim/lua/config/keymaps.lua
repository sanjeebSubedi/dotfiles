local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

-- Standard operations
map("n", "<leader>w", "<cmd>w<CR>", "Write file")
map("n", "<leader>q", "<cmd>q<CR>", "Quit window")
map("n", "<Esc>", "<cmd>nohlsearch<CR>", "Clear search highlight")

-- Window navigation
map("n", "<C-h>", "<C-w>h", "Window left")
map("n", "<C-j>", "<C-w>j", "Window down")
map("n", "<C-k>", "<C-w>k", "Window up")
map("n", "<C-l>", "<C-w>l", "Window right")

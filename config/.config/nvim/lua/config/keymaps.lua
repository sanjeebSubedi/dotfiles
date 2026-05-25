local map = function(mode, lhs, rhs, desc)
	vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

-- Standard operations
map("n", "<leader>w", "<cmd>w<CR>", "Write file")
map("n", "<leader>q", "<cmd>q<CR>", "Quit window")
map("n", "<Esc>", "<cmd>nohlsearch<CR>", "Clear search highlight")

-- Window Navigation (Ctrl+h/j/k/l)
map("n", "<C-h>", "<C-w>h", "Window left")
map("n", "<C-j>", "<C-w>j", "Window down")
map("n", "<C-k>", "<C-w>k", "Window up")
map("n", "<C-l>", "<C-w>l", "Window right")

map("n", "<leader>td", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, "Toggle Diagnostics")
map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
map("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
map("n", "gl", vim.diagnostic.open_float, "Show Diagnostic Line")



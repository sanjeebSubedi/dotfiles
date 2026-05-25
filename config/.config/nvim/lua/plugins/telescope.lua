return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find Text" },
	},
	config = function()
		require("telescope").load_extension("fzf")
	end,
}

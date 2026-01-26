return {
    -- Neo-tree (File Explorer)
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        keys = {
            { "<leader>e", ":Neotree toggle<CR>", desc = "Toggle Explorer" },
        },
    },

    -- Telescope (Fuzzy Finder)
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find Text" },
        },
    },
    
    -- Autopairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true
    },
}

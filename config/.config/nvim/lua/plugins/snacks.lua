return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },

    init = function()
        vim.g.snacks_animate = false
    end,

    opts = {
        dashboard = { enabled = false },
        explorer = { enabled = true },
        picker = {
            enabled = true,
            hidden = true, -- show dotfiles
            sources = {
                files = { hidden = true },
                explorer = {
                    ignored = true, -- show git-ignored files in the tree
                },
            },
        },
    },

    keys = {
        { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
        { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
        { "<leader>fg", function() Snacks.picker.grep() end, desc = "Grep" },
    },
}

return { -- <--- THIS "return {" IS CRITICAL
    {
        "neanias/everforest-nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("everforest").setup({
                background = "hard",
                transparent_background_level = 1,
            })
            vim.cmd([[colorscheme everforest]])
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({ options = {
                theme = "everforest",
                section_separators = { left = '', right = '' },
                component_separators = { left = '', right = '' },
            } })
        end,
    }
} -- <--- CLOSE THE TABLE

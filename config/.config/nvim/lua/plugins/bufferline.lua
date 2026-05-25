return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
        options = {
            mode = "buffers",
            diagnostics = "nvim_lsp",
            separator_style = "thin",
            show_close_icon = false,
            show_buffer_close_icons = false,
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "File Explorer",
                    highlight = "Directory",
                    separator = true,
                },
            },
        },
        highlights = {
            -- Selected (active) buffer: green text, no italic
            buffer_selected = {
                fg = "#dbbc7f", -- Everforest warm yellow
                bold = true,
                italic = false,
            },
            -- Subtle indicator bar under the active buffer
            indicator_selected = {
                fg = "#dbbc7f",
            },
            separator = {
                fg = "#829181", -- Everforest grey (comment color)
            },
            separator_visible = {
                fg = "#829181",
            },
            separator_selected = {
                fg = "#829181",
            },
        },
    },
    keys = {
        { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Previous Buffer" },
        { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
        { "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "Pin Buffer" },
        { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close Other Buffers" },
        { "<leader>bd", "<cmd>bdelete<cr>", desc = "Delete Buffer" },
    },
}

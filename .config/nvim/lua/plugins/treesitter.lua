return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "python", "javascript", "bash", "markdown", "json" },
                auto_install = true,
                highlight = { enable = true },
            })
        end,
    }
}

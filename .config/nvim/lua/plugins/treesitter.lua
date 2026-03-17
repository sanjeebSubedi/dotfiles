return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "python", "javascript", "typescript", "tsx", "bash", "markdown", "json", "html", "css", "rust", "toml" },
                auto_install = true,
                highlight = { enable = true },
            })
        end,
    }
}

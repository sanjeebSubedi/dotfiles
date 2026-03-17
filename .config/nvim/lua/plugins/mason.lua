return {
    "mason-org/mason.nvim",
    dependencies = {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        require("mason").setup()
        require("mason-tool-installer").setup({
            ensure_installed = {
                "stylua",
                "prettier",
                "ruff",
                "clang-format",
                "shfmt",
                "eslint_d",
                "shellcheck",
                "markdownlint", 
            },
        })
    end,
}

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason-org/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local lspconfig = require("lspconfig")
            local mason_lspconfig = require("mason-lspconfig")
            local cmp_nvim_lsp = require("cmp_nvim_lsp")

            -- Used to enable autocompletion (assign to every lsp server config)
            local capabilities = cmp_nvim_lsp.default_capabilities()

            -- Global LSP keymaps via LspAttach (applies to ALL servers including rust_analyzer)
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(ev)
                    local opts = function(desc)
                        return { buffer = ev.buf, silent = true, desc = desc }
                    end
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("Go to Declaration"))
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("Go to Definition"))
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Hover Documentation"))
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("Go to Implementation"))
                    vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help, opts("Signature Help"))
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("Rename Symbol"))
                    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("Code Action"))
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts("Go to References"))
                end,
            })

            -- Mason-managed servers
            mason_lspconfig.setup({
                ensure_installed = {
                    "pyright",   -- Python (type checking only, ruff handles linting/formatting)
                    "lua_ls",    -- Lua
                    "ts_ls",     -- JS/TS
                    "html",      -- HTML
                    "cssls",     -- CSS
                    "jsonls",    -- JSON
                    "marksman",  -- Markdown
                    "clangd",    -- C/C++
                    "bashls",    -- Bash/Zsh
                },
                handlers = {
                    -- Default handler for all servers
                    function(server_name)
                        lspconfig[server_name].setup({
                            capabilities = capabilities,
                        })
                    end,
                    ["lua_ls"] = function()
                        lspconfig.lua_ls.setup({
                            capabilities = capabilities,
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = { "vim" },
                                    },
                                    workspace = {
                                        library = vim.api.nvim_get_runtime_file("", true),
                                    },
                                },
                            },
                        })
                    end,
                    ["pyright"] = function()
                        lspconfig.pyright.setup({
                            capabilities = capabilities,
                            settings = {
                                python = {
                                    analysis = {
                                        typeCheckingMode = "basic",
                                    },
                                },
                            },
                        })
                    end,
                },
            })

            -- Rust: use native Neovim 0.11+ API (rustup provides rust-analyzer)
            -- Install with: rustup component add rust-analyzer
            vim.lsp.config("rust_analyzer", {
                cmd = { "rust-analyzer" },
                root_markers = { "Cargo.toml", "rust-project.json" },
                capabilities = capabilities,
                settings = {
                    ["rust-analyzer"] = {
                        check = {
                            command = "clippy",
                        },
                    },
                },
            })
            vim.lsp.enable("rust_analyzer")
        end,
    },
}

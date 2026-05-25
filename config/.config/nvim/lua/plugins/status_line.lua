return {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            -- Custom function to fetch active LSP clients for the current buffer
            local function show_macro_lsp()
                local clients = vim.lsp.get_clients({ bufnr = 0 })
                if next(clients) == nil then
                    return "  No LSP"
                end
                local client_names = {}
                for _, client in ipairs(clients) do
                    -- Filter out copilot/null-ls if you add them later and want to hide them
                    table.insert(client_names, client.name)
                end
                return "  " .. table.concat(client_names, ", ")
            end

            require("lualine").setup({
                options = {
                    theme = "everforest",
                    section_separators = { left = '', right = '' },
                    component_separators = { left = '', right = '' },
                    globalstatus = true, -- Uses a single status line at the bottom instead of one per split
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 
                        { 'branch', icon = '' }, 
                        { 'diff', symbols = { added = ' ', modified = ' ', removed = ' ' } } 
                    },
                    lualine_c = {
                        {
                            'filename',
                            path = 1, -- Shows relative path (e.g., src/main.c) instead of just the filename
                            symbols = { modified = ' ', readonly = ' ', unnamed = '[No Name]' }
                        }
                    },
                    lualine_x = {
                        { 'diagnostics', update_in_insert = false }, -- Displays diagnostics only when they are enabled
                        { show_macro_lsp, color = { gui = "bold" } },
                        'filetype'
                    },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                },
                -- Completely disable the inactive statuslines for a cleaner UI when using splits
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {}
                }
            })
        end,
    }

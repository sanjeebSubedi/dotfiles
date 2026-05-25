return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        signs = {
            add = { text = "│" },
            change = { text = "│" },
            delete = { text = "󰍵" },
            topdelete = { text = "‾" },
            changedelete = { text = "~" },
            untracked = { text = "│" },
        },
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns

            local map = function(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
            end

            -- Hunk navigation
            map("n", "]h", gs.next_hunk, "Next Hunk")
            map("n", "[h", gs.prev_hunk, "Previous Hunk")

            -- Hunk actions
            map("n", "<leader>gs", gs.stage_hunk, "Stage Hunk")
            map("n", "<leader>gr", gs.reset_hunk, "Reset Hunk")
            map("v", "<leader>gs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage Hunk")
            map("v", "<leader>gr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Reset Hunk")
            map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
            map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
            map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame Line")
            map("n", "<leader>gB", gs.toggle_current_line_blame, "Toggle Line Blame")
            map("n", "<leader>gd", gs.diffthis, "Diff This")
        end,
    },
}

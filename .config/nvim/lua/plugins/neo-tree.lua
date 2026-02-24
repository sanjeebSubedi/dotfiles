return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',

  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },

  cmd = 'Neotree',

  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    { '<leader>gs', ':Neotree float git_status<CR>', desc = 'Git Status Tree', silent = true },
  },

  opts = {
    close_if_last_window = true,
    popup_border_style = "rounded",

    -- Enable diagnostics and git integration
    enable_git_status = true,
    enable_diagnostics = true,

    default_component_configs = {
      -- Turn on the extra data columns
      file_size = { enabled = true, width = 12 },
      type = { enabled = true, width = 10 },
      last_modified = { enabled = true, width = 20 },
    },
    highlight = {
        NeoTreeCursorLine = { bg = "#2a2a2a", fg = "NONE" },
    },

    filesystem = {
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
      filtered_items = {
        visible = false,
        hide_dotfiles = false, -- Keep dotfiles visible
        hide_gitignored = true,
      },

      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['l'] = 'open',
          ['h'] = 'close_node',
        },
      },
    },

    -- The Git Window specific mappings
    git_status = {
      window = {
        mappings = {
          ["A"]  = "git_add_all",
          ["gu"] = "git_unstage_file",
          ["ga"] = "git_add_file",
          ["gc"] = "git_commit",
          ["gp"] = "git_push",
        },
      },
    },
  },
}

local M = {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
}

function M.config()
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local builtin = require("telescope.builtin")

  telescope.setup({
    pickers = {
      live_grep = {
        additional_args = function(_)
          return { "--hidden" }
        end,
      },
      colorscheme = {
        enable_preview = true,
      },
    },
    defaults = {
      file_ignore_patterns = { "node_modules", "%.git[\\/]", "%.cache", "%.o", "%.out", "%.exe" }, -- [\\/] matches either / or \ in paths, necessary for windows
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<Tab>"] = actions.select_default,
        },
        n = {
          ["<Tab>"] = actions.select_default,
        },
      },
    },
  })

  -- Load fzf extension for telescope
  telescope.load_extension("fzf")

  -- Keymaps
  vim.keymap.set("n", "<leader>ff", builtin.find_files)
  vim.keymap.set("n", "<leader>ft", builtin.live_grep)
  vim.keymap.set("n", "<leader>fb", builtin.buffers)
  vim.keymap.set("n", "<leader>fr", builtin.oldfiles)
  vim.keymap.set("n", "<leader>fh", builtin.highlights)
  vim.keymap.set("n", "<leader>fc", builtin.colorscheme)

  -- Telescope find files without preview
  vim.keymap.set("n", "<leader>fp", function()
    builtin.find_files({
      hidden = true,
      previewer = false,
    })
  end)

  -- Telescope find files inside dotfiles
  vim.keymap.set("n", "<leader>fd", function()
    builtin.find_files({
      hidden = true,
    })
  end)

  -- Telescope search currently selected text
  vim.keymap.set("x", "<leader>ft", "y<ESC>:Telescope live_grep default_text=<c-r>0<CR>")
end

return M

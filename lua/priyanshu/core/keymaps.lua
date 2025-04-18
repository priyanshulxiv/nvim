-- Stop hlsearch
vim.keymap.set("n", "<leader>h", "<CMD>nohlsearch<CR>", { silent = true })

-- Create split and move cursor to new split
vim.keymap.set("n", "|", "<CMD>vsplit<CR><C-w>l", { silent = true })
vim.keymap.set("n", "-", "<CMD>split<CR><C-w>j", { silent = true })

-- Quick file save/close action
vim.keymap.set("n", "<leader>w", "<CMD>w<CR>", { silent = true })
vim.keymap.set("n", "<leader>q", "<CMD>bp|bd #<CR>", { silent = true })

-- Line Wrap
vim.keymap.set("n", "<leader>lw", "<CMD>set wrap!<CR>", { silent = true })

-- Toggle Read-Only mode for current buffer
vim.keymap.set("n", "<leader>ro", function()
  local modifiable = vim.bo.modifiable
  vim.bo.modifiable = not modifiable
  if vim.bo.modifiable then
    vim.notify("[Modifiable]", vim.log.levels.INFO)
  else
    vim.notify("[Read only]", vim.log.levels.WARN)
  end
end, { silent = true })

-- Move Lines in Visual mode
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv")

-- This function fixes screen flickering when pressing <C-d> from top of the file
local function lazy(keys)
  keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
  return function()
    local old = vim.o.lazyredraw
    vim.o.lazyredraw = true
    vim.api.nvim_feedkeys(keys, "nx", false)
    vim.o.lazyredraw = old
  end
end

-- Cursor stays at the center of the screen
vim.keymap.set("n", "<C-d>", lazy("<C-d>zz"))
vim.keymap.set("n", "<C-u>", lazy("<C-u>zz"))

-- Cursor stays at the center of the screen
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Cursor stays at the current position after Joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- Stay in Visual mode after changing Indent with < >
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

-- Move around in Line wrap
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- Resize split with Arrow Keys
vim.keymap.set("n", "<Up>", "<CMD>resize +2<CR>", { silent = true })
vim.keymap.set("n", "<Down>", "<CMD>resize -2<CR>", { silent = true })
vim.keymap.set("n", "<Right>", "<CMD>vertical resize +2<CR>", { silent = true })
vim.keymap.set("n", "<Left>", "<CMD>vertical resize -2<CR>", { silent = true })

-- Copy to system clipboard
vim.keymap.set({ "n", "x" }, "<leader>y", '"+y')

-- Keep the deleted text in black-hole register
vim.keymap.set({ "n", "x" }, "<leader>d", '"_d')

-- Copy current directory path to clipboard
vim.keymap.set(
  "n",
  "<leader>cfp",
  '<CMD>let @+ = expand("%:p:h")<CR><CMD>lua print("Copied path to: " .. vim.fn.expand("%:p:h"))<CR>'
)

-- Terminal splits
vim.keymap.set("n", "<leader>t-", "<CMD>belowright 10split | term<CR>", { silent = true })
vim.keymap.set("n", "<leader>t|", "<CMD>botright 70vsplit | term<CR>", { silent = true })

-- Remap to move horizontally in command-line mode without using arrow key
vim.keymap.set("c", "<C-h>", "<Left>")
vim.keymap.set("c", "<C-l>", "<Right>")

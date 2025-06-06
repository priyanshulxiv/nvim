-- Store view files in  home/.vim/viewdir
vim.opt.viewdir = vim.fn.expand("$HOME") .. "/.vim/viewdir"

-- Remove LCD (local working directory) information from view save files (which is enabled by default)
vim.opt.viewoptions:remove("curdir")

-- Autocommand to save view state on exiting buffer window
vim.api.nvim_create_autocmd("BufWinLeave", {
  group = vim.api.nvim_create_augroup("SaveViewState", { clear = true }),
  pattern = "*",
  callback = function()
    if vim.bo.filetype ~= "" and vim.bo.buftype == "" then
      vim.cmd("silent! mkview")
    end
  end,
})

-- Autocommand to load view state and center screen on entering a buffer window
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("LoadViewState", { clear = true }),
  pattern = "*",
  callback = function()
    if vim.bo.filetype ~= "" and vim.bo.buftype == "" then
      vim.cmd("silent! loadview")
      vim.cmd("normal! zz")
    end
  end,
})

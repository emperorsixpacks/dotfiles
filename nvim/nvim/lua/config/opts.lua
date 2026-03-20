vim.opt.clipboard = 'unnamedplus'

vim.cmd 'set expandtab'
vim.cmd 'set tabstop=2'
vim.cmd 'set softtabstop=2'
vim.cmd 'set shiftwidth=2'
vim.g.mapleader = ' '

vim.opt.swapfile = false

vim.wo.number = true

require 'config.remaps'
require("core.utils.py-env").loadPythonEnv()

-- Diagnostics: show error text inline and on hover
vim.diagnostic.config({
  virtual_text = {
    prefix = '●',  -- icon before the message
    source = 'if_many', -- show source name only when multiple LSPs disagree
  },
  signs = true,
  underline = true,
  update_in_insert = false, -- don't show errors while typing
  severity_sort = true,     -- errors before warnings
  float = {
    border = 'rounded',
    source = true,           -- show which LSP reported the error
  },
})

-- Press <leader>e to open floating error detail
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic detail' })
-- Navigate between errors with [d and ]d
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })

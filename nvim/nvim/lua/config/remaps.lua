local opts = { noremap = true, silent = true }

-- Navigate vim panes better
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', opts)
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', opts)
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', opts)
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', opts)

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>', opts)

-- Creating panes
vim.keymap.set('n', '<leader>v', ':vsplit <CR>', opts)
vim.keymap.set('n', '<leader>h', ':split <CR>', opts)

-- Resize panes
vim.keymap.set('n', '<S-Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<S-down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<S-right>', ':vertical resize +2<CR>', opts)
vim.keymap.set('n', '<S-left>', ':vertical resize -2<CR>', opts)

--Indent
vim.keymap.set('v', '>', '>gv', opts)
vim.keymap.set('v', '<', '<gv', opts)

-- Moving Text
vim.keymap.set('v', '<A-k>', ":move '<-2<CR>gv-gv", opts)
vim.keymap.set('v', '<A-j>', ":move '>+1<CR>gv-gv", opts)

--Saving
vim.keymap.set('n', '<C-a>', ":w <CR>", opts)

-- Cut and paste
vim.keymap.set('v', 'p', '"_dP', opts)

-- Selecting Text
vim.keymap.set('n', 'fn', ':/<CR>', opts)
vim.keymap.set('n', '<leader>fn', ':nohlsearch<CR>', opts)
-- Selecting Text Visual Mode
vim.keymap.set('v', 'fn', ':/<CR>', opts)
vim.keymap.set('v', '<leader>fn', ':nohlsearch<CR>', opts)
vim.keymap.set('n', '<leader>o', ':Oil<CR>', { desc = 'Open Oil' })

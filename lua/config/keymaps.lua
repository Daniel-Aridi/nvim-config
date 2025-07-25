vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true
vim.opt.backspace = 'indent,eol,start'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = true
vim.opt.autoread = true

-- use spaces for tabs and whatnot

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')

-- alt + direction keys for window navigation
vim.keymap.set('n', '<A-j>', '<C-w>j', { desc = 'Move down' })
vim.keymap.set('n', '<A-k>', '<C-w>k', { desc = 'Move up' })
vim.keymap.set('n', '<A-h>', '<C-w>h', { desc = 'Move left' })
vim.keymap.set('n', '<A-l>', '<C-w>l', { desc = 'Move right' })
vim.keymap.set('n', '<leader>sv', ':vsplit<CR>', { desc = 'Vertical Split' })
vim.keymap.set('n', '<leader>sh', ':split<CR>', { desc = 'Horizontal Split' })


vim.keymap.set("n", "<leader>t", function()
  vim.cmd("Floaterminal")
end, { noremap = true, silent = true })

-- inspired by nvchad's defaults!

local map = vim.keymap.set

map('i', 'jk', '<esc>')
map('n', ';', ':')
map('n', '<esc>', '<cmd>noh<cr>')

map('t', '<c-x>', '<c-\\><c-n>')
map('n', '<leader>b', function()
  vim.cmd('terminal ' .. vim.o.shell)
  vim.api.nvim_buf_set_name(0, 'Terminal')
  vim.cmd('startinsert')
end)

-- window nav
map('n', '<c-h>', '<c-w>h', { desc = 'switch window left' })
map('n', '<c-j>', '<c-w>j', { desc = 'switch window down' })
map('n', '<c-k>', '<c-w>k', { desc = 'switch window up' })
map('n', '<c-l>', '<c-w>l', { desc = 'switch window right' })

-- nvim-tree
map('n', '<c-n>', '<cmd>NvimTreeToggle<cr>', { desc = 'nvim-tree toggle' })

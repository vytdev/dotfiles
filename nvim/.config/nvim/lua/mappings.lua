-- heavily inspired by nvchad's defaults!

local map = vim.keymap.set

map('i', 'jk', '<esc>')
map('n', ';', ':',                  { desc = 'enter command mode' })
map('n', '<esc>', '<cmd>noh<cr>',   { desc = 'clear highlights' })

-- window nav
map('n', '<c-h>', '<c-w>h',         { desc = 'switch window left' })
map('n', '<c-j>', '<c-w>j',         { desc = 'switch window down' })
map('n', '<c-k>', '<c-w>k',         { desc = 'switch window up' })
map('n', '<c-l>', '<c-w>l',         { desc = 'switch window right' })

-- buffer nav
map('n', '<tab>', '<cmd>BufferLineCycleNext<cr>', { desc = 'buffer next' })
map('n', '<s-tab>', '<cmd>BufferLineCyclePrev<cr>', { desc = 'buffer previous' })
map('n', '<leader>x', function()
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.fn.len(vim.fn.getbufinfo({ buflisted = 1 })) > 1 then
    vim.cmd('BufferLineCyclePrev')
  end
  vim.cmd('bd ' .. bufnr)
end, { desc = 'buffer close' })

-- nvim-tree
map('n', '<leader>n',     '<cmd>NvimTreeToggle<cr>', { desc = 'nvim-tree toggle' })

-- terminal
map('t', '<c-x>', '<c-\\><c-n>', { desc = 'terminal escape terminal mode' })
map({ 'n', 't' }, '<a-t>', require'terminal'.toggle, { desc = 'terminal toggle terminal' })

-- color picker
map('n', '<leader>cp', '<cmd>CccPick<cr>',     { desc = 'color pick' })
map('n', '<leader>cc', '<cmd>CccConvert<cr>',  { desc = 'color convert' })

-- whichkey
map('n', '<leader>wK', '<cmd>WhichKey<cr>', { desc = 'whichkey all keymaps' })
map('n', '<leader>wk', function()
  vim.cmd('WhichKey ' .. vim.fn.input 'WhichKey: ')
end, { desc = 'whichkey find key' })

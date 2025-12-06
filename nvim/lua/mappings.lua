-- heavily inspired by nvchad's defaults!

local map = vim.keymap.set

map('i', 'jk', '<esc>')
map('n', ';', ':',                  { desc = 'enter command mode' })
map('n', '<esc>', '<cmd>noh<cr>',   { desc = 'clear highlights' })

map('i', '<c-b>', '<esc>^i',        { desc = 'move beginning of line' })
map('i', '<c-e>', '<end>',          { desc = 'move end of line' })
map('n', '<leader>/', 'gcc',        { desc = 'toggle comment', remap = true })
map('v', '<leader>/', 'gc',         { desc = 'toggle comment', remap = true })

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
map('n', '<c-n>',     '<cmd>NvimTreeToggle<cr>', { desc = 'nvim-tree toggle' })
map('n', '<leader>n', '<cmd>NvimTreeFocus<cr>',  { desc = 'nvim-tree focus' })

-- terminal
map('t', '<c-x>', '<c-\\><c-n>', { desc = 'terminal escape terminal mode' })
map({ 'n', 't' }, '<a-t>', require'terminal'.toggle, { desc = 'terminal toggle terminal' })

-- color picker
map('n', '<leader>cp', '<cmd>CccPick<cr>',     { desc = 'color pick' })
map('n', '<leader>cc', '<cmd>CccConvert<cr>',  { desc = 'color convert' })

-- telescope
map('n', '<leader>fw', '<cmd>Telescope live_grep<CR>', { desc = 'telescope live grep' })
map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>', { desc = 'telescope help page' })
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', { desc = 'telescope find files' })
map('n', '<leader>fo', '<cmd>Telescope oldfiles<CR>', { desc = 'telescope find oldfiles' })

-- whichkey
map('n', '<leader>wK', '<cmd>WhichKey<cr>', { desc = 'whichkey all keymaps' })
map('n', '<leader>wk', function()
  vim.cmd('WhichKey ' .. vim.fn.input 'WhichKey: ')
end, { desc = 'whichkey find key' })

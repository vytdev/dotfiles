vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require'core.lazy'        -- load plugins
require'core.options'
require'core.autocmds'

vim.schedule(function()
  require'core.mappings'
end)

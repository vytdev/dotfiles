vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require'core.lazy'        -- load plugins
require'core.options'

-- setup keymaps later
vim.schedule(function()
  require'core.mappings'
end)

-- load UI stuff on UIEnter
vim.api.nvim_create_autocmd('UIEnter', {
  once = true,
  callback = function()
    require'ui'
  end
})

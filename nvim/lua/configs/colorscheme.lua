require'catppuccin'.setup{
  flavour = 'mocha',

  styles = {
    comments = {},
    conditionals = {},
  },

  auto_integrations = true,
}

vim.cmd.colorscheme'catppuccin'


-- custom highlight groups
local hl = vim.api.nvim_set_hl
local cp = require'catppuccin.palettes'.get_palette()

-- auto completion styles
hl(0, 'CmpPmenu', { bg = cp.base })
hl(0, 'CmpDoc', { bg = cp.base })
hl(0, 'CmpBorder', { fg = cp.surface1, bg = 'none', })
hl(0, 'CmpSel', { fg = cp.mantle, bg = cp.mauve })

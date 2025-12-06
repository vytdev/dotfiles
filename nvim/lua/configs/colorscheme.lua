require'catppuccin'.setup{
  flavour = 'mocha',
  no_italic = true,    -- italics don't look great

  default_integrations = false,
  auto_integrations = false,

  integrations = {
    cmp = true,
    mason = true,
    nvimtree = true,
    telescope = { enabled = true, },
    which_key = true,
    -- see:
    -- - nvim/lua/configs/bufferline.lua
    -- - nvim/lua/configs/lualine.lua
  },
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

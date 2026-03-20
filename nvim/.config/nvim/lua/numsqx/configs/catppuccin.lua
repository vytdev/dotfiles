local catppuccin = require'catppuccin'

catppuccin.setup{
  flavour = 'mocha',
  transparent_background = true,
  no_italic = true,    -- italics don't look great

  default_integrations = false,
  auto_integrations = false,

  custom_highlights = function(cp)
    return {
      CmpPmenu = { bg = 'none' },
      CmpDoc = { bg = 'none' },
      CmpBorder = { fg = cp.surface1, bg = 'none' },
      CmpSel = { fg = cp.mantle, bg = cp.mauve },
    }
  end,

  integrations = {
    cmp = true,
    nvimtree = true,
  }
}

vim.cmd.colorscheme'catppuccin'

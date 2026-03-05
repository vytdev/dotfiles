require'catppuccin'.setup{
  flavour = 'mocha',
  no_italic = true,    -- italics don't look great

  default_integrations = false,
  auto_integrations = false,

  custom_highlights = function(cp)
    return {
      CmpPmenu = { bg = cp.base },
      CmpDoc = { bg = cp.base },
      CmpBorder = { fg = cp.surface1, bg = 'none' },
      CmpSel = { fg = cp.mantle, bg = cp.mauve },
    }
  end,

  color_overrides = {
    mocha = {
      base = '#151515',
      mantle = '#1a1a1a',
      crust = '#202020',
    }
  },

  integrations = {
    cmp = true,
    mason = true,
    nvimtree = true,
    which_key = true,
    -- see:
    -- - nvim/lua/configs/lualine.lua
  }
}

vim.cmd.colorscheme'catppuccin'

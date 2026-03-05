return {
  'nvim-tree/nvim-web-devicons',

  -- which-key
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
  },

  -- custom status line
  {
    'nvim-lualine/lualine.nvim',
    event = 'UIEnter',
    config = function() require'configs.lualine' end,
  },

  -- nvim-tree
  {
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus', },
    config = function() require'configs.nvim-tree' end,
  },
}

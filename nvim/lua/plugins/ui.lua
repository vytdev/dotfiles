return {
  'nvim-tree/nvim-web-devicons',

  -- which-key
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
  },

  -- telescope
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    dependencies = {
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', },
    },
    config = function() require'configs.telescope' end,
  },

  -- bufferline
  {
    'akinsho/bufferline.nvim',
    event = 'BufReadPost',
    cmd = { 'BufferLineCyclePrev', 'BufferLineCycleNext', },
    config = function() require'configs.bufferline' end,
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

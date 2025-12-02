return {

  'nvim-lua/plenary.nvim',

  -- colorscheme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    lazy = false,
    config = function() require'configs.colorscheme' end,
  },
}

return {

  -- icon library
  'nvim-tree/nvim-web-devicons',

  -- default lsp configs
  {
    'neovim/nvim-lspconfig',
    event = 'BufReadPost',
    config = function() require'numsqx.lsp' end,
  },

  -- colorscheme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    lazy = false,
    config = function() require'numsqx.configs.catppuccin' end,
  },

  -- custom status line
  {
    'nvim-lualine/lualine.nvim',
    event = 'UIEnter',
    config = function() require'numsqx.configs.lualine' end,
  },

  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPre', 'BufNewFile', },
    build = ':TSUpdate',
    config = function() require'numsqx.configs.treesitter' end,
  },

  -- autocomplete
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = function() require'numsqx.configs.cmp' end,
    dependencies = {
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'https://codeberg.org/FelipeLema/cmp-async-path.git',
    }
  },

  -- autopairs [](){}
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
      disable_filetype = { 'vim' },
    }
  }
}

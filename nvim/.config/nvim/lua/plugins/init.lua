return {

  'nvim-tree/nvim-web-devicons',

  -- colorscheme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    lazy = false,
    config = function() require'core.theme' end,
  },

  -- default lsp configs
  {
    'neovim/nvim-lspconfig',
    event = 'BufReadPost',
    config = function() require'lang.lsp' end,
  },

  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
  },

  -- autocomplete
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = function() require'lang.autocomp' end,
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

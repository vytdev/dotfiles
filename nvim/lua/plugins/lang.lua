return {
  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPre', 'BufNewFile', },
    build = ':TSUpdate',
    config = function() require'configs.treesitter' end,
  },

  -- mason
  {
    'mason-org/mason.nvim',
    cmd = { 'Mason', 'MasonInstall', 'MasonUpdate', },
    opts = {},
  },

  -- lsp
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost' },
    config = function() require'configs.lspconfig' end,
  },

  -- autocomplete
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = function() require'configs.cmp' end,
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        dependencies = { 'rafamadriz/friendly-snippets', },
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'https://codeberg.org/FelipeLema/cmp-async-path.git',
    },
  },

  -- autopairs [](){}
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
      disable_filetype = { 'TelescopePrompt', 'vim', },
    },
  },

  -- color picker
  {
    'uga-rosa/ccc.nvim',
    event = { 'BufReadPre', 'BufNewFile', },
    opts = {
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    },
  },
}

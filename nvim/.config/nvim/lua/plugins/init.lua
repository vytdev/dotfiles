return {

  'nvim-tree/nvim-web-devicons',

  -- colorscheme
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    lazy = false,
    config = function() require'configs.catppuccin' end,
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

  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPre', 'BufNewFile', },
    build = ':TSUpdate',
    config = function() require'configs.treesitter' end,
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
      disable_filetype = { 'vim', },
    }
  },

  -- color picker
  {
    'uga-rosa/ccc.nvim',
    event = { 'BufReadPre', 'BufNewFile', },
    opts = {
      highlighter = {
        auto_enable = true,
        lsp = true,
      }
    }
  }
}

return {

  'nvim-lua/plenary.nvim',
  'nvim-tree/nvim-web-devicons',

  -- colorscheme
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    lazy = false,
    config = function()
      require'onedark'.setup{
        style = 'warmer',
        code_style = {
          comments = 'none',
        },
      }
      require'onedark'.load()
    end,
  },

  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPre', 'BufNewFile', },
    build = ':TSUpdate',
    config = function() require'configs.treesitter' end,
  },

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
    config = function() require'telescope'.load_extension('fzf') end,
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
    config = function() require'configs.lspconfig'.lsp_setup() end,
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
    event = 'VeryLazy',
    config = function() require'configs.lualine' end,
  },

  -- neo-tree
  {
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeFocus', },
    config = function() require'configs.nvim-tree' end,
  },
}

return {
  {
    'stevearc/conform.nvim',
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require 'configs.conform',
  },

  -- test new blink
  -- { import = 'nvchad.blink.lazyspec' },

  -- syntax highlighting for what i usually use
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = {
        'vim', 'vimdoc', 'lua', 'python', 'javascript', 'typescript',
        'html', 'css', 'bash', 'json', 'yaml', 'c', 'cpp', 'markdown',
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      }
    },
  },

  -- configure lsp
  -- see: ../configs/lspconfig.lua
  {
    'neovim/nvim-lspconfig',
    config = function()
      require 'configs.lspconfig'
    end,
  },
}

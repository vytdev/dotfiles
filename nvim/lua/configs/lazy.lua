return {
  defaults = { lazy = true },
  install = { colorscheme = { 'catppuccin' } },

  ui = {
    icons = {
      loaded = '󰄳 ',
      not_loaded = '󰄰 ',
    },
  },

  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'tarPlugin',
        'zipPlugin',
        'man',
        'netrwPlugin',
        'spellfile',
        'tohtml',
        'tutor',
      },
    },
  },
}

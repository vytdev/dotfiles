return {
  defaults = { lazy = true },
  install = { colorscheme = { 'onedark' } },

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

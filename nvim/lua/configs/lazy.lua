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
        'netrw',
        'netrwPlugin',
        'netrwSettings',
        'netrwFileHandlers',

        'gzip',
        'zip',
        'zipPlugin',
        'tar',
        'tarPlugin',

        'vimball',
        'vimballPlugin',

        'matchit',
        'matchparen',

        'syntax',
        'synmenu',
        'ftplugin',

        '2html_plugin',
        'tohtml',

        'tutor',
        'tutor_mode_plugin',

        'getscript',
        'getscriptPlugin',
        'rplugin',

        'logipat',
        'rrhelper',
        'spellfile_plugin',
        'optwin',
        'compiler',
        'bugreport',
      },
    },
  },
}

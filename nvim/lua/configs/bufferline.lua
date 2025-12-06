require'bufferline'.setup{
  options = {
    indicator_icon = ' ',
    diagnostics = false,
    separator_style = 'thin',

    offsets = {
      { filetype = 'NvimTree', },
    },
  },

  -- catppuccin integration
  highlights = require'catppuccin.special.bufferline'.get_theme(),
}

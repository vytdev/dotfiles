require'bufferline'.setup{
  options = {
    indicator_icon = ' ',
    diagnostics = false,
    separator_style = 'thin',

    offsets = {
      {
        filetype = 'NvimTree',
        text = 'File Explorer',
        text_align = 'center',
      },
    },
  },
}

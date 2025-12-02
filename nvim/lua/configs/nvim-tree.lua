require'nvim-tree'.setup{
  git = { enable = false, },
  diagnostics = { enable = false, },

  renderer = {
    root_folder_label = false,
    icons = {
      glyphs = {
        default = '󰈔',
        symlink = '󱅷',
        folder = {
          arrow_open = '󰅀',
          arrow_closed = '󰅂',
          default = '󰉋',
          open = '󰝰',
          empty = '󰉖',
          empty_open = '󰷏',
          symlink = '󱧮',
        },
      },
    },
  },
}

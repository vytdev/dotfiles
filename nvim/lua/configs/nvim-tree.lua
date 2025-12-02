require'nvim-tree'.setup{
  git = { enable = false, },
  diagnostics = { enable = false, },

  renderer = {
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

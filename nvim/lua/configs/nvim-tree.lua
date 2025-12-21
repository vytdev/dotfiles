require'nvim-tree'.setup{
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
      -- hide git status icons
      show = {
        git = false,
      },
    },
  },
}

local nvimtree = require'nvim-tree'

nvimtree.setup{
  diagnostics = { enable = false, },

  sort = {
    sorter = 'case_sensitive',
  },

  view = {
    side = 'right',
    width = 30,
  },

  renderer = {
    root_folder_label = false,

    icons = {
      glyphs = {
        folder = {
          arrow_open = '󰅀',
          arrow_closed = '󰅂',
        },
      },
      -- hide git status icons
      show = {
        git = false,
      },
    }
  }
}

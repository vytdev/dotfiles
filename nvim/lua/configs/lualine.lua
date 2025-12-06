require'lualine'.setup{
  options = {
    theme = 'catppuccin', -- catppuccin integration

    globalstatus = true,
    component_separators = '',
    section_separators = '',
    ignore_focus = { 'TelescopePrompt', 'NvimTree', },
  },

  sections = {
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},

    -- left side
    lualine_a = {
      'mode',
    },
    lualine_c = {
      {
        'filetype',
        icon_only = true,
        padding = { left = 1, right = 0, },
      },
      {
        'filename',
        path = 1,
        symbols = {
          modified = '󰃉 ',
          readonly = '󰌆 ',
          unnamed = '[No Name]',
        },
      },
      {
        'diagnostics',
        symbols = {
          error = '󰅙 ',
          warn  = '󰀦 ',
          info  = '󰋼 ',
          hint  = '󰌵 ',
        },
      },
    },

    -- right side
    lualine_x = {
      'diff',
      { 'branch', icon = '󰘬', },
      'location',
    },
  },
}

require'nvim-treesitter'.setup{

  ensure_installed = {
    'lua', 'luadoc', 'printf', 'vim', 'vimdoc', 'query',
  },

  auto_install = true,

  highlight = {
    enable = true,
    use_languagetree = true,
    additional_vim_regex_highlighting = false,
  },

  indent = {
    enable = true,
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },

}

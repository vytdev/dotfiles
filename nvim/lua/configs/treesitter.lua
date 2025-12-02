require'nvim-treesitter.configs'.setup{

  ensure_installed = {
    'lua', 'luadoc', 'printf', 'vim', 'vimdoc', 'query',
    'markdown', 'markdown_inline', 'html', 'css', 'json', 'yaml',
    'bash', 'python', 'c', 'cpp', 'javascript', 'typescript',
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

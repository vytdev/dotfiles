-- C, C++, etc.

vim.lsp.config('clangd', {
  cmd = {
    'clangd', '--clang-tidy', '--completion-style=detailed',
    '--header-insertion=never',
  }
})

vim.lsp.enable'clangd'

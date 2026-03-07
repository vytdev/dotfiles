-- diagnostics config
vim.diagnostic.config({
  virtual_text = {
    prefix = '●',
    spacing = 2,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅙 ',
      [vim.diagnostic.severity.WARN]  = '󰀦 ',
      [vim.diagnostic.severity.INFO]  = '󰋼 ',
      [vim.diagnostic.severity.HINT]  = '󰌵 ',
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- do this on lsp attach
local on_attach = function(_, bufnr)
end

-- do this on lsp init
local on_init = function()
end

-- lsp capabilities (i.e., send suggestions to auto-complete)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- setup global config
vim.lsp.config('*', {
  capabilities = capabilities,
  on_init = on_init,
  on_attach = on_attach,
})

-- use system-wide clangd installation
vim.lsp.config('clangd', {
  cmd = {
    'clangd', '--clang-tidy', '--completion-style=detailed',
    '--header-insertion=never',
  }
})

-- enable the lang servers
vim.lsp.enable{
  'html', 'cssls', 'lua_ls', 'pyright',
  'ts_ls', 'bashls', 'clangd',
}

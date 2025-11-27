require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "lua_ls", "pyright", "ts_ls", "clangd" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers

local lspconfig = vim.lsp.config
lspconfig('clangd', { cmd = {
    'clangd', '--clang-tidy', '--completion-style=detailed',
    '--header-insertion=never'
  }})

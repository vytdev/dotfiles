local M = {}

-- do this on lsp attach
M.on_attach = function(_, bufnr)
  local map = function(mode, key, fn, desc)
    vim.keymap.set(mode, key, fn, {
      buffer = bufnr,
      desc = 'lsp ' .. desc,
    })
  end

  map('n', 'gD', vim.lsp.buf.declaration, 'go to declaration')
  map('n', 'gd', vim.lsp.buf.definition, 'go to definition')
  map('n', 'K', vim.lsp.buf.hover, 'hover definition')
  map('n', '<leader>rn', vim.lsp.buf.rename, 'rename symbol')
  map('n', 'gf', vim.lsp.buf.references, 'references')
end

-- do this on lsp init
M.on_init = function()
end

-- function setting up the lsp
M.lsp_setup = function()
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

  -- remove bg in virtual text
  local groups = {
    'DiagnosticVirtualTextError',
    'DiagnosticVirtualTextWarn',
    'DiagnosticVirtualTextInfo',
    'DiagnosticVirtualTextHint',
  }

  for _, group in ipairs(groups) do
    local hl = vim.api.nvim_get_hl(0, { name = group })
    vim.api.nvim_set_hl(0, group, { fg = hl.fg, bg = 'none' })
  end

  -- lsp capabilities (i.e. auto completion)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  -- setup global config
  vim.lsp.config('*', {
    capabilities = capabilities,
    on_init = M.on_init,
    on_attach = M.on_attach,
  })

  M.configure_servers()
end

-- configure and enable language servers
M.configure_servers = function()
  vim.lsp.config('lua_ls', {
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
        },
        diagnostics = {
          globals = { 'vim', },
        },
        workspace = {
          library = {
            -- config defs
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.stdpath('config') .. '/lua'] = true,
          },
        },
      },
    },
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
end

return M

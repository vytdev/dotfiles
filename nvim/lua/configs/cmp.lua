local cmp = require'cmp'
local luasnip = require'luasnip'

-- luasnip source
require'luasnip.loaders.from_vscode'.lazy_load()

-- setup auto completion
cmp.setup{

  completion = {
    completeopt = 'menu,menuone',
  },

  snippet = {
    expand = function(args)
      require'luasnip'.lsp_expand(args.body)
    end,
  },

  mapping = cmp.mapping.preset.insert({
    ['<c-b>'] = cmp.mapping.scroll_docs(-4),
    ['<c-f>'] = cmp.mapping.scroll_docs(4),
    ['<c-space>'] = cmp.mapping.complete(),
    ['<c-e>'] = cmp.mapping.abort(),

    ['<cr>'] = cmp.mapping.confirm({ select = false }),

    ['<tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<s-tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),

  sources = cmp.config.sources({
    { name = 'nvim_lua', },  -- neovim lua api
    { name = 'nvim_lsp', },
    { name = 'async_path', },
    { name = 'luasnip', },
    { name = 'buffer', },
  }),
}

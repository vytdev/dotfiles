local cmp = require'cmp'
local luasnip = require'luasnip'

-- completion kind icons
-- thx: https://github.com/onsails/lspkind.nvim
local lsp_kind = {
  Text = '󰉿',
  Method = '󰆧',
  Function = '󰊕',
  Constructor = '',
  Field = '󰜢',
  Variable = '󰀫',
  Class = '󰠱',
  Interface = '',
  Module = '',
  Property = '󰜢',
  Unit = '󰑭',
  Value = '󰎠',
  Enum = '',
  Keyword = '󰌋',
  Snippet = '',
  Color = '󰏘',
  File = '󰈙',
  Reference = '󰈇',
  Folder = '󰉋',
  EnumMember = '',
  Constant = '󰏿',
  Struct = '󰙅',
  Event = '',
  Operator = '󰆕',
  TypeParameter = '',
}

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
    { name = 'nvim_lsp_signature_help', },
    { name = 'nvim_lua', },  -- neovim lua api
    { name = 'nvim_lsp', },
    { name = 'async_path', },
    { name = 'luasnip', },
    { name = 'buffer', },
  }),

  -- proper layout
  -- see nvim/lua/configs/colorscheme.lua for color defs
  window = {
    completion = cmp.config.window.bordered({
      border = { '┌', '─', '┐', '│', '┘', '─', '└', '│', },
      scrollbar = false,
      winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:CmpSel',
    }),
    documentation = cmp.config.window.bordered({
      border = { '┌', '─', '┐', '│', '┘', '─', '└', '│', },
      scrollbar = false,
      winhighlight = 'Normal:CmpDoc,FloatBorder:CmpBorder',
    }),
  },

  -- custom icons
  formatting = {
    format = function(_, vim_item)
      vim_item.kind = string.format('%s %s',
          lsp_kind[vim_item.kind] or ' ',
          vim_item.kind)
      return vim_item
    end,
  },
}

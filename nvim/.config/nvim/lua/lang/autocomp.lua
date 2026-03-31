local cmp = require'cmp'
local lsp_kind = require'utils.lspkind'

-- setup auto completion
cmp.setup{

  completion = {
    completeopt = 'menu,menuone',
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
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<s-tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),

  sources = cmp.config.sources({
    { name = 'nvim_lsp_signature_help', }, -- function sigs
    { name = 'nvim_lua', },     -- neovim lua api
    { name = 'nvim_lsp', },     -- from lsp
    { name = 'async_path', },   -- path suggestions
    { name = 'buffer', },       -- words from buffer
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
  }
}

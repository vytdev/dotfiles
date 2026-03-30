local cp = require'catppuccin.palettes' .get_palette()

local function get_hl(hl)
  return vim.api.nvim_get_hl(0, { name = hl })
end

local colors = {
  diag_warn    = get_hl('DiagnosticWarn').fg,
  diag_error   = get_hl('DiagnosticError').fg,
  diag_hint    = get_hl('DiagnosticHint').fg,
  diag_info    = get_hl('DiagnosticInfo').fg,

  git_del      = get_hl('diffDeleted').fg,
  git_add      = get_hl('diffAdded').fg,
  git_change   = get_hl('diffChanged').fg,

  bright_bg    = cp.mantle,
  bright_fg    = cp.text,
  red          = cp.red,
  dark_red     = cp.maroon,
  green        = cp.green,
  blue         = cp.blue,
  orange       = cp.peach,
  purple       = cp.mauve,
  cyan         = cp.teal,
  yellow       = cp.yellow,
  grey         = cp.overlay0,
  dark_grey    = cp.surface0,
}

return colors

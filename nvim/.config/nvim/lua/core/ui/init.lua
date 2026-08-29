-- append color aliases
local hls = require'core.ui.hls'
hls.append_colors(require'core.ui.colors')

require'core.ui.statusline'.apply()

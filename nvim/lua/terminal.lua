-- custom toggleable terminal

local M = {}

M.buf = nil
M.win = nil

-- check if the terminal window is currently displayed
function M.is_on_view()
  return M.win and vim.api.nvim_win_is_valid(M.win)
end

-- check if the term buffer still exists
function M.is_term_alive()
  return M.buf and vim.api.nvim_buf_is_valid(M.buf) and
      vim.bo[M.buf].buftype == 'terminal'
end

-- toggle terminal
function M.toggle()
  -- hide if already open
  if M.is_on_view() then
    vim.api.nvim_win_close(M.win, true)
    M.win = nil
    return
  end

  -- setup a new window
  local height = math.floor(vim.o.lines * .3)
  vim.cmd(string.format('belowright %dsplit', height))
  M.win = vim.api.nvim_get_current_win()

  -- attach terminal
  if M.is_term_alive() then
    vim.api.nvim_win_set_buf(M.win, M.buf)
  else
    vim.cmd('terminal ' .. vim.o.shell)
    M.buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_name(M.buf, 'Terminal') -- term://...????
    vim.bo[M.buf].buflisted = false -- hide from bufferline
  end

  vim.cmd('startinsert')
end

return M

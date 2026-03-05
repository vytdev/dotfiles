-- workaround for the first file not being highlighted
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local name = vim.api.nvim_buf_get_name(bufnr)
    local ft = vim.bo[bufnr].filetype
    if name ~= '' and ft == '' then
      vim.schedule(vim.cmd.edit)
    end
  end
})

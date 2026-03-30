-- workaround for the first file not being highlighted
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function(args)
    local bufnr = args.buf

    -- skip scratch buffers
    -- skip unloaded buffers
    -- skip other buftypes
    -- reload to set the filetype
    if  vim.fn.bufname(bufnr) ~= '' and
        vim.api.nvim_buf_is_loaded(bufnr) and
        vim.bo[bufnr].buftype == '' and
        vim.bo[bufnr].filetype == ''
    then
      vim.schedule(function()
        vim.api.nvim_buf_call(bufnr, function()
          vim.cmd('silent! edit')
        end)
      end)
    end

  end
})

-- load UI stuff on UIEnter
vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    require'ui'
  end
})

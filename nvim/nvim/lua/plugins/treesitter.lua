return {
  'nvim-treesitter/nvim-treesitter',
  config = function()
    require('nvim-treesitter').setup({})

    require('nvim-treesitter').install({
      'c',
      'lua',
      'markdown',
      'markdown_inline',
      'go',
      'python',
      'rust',
      'html',
      'json',
      'vhdl',
      'systemverilog', -- also serves the `verilog` filetype
    })

    -- main branch no longer auto-enables highlighting
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}

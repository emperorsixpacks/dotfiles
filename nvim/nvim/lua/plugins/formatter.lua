return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  config = function()
    local conform = require('conform')

    conform.setup({
      formatters_by_ft = {
        lua          = { 'stylua' },
        python       = { 'isort', 'ruff_format' },
        rust         = { 'rustfmt' },
        go           = { 'goimports', 'gofmt' },
        javascript   = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescript   = { 'prettier' },
        typescriptreact = { 'prettier' },
        css          = { 'prettier' },
        scss         = { 'prettier' },
        html         = { 'prettier' },
        htmldjango   = { 'djlint' },
        json         = { 'prettier' },
        yaml         = { 'prettier' },
        markdown     = { 'prettier' },
        graphql      = { 'prettier' },
        solidity     = { 'prettier' },
        sh           = { 'shfmt' },
      },
      -- Format on save
      format_on_save = {
        timeout_ms = 2000,
        lsp_format = 'fallback', -- use LSP if no conform formatter found
      },
    })

    -- <leader>gf to format manually
    vim.keymap.set({ 'n', 'v' }, '<leader>gf', function()
      conform.format({ async = true, lsp_format = 'fallback' })
    end, { desc = 'Format file or selection' })
  end,
}
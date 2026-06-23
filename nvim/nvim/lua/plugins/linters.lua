return {
  'nvimtools/none-ls.nvim',
  config = function()
    local null_ls = require('null-ls')

    null_ls.setup({
      sources = {
        -- Python
        null_ls.builtins.diagnostics.mypy,

        -- Go
        null_ls.builtins.diagnostics.golangci_lint,

        -- Solidity
        null_ls.builtins.diagnostics.solhint.with({
          args = { '--config', '/home/adavid/.config/nvim/lua/plugins/.solhint.json', '$FILENAME' },
        }),
      },
    })
  end,
}
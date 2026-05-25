return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = function()
      require('mason').setup()
    end,
  },
  {
    'neovim/nvim-lspconfig',
    lazy = false,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    lazy = false,
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
    },
    opts = {
      auto_install = true,
      ensure_installed = {
          'tailwindcss',
          'pyright',
          'ruff',
          'sqls',
          'gopls',
          'ast_grep',
          'rust_analyzer',
          'bashls',
          'yamlls',
          'html',
          'htmx',
          'lua_ls',
          'ts_ls',
          'eslint',
      },
      handlers = {
        function(server_name)
          local capabilities = require('cmp_nvim_lsp').default_capabilities()
          require('lspconfig')[server_name].setup({
            capabilities = capabilities,
          })
        end,
        pyright = function()
          local capabilities = require('cmp_nvim_lsp').default_capabilities()
          require('lspconfig').pyright.setup({
            capabilities = capabilities,
            settings = {
              pyright = {
                disableOrganizeImports = true,
              },
              python = {
                analysis = {
                  ignore = { '*' },
                },
              },
            },
          })
        end,
      },
    },
    config = function(_, opts)
      require('mason-lspconfig').setup(opts)
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local bufnr = args.buf
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
          vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, { buffer = bufnr })
          vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, { buffer = bufnr })
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr })
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { buffer = bufnr })
        end,
      })
    end,
  },

}
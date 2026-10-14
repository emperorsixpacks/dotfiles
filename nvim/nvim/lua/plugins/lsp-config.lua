return {
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = function()
      require('mason').setup()

      -- Formatters used by conform that mason-lspconfig does not install.
      -- (verible comes with the verible LSP package, incl. verible-verilog-format)
      local registry = require('mason-registry')
      registry.refresh(function()
        for _, name in ipairs({ 'prettier', 'vsg' }) do
          local ok, pkg = pcall(registry.get_package, name)
          if ok and not pkg:is_installed() then
            pkg:install()
          end
        end
      end)
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
      -- mason-lspconfig v2: installs + auto-enables servers via vim.lsp.enable()
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
          'vhdl_ls',
          'verible',
      },
    },
    config = function(_, opts)
      -- applied to every server (the old `handlers` option is gone in v2)
      vim.lsp.config('*', {
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      })
      vim.lsp.config('rust_analyzer', {
        settings = {
          ['rust-analyzer'] = {
            check = {
              command = 'clippy',
            },
          },
        },
      })
      vim.lsp.config('pyright', {
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
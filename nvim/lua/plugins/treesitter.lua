return {
  'nvim-treesitter/nvim-treesitter',
  --- dependencies = {}
  config = function()
    ensure_installed = { "c", "lua", "markdown", "markdown_inline", "go", "python", "rust" }
    auto_install = true
  end,
}

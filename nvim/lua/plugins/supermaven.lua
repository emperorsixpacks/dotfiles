-- Supermaven: free AI ghost-text completions (like GitHub Copilot)
-- Accept suggestion with Tab, dismiss with Ctrl-]
return {
  {
    "supermaven-inc/supermaven-nvim",
    event = "InsertEnter",
    config = function()
      local ok, supermaven = pcall(require, "supermaven-nvim")
      if not ok then return end
      supermaven.setup({
        keymaps = {
          accept_suggestion = "<Tab>",   -- same as VS Code Copilot
          clear_suggestion = "<C-]>",
          accept_word = "<C-j>",
        },
        ignore_filetypes = { "TelescopePrompt", "oil" },
        color = {
          suggestion_color = "#6c7086", -- subtle grey ghost text
          cterm = 244,
        },
        log_level = "off",
      })
    end,
  },
}

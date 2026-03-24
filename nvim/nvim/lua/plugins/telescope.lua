return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    -- removed stale tag = "0.1.5" pin, track latest stable
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      telescope.setup({
        defaults = {
          -- show hidden files, ignore .git dir
          file_ignore_patterns = { "^.git/" },
          preview = {
            treesitter = false,
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            theme = "ivy",
            -- use fd if available, otherwise fall back to find
            find_command = vim.fn.executable("fd") == 1
              and { "fd", "--type", "f", "--hidden", "--exclude", ".git" }
              or nil,
          },
          live_grep = {
            theme = "ivy",
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })

      telescope.load_extension("ui-select")

      -- Keymaps
      vim.keymap.set("n", "<C-p>",       builtin.find_files,  { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg",  builtin.live_grep,   { desc = "Live grep" })
      vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, { desc = "Recent files" })
      vim.keymap.set("n", "<leader>fb",  builtin.buffers,     { desc = "Open buffers" })
      vim.keymap.set("n", "<leader>fh",  builtin.help_tags,   { desc = "Help tags" })
      vim.keymap.set("n", "<leader>fd",  builtin.diagnostics, { desc = "Diagnostics" })
    end,
  },
}

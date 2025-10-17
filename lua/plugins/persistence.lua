return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {
    options = { "buffers", "curdir", "tabpages", "winsize", "folds" },
  },
  config = function(_, opts)
    require("persistence").setup(opts)

    -- Auto-restore session when opening Neovim without arguments
    vim.api.nvim_create_autocmd("VimEnter", {
      group = vim.api.nvim_create_augroup("persistence_autoload", { clear = true }),
      callback = function()
        -- Only restore if:
        -- 1. No files were opened as arguments
        -- 2. Not in a git commit or other special buffer
        -- 3. Session exists for current directory
        if vim.fn.argc() == 0 and not vim.g.started_with_stdin then
          require("persistence").load({ last = true })
        end
      end,
      nested = true,
    })
  end,
  keys = {
    {
      "<leader>qs",
      function()
        require("persistence").load()
      end,
      desc = "Restore Session",
    },
    {
      "<leader>ql",
      function()
        require("persistence").load({ last = true })
      end,
      desc = "Restore Last Session",
    },
    {
      "<leader>qd",
      function()
        require("persistence").stop()
      end,
      desc = "Don't Save Current Session",
    },
  },
}
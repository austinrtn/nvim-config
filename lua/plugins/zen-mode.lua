return {
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        width = 120,
        options = {
          signcolumn = "no",
          number = true,
          relativenumber = true,
          cursorline = true,
          cursorcolumn = true,
          foldcolumn = "0",
          list = false,
        },
      },
    },
    config = function(_, opts)
      require("zen-mode").setup(opts)

      -- snacks.nvim integration
      require("snacks.zen").setup {
        toggles = {
          dim = true,
          git_signs = false,
          mini_diff_signs = false,
          -- diagnostics = false,
          -- inlay_hints = false,
        },
        show = {
          statusline = false,
          tabline = false,
        },
        win = {
          style = "zen", -- or "minimal"
        },
        on_open = function(win)
          require("snacks").info("Zen activated ✨")

	require("snacks").toggle("dim")
        end,
        on_close = function(win)
          require("snacks").warn("Back to reality 😵‍💫")
        end,
        zoom = {
          toggles = {},
          show = {
            statusline = true,
            tabline = true,
          },
          win = {
            backdrop = false,
            width = 0, -- full width
          },
        },
      }
    end,
  }
}

return {
  {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.everforest_background = "hard" -- or "soft" / "hard"
      vim.g.everforest_enable_italic = 1
      vim.cmd("colorscheme everforest")
    end,
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
	require("cyberdream").setup({
		transparent = true,

	})
--	vim.cmd("colorscheme cyberdream")
    end,
  }
}


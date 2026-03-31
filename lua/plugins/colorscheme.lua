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
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({})
      -- vim.cmd("colorscheme kanagawa")
    end,
  },
  {
    -- Colorscheme cycling through favorites
    dir = vim.fn.stdpath("config"),
    name = "colorscheme-cycle",
    lazy = false,
    config = function()
      local schemes = require("favorite-themes")

      local function current_index()
        local current = vim.g.colors_name or ""
        for i, s in ipairs(schemes) do
          if s == current then return i end
        end
        return 1
      end

      local function cycle(dir)
        local i = current_index()
        i = ((i - 1 + dir) % #schemes) + 1
        vim.cmd("colorscheme " .. schemes[i])
        vim.notify("Colorscheme: " .. schemes[i], vim.log.levels.INFO)
      end

      vim.keymap.set("n", "<leader>cn", function() cycle(1) end, { desc = "Next colorscheme" })
      vim.keymap.set("n", "<leader>cp", function() cycle(-1) end, { desc = "Prev colorscheme" })
    end,
  },
}


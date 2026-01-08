-- Obsidian-like markdown experience
-- render-markdown.nvim for visual rendering + obsidian.nvim for vault features

return {
  -- Render markdown beautifully (headings, code blocks, checkboxes, etc.)
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = { "markdown" },
    opts = {
      heading = {
        enabled = true,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      },
      code = {
        enabled = true,
        style = "full",
        border = "rounded",
      },
      checkbox = {
        enabled = true,
        unchecked = { icon = "󰄱 " },
        checked = { icon = "󰄵 " },
      },
      bullet = {
        enabled = true,
        icons = { "●", "○", "◆", "◇" },
      },
      inline_code = {
        enabled = true,
        highlight = "RenderMarkdownCode",
      },
    },
  },

  -- Obsidian vault integration (wiki links, daily notes, search, etc.)
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      workspaces = {
        {
          name = "notes",
          path = "~/Notes", -- Change this to your vault path!
        },
      },
      daily_notes = {
        folder = "daily",
        date_format = "%Y-%m-%d",
        template = nil,
      },
      completion = {
        nvim_cmp = true,
        min_chars = 2,
      },
      -- Keymappings
      mappings = {
        -- "gf" to follow wiki links
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle checkbox with <leader>ch
        ["<leader>ch"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
        -- Smart action (follow link or toggle checkbox)
        ["<cr>"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        },
      },
      -- Disable obsidian.nvim's UI rendering - let render-markdown.nvim handle it
      ui = {
        enable = false,
      },
      -- Note naming: use title as filename
      note_id_func = function(title)
        if title ~= nil then
          return title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          return tostring(os.time())
        end
      end,
    },
    keys = {
      { "<leader>nn", "<cmd>ObsidianNew<cr>", desc = "New note" },
      { "<leader>nq", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick switch notes" },
      { "<leader>ns", "<cmd>ObsidianSearch<cr>", desc = "Search notes" },
      { "<leader>nt", "<cmd>ObsidianToday<cr>", desc = "Today's daily note" },
      { "<leader>ny", "<cmd>ObsidianYesterday<cr>", desc = "Yesterday's daily note" },
      { "<leader>nb", "<cmd>ObsidianBacklinks<cr>", desc = "Show backlinks" },
      { "<leader>nl", "<cmd>ObsidianLinks<cr>", desc = "Show links in note" },
      { "<leader>np", "<cmd>ObsidianPasteImg<cr>", desc = "Paste image from clipboard" },
    },
  },
}

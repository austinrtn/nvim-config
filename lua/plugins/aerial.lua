return {
  'stevearc/aerial.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons'
  },
  opts = {
    -- Priority list of preferred backends for aerial.
    -- This can be a filetype map (see :help aerial-filetype-map)
    backends = { "lsp", "treesitter", "markdown", "asciidoc", "man" },

    layout = {
      -- These control the width of the aerial window.
      -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      max_width = { 40, 0.2 },
      width = nil,
      min_width = 20,

      -- key-value pairs of window-local options for aerial window (e.g. winhl)
      win_opts = {},

      -- Determines the default direction to open the aerial window. The 'prefer'
      -- options will open the window in the other direction *if* there is a
      -- different buffer in the way of the preferred direction
      default_direction = "prefer_right",

      -- Determines where the aerial window will be opened
      --   edge   - open aerial at the far right/left of the editor
      --   window - open aerial to the right/left of the current window
      placement = "window",

      -- When the symbols change, resize the aerial window (within min/max constraints) to fit
      resize_to_content = true,

      -- Preserve window size equality with `:wincmd =`
      preserve_equality = false,
    },

    -- Determines how the aerial window decides which buffer to display symbols for
    --   window - aerial window will display symbols for the buffer in the window from which it was opened
    --   global - aerial window will display symbols for the current window
    attach_mode = "window",

    -- List of enum values that configure when to auto-close the aerial window
    --   unfocus       - close aerial when you leave the original source window
    --   switch_buffer - close aerial when you change buffers in the source window
    --   unsupported   - close aerial when attaching to a buffer that has no symbol source
    close_automatic_events = {},

    -- Keymaps in aerial window. Can be any value that `vim.keymap.set` accepts OR a table of keymap
    -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
    keymaps = {
      ["?"] = "actions.show_help",
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.jump",
      ["<2-LeftMouse>"] = "actions.jump",
      ["<C-v>"] = "actions.jump_vsplit",
      ["<C-s>"] = "actions.jump_split",
      ["p"] = "actions.scroll",
      ["<C-j>"] = "actions.down_and_scroll",
      ["<C-k>"] = "actions.up_and_scroll",
      ["{"] = "actions.prev",
      ["}"] = "actions.next",
      ["[["] = "actions.prev_up",
      ["]]"] = "actions.next_up",
      ["q"] = "actions.close",
      ["o"] = "actions.tree_toggle",
      ["za"] = "actions.tree_toggle",
      ["O"] = "actions.tree_toggle_recursive",
      ["zA"] = "actions.tree_toggle_recursive",
      ["l"] = "actions.tree_open",
      ["zo"] = "actions.tree_open",
      ["L"] = "actions.tree_open_recursive",
      ["zO"] = "actions.tree_open_recursive",
      ["h"] = "actions.tree_close",
      ["zc"] = "actions.tree_close",
      ["H"] = "actions.tree_close_recursive",
      ["zC"] = "actions.tree_close_recursive",
      ["zr"] = "actions.tree_increase_fold_level",
      ["zR"] = "actions.tree_open_all",
      ["zm"] = "actions.tree_decrease_fold_level",
      ["zM"] = "actions.tree_close_all",
      ["zx"] = "actions.tree_sync_folds",
      ["zX"] = "actions.tree_sync_folds",
    },

    -- When true, don't load aerial until a command or function is called
    lazy_load = true,

    -- Disable aerial on files with this many lines
    disable_max_lines = 10000,

    -- Disable aerial on files this size or larger (in bytes)
    disable_max_size = 2000000, -- 2 MB

    -- A list of all symbols to display. Set to false to display all symbols.
    filter_kind = {
      "Class",
      "Constructor",
      "Enum",
      "Field",
      "Function",
      "Interface",
      "Module",
      "Method",
      "Struct",
    },

    -- Determines line highlighting mode when aerial is open
    highlight_mode = "split_width",

    -- When jumping to a symbol, highlight the line for this many ms
    highlight_on_hover = false,

    -- Define symbol icons. You can also specify "<Symbol>Collapsed" to change the
    -- icon when the tree is collapsed at that symbol, or "Collapsed" to specify a
    -- default collapsed icon. The default icon set is determined by the
    -- "nerd_font" option below.
    -- icons = {},

    -- Control which windows and buffers aerial should ignore.
    ignore = {
      -- Ignore unlisted buffers. See :help buflisted
      unlisted_buffers = false,

      -- Ignore diff windows (setting to false will allow aerial in diff windows)
      diff_windows = true,

      -- List of filetypes to ignore.
      filetypes = {},

      -- Ignored buftypes.
      buftypes = "special",

      -- Ignored wintypes.
      wintypes = "special",
    },

    -- Use symbol tree for folding. Set to true or false to enable/disable
    manage_folds = false,

    -- When you fold code with za, zo, etc, update the aerial tree as well.
    -- Only works when manage_folds = true
    link_folds_to_tree = false,

    -- Fold code when you open/collapse symbols in the tree.
    -- Only works when manage_folds = true
    link_tree_to_folds = true,

    -- Set default symbol icons to use patched font icons (see https://www.nerdfonts.com/)
    nerd_font = true,

    -- Call this function when aerial attaches to a buffer.
    on_attach = function(bufnr)
      -- Jump forwards/backwards with '{' and '}'
      vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
      vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
    end,

    -- Call this function when aerial first sets symbols on a buffer.
    on_first_symbols = function(bufnr) end,

    -- Automatically open aerial when entering supported buffers.
    open_automatic = false,

    -- Run this command after jumping to a symbol (false will disable)
    post_jump_cmd = "normal! zz",

    -- Invoked after each symbol is parsed
    post_parse_symbol = function(bufnr, item, ctx)
      return true
    end,

    -- Zig comptime field annotation parser
    -- Use //~Field: name: Type comments inside comptime type-generating functions
    post_add_all_symbols = function(bufnr, items, ctx)
      local ft = vim.bo[bufnr].filetype
      if ft ~= "zig" then
        return items
      end

      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      local field_pattern = "^%s*//~Field:%s*([%w_]+):%s*(.+)%s*$"

      -- Collect field annotations with line numbers
      local field_annotations = {}
      for lnum, line in ipairs(lines) do
        local name, field_type = line:match(field_pattern)
        if name then
          table.insert(field_annotations, {
            lnum = lnum,
            name = name,
            field_type = field_type:gsub("%s+$", ""),
          })
        end
      end

      if #field_annotations == 0 then
        return items
      end

      -- Find parent function for a line number
      local function find_parent_function(items_list, lnum)
        for _, item in ipairs(items_list) do
          if item.lnum <= lnum and item.end_lnum and item.end_lnum >= lnum then
            if item.kind == "Function" then
              if item.children then
                local child_match = find_parent_function(item.children, lnum)
                if child_match then return child_match end
              end
              return item
            end
            if item.children then
              local child_match = find_parent_function(item.children, lnum)
              if child_match then return child_match end
            end
          end
        end
        return nil
      end

      -- Group fields by parent function
      local fields_by_parent = {}
      for _, field in ipairs(field_annotations) do
        local parent = find_parent_function(items, field.lnum)
        if parent then
          fields_by_parent[parent] = fields_by_parent[parent] or {}
          table.insert(fields_by_parent[parent], field)
        end
      end

      -- Inject field symbols as children
      for parent, fields in pairs(fields_by_parent) do
        parent.children = parent.children or {}
        for _, field in ipairs(fields) do
          table.insert(parent.children, {
            kind = "Field",
            name = field.name .. ": " .. field.field_type,
            level = (parent.level or 0) + 1,
            lnum = field.lnum,
            end_lnum = field.lnum,
            col = 0,
            end_col = #lines[field.lnum],
            parent = parent,
          })
        end
        table.sort(parent.children, function(a, b) return a.lnum < b.lnum end)
      end

      return items
    end,

    -- When true, aerial will automatically close after jumping to a symbol
    close_on_select = false,

    -- The autocmds that trigger symbols update (not used for LSP backend)
    update_events = "TextChanged,InsertLeave",

    -- Show box drawing characters for the tree hierarchy
    show_guides = false,

    -- Customize the characters used when show_guides = true
    guides = {
      mid_item = "├─",
      last_item = "└─",
      nested_top = "│ ",
      whitespace = "  ",
    },

    -- Options for opening aerial in a floating win
    float = {
      border = "rounded",
      relative = "cursor",
      max_height = 0.9,
      height = nil,
      min_height = { 8, 0.1 },
      override = function(conf, source_winid)
        return conf
      end,
    },

    -- Options for the floating nav windows
    nav = {
      border = "rounded",
      max_height = 0.9,
      min_height = { 10, 0.1 },
      max_width = 0.5,
      min_width = { 0.2, 20 },
      win_opts = {
        cursorline = true,
        winblend = 10,
      },
      autojump = false,
      preview = false,
      keymaps = {
        ["<CR>"] = "actions.jump",
        ["<2-LeftMouse>"] = "actions.jump",
        ["<C-v>"] = "actions.jump_vsplit",
        ["<C-s>"] = "actions.jump_split",
        ["h"] = "actions.left",
        ["l"] = "actions.right",
        ["<C-c>"] = "actions.close",
      },
    },

    lsp = {
      diagnostics_trigger_update = true,
      update_when_errors = true,
      update_delay = 300,
      priority = {
        pyright = 10,
      },
    },

    treesitter = {
      update_delay = 300,
    },

    markdown = {
      update_delay = 300,
    },

    asciidoc = {
      update_delay = 300,
    },

    man = {
      update_delay = 300,
    },
  },
  keys = {
    { "<leader>oo", "<cmd>AerialToggle!<CR>", desc = "Toggle Aerial outline" },
    { "<leader>or", function() require("aerial").refetch_symbols() end, desc = "Refresh Aerial outline" },
  },
}

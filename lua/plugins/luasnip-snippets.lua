-- ~/.config/nvim/lua/plugins/luasnip-snippets.lua
return {
  "L3MON4D3/LuaSnip",
  opts = {
    -- load custom snippets from `~/.config/nvim/lua/snippets`
    load_ft_func = function(_, ft_paths)
      table.insert(ft_paths, "~/.config/nvim/lua/snippets")
    end,
  },
}

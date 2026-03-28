return {
  'nvim-treesitter/nvim-treesitter-textobjects',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    vim.keymap.set({ 'n', 'v', 'o' }, ']]', function()
      require('nvim-treesitter-textobjects.move').goto_next_end('@function.outer', 'textobjects')
    end, { desc = 'Jump to end of next function' })

    vim.keymap.set({ 'n', 'v', 'o' }, '[[', function()
      require('nvim-treesitter-textobjects.move').goto_previous_end('@function.outer', 'textobjects')
    end, { desc = 'Jump to end of previous function' })
  end,
}

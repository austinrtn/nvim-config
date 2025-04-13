vim.opt.relativenumber = true
vim.opt.number = true


vim.keymap.set("n", "<A-z><A-m>", ":ZenMode<CR>", { desc = "Toggle ZenMode", silent = true })
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Now load plugins (assuming you keep them in lua/plugins)
require("lazy").setup("plugins")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load your plugin specs from lua/plugins/
require("lazy").setup("plugins")

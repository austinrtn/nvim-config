return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      print(">>> zls config loaded")
      require("lspconfig").zls.setup({
        cmd = { "zls" },
        filetypes = { "zig" },
        root_dir = require("lspconfig.util").root_pattern("build.zig", ".git", "."),
      })
    end,
  },
}

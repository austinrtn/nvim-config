return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      print(">>> zls config loaded")

      -- Get navic if available
      local navic_ok, navic = pcall(require, "nvim-navic")

      require("lspconfig").zls.setup({
        cmd = { "zls" },
        filetypes = { "zig" },
        root_dir = require("lspconfig.util").root_pattern("build.zig", ".git", "."),
        on_attach = function(client, bufnr)
          -- Attach navic if available and client supports documentSymbols
          if navic_ok and client.server_capabilities.documentSymbolProvider then
            navic.attach(client, bufnr)
          end
          -- Note: Aerial attaches automatically via its LSP backend configuration
        end,
      })
    end,
  },
}

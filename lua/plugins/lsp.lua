return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")
    local util = require("lspconfig.util")
    local navic_ok, navic = pcall(require, "nvim-navic")

    local function on_attach(client, bufnr)
      if navic_ok and client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end
    end

    -- Zig
    lspconfig.zls.setup({
      cmd = { "zls" },
      filetypes = { "zig" },
      root_dir = util.root_pattern("build.zig", ".git", "."),
      on_attach = on_attach,
    })

    -- JavaScript / TypeScript
    lspconfig.ts_ls.setup({
      cmd = { "typescript-language-server", "--stdio" },
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
      on_attach = on_attach,
    })

    -- HTML
    lspconfig.html.setup({
      cmd = { "vscode-html-language-server", "--stdio" },
      filetypes = { "html" },
      on_attach = on_attach,
    })

    -- Go
    lspconfig.gopls.setup({
      cmd = { "gopls" },
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      root_dir = util.root_pattern("go.work", "go.mod", ".git"),
      on_attach = on_attach,
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
        },
      },
    })
  end,
}

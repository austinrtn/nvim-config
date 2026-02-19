-- ~/.config/nvim/lua/snippets/html.lua

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s("doc", fmt([[
<!DOCTYPE html>
<html lang="{}">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{}</title>
</head>
<body>
  {}
</body>
</html>]], {
    i(1, "en"),
    i(2, "Document"),
    i(3, ""),
  })),
}

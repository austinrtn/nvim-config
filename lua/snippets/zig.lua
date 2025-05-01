
-- ~/.config/nvim/lua/snippets/zig.lua

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s("print", fmt('std.debug.print("{}\\n", .{{}});', { i(1, "value") })),
  s("fori", fmt("for ({}..{}) |{}| {{\n  {}\n}}", {
    i(1, "start"),
    i(2, "end"),
    i(3, "i"),
    i(4, "-- body"),
  })),
}

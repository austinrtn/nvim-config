
-- ~/.config/nvim/lua/snippets/zig.lua

local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s("std", fmt('const std = @import("std");', {})),
  s("gpa", fmt([[var gpa = std.heap.GeneralPurposeAllocator(.{{}}){{}};
const allocator = gpa.allocator();
defer _ = gpa.deinit();]], {})),
  s("print", fmt('std.debug.print("{}\\n", .{{}});', { i(1, "value") })),
  s("fori", fmt("for ({}..{}) |{}| {{\n  {}\n}}", {
    i(1, "start"),
    i(2, "end"),
    i(3, "i"),
    i(4, "-- body"),
  })),
  s("structfield", fmt('std.builtin.Type.StructField', {})),
}

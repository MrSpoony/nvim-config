local utils = require("kl.snips")
local ls = require("luasnip")
local s = utils.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
local lambda = require("luasnip.extras").l

local ts_locals = require("nvim-treesitter.locals")
local get_node_text = vim.treesitter.get_node_text

local b = utils.b
local w = utils.w
local rep = utils.rep


ls.add_snippets("go", {
    b("efi", {
        t { "if err != nil {", "\t" },
        i(0),
        t { "", "}" },
    }),
})

ls.add_snippets("go", {
    b("fm", {
        t { "func main() {", "\t" },
        i(0),
        t { "", "}" },
    }),
})

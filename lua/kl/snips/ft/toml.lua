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

local b = utils.b
local rep = utils.rep

ls.add_snippets("toml", {
	b("spl", {
		"[sample.", i(1, "01"), "]",
		t({ "", 'input="""', "" }),
		i(2, ""),
		t({ "", '"""', 'output="""', "" }),
		i(3, ""),
		t({ "", '"""', "" }),
	}),
}, { type = "autosnippets" })

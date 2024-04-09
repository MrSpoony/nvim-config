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
local partial = require("luasnip.extras").partial

local b = utils.b
local rep = utils.rep

ls.add_snippets("all", {}, { type = "autosnippets" })

ls.add_snippets("all", {
	s("time", partial(vim.fn.strftime, "%H:%M:%S")),
	s("date", partial(vim.fn.strftime, "%Y-%m-%d")),
	s("datetime", partial(vim.fn.strftime, "%Y-%m-%d %H:%M:%S")),
})

local utils = require("snips")
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

local ts_utils = require("nvim-treesitter.ts_utils")

local b = utils.b
local rep = utils.rep;

local function getNodes(root)
    local results = {}
    for node, field in root:iter_children() do
        local node_entry
        node_entry = {
            node = node,
            field = field,
        }
        table.insert(results, node_entry)
    end
    return results
end

local function getAllNodes(root, lvl)
    local result = {}
    lvl = lvl or 0
    for node, field in root:iter_children() do
        local curr_node = {}
        curr_node = {
            children = getAllNodes(node, lvl+1) == {} and nil or getAllNodes(node, lvl+1),
            node = node,
            field = field,
            s = node:start(),
            e = node:end_(),
            type = node:type(),
        }
        table.insert(result, curr_node)
    end
    return result
end

local function getIdentifierText(nodes)
        local identifierNode
        for _, value in pairs(nodes) do
            if (value.node:type() == "type_identifier") then
                identifierNode = value.node
            end
        end
        local srow, scol = identifierNode:start()
        local erow, ecol = identifierNode:end_()
        P(srow, scol, erow, ecol)
        return vim.api.nvim_buf_get_text(0, srow, scol, erow, ecol, {})
end

local function getRootNodes()
    local parser = vim.treesitter.get_parser(0)
    local tstree = parser:parse()
    local root = tstree[1]:root()
    return getNodes(root)
end

local getLongLongTypeDef = function()
    local rootNodes = getRootNodes()
    for _, v in pairs(rootNodes) do
        if v.node:type() ~= "type_definition" then goto continueLL end
        local nodes = getAllNodes(v.node)
        if nodes[1].type ~= "typedef" then goto continueLL end
        local identifierText = getIdentifierText(nodes)
        local numLongs = 0
        for _, value in pairs(nodes[2].children) do
            if value.type == "long" then numLongs = numLongs + 1 end
        end
        if numLongs == 2 then return identifierText end
        ::continueLL::
    end
    return "long long int"
end

local getLongLongAlias = function()
    local rootNodes = getRootNodes()
    for _, v in pairs(rootNodes) do
        if v.node:type() ~= "alias_declaration" then goto continueLL end
        local nodes = getAllNodes(v.node)
        P(nodes)
        if nodes[1].type ~= "using" then goto continueLL end
        local identifierText = getIdentifierText(nodes)
        P(identifierText)
        if nodes[4].type == "type_descriptor" and
            nodes[4].children[1].type == "long" and
            nodes[4].children[2].type == "long" and
            nodes[4].children[3].type == "primitive_type"
        or
            nodes[4].type == "type_descriptor" and
            nodes[4].children[1].type == "long" and
            nodes[4].children[2].type == "long" then
            goto continueLL
        else
            return identifierText[1]
        end
        ::continueLL::
    end
    return "long long int"
end

local getLongLong = function()
    local typedef = getLongLongTypeDef()
    if typedef ~= "long long int" then return typedef end
    local alias = getLongLongAlias()
    if alias ~= "long long int" then return alias end
    return "long long int"
end

local getVectorLongLongTypeDef = function()
    return "VI";
end

local splitVariables = function(index)
    return f(function(arg)
        return string.gsub(arg[1][1], ",%s*", " >> ")
    end, { index })
end

ls.add_snippets("cpp", {
    b("lcin", {
        f(getLongLong), " ", i(1, "name"), "; cin >> ", splitVariables(1), t { ";", "" },
    }),
    b("vlcin", {
        f(getVectorLongLongTypeDef), " ", i(1, "name"), "(", i(2, "n"),
        "); cin >> ", rep(1), t { ";", "" }
    }),
    b("scin", {
        "string ", i(1, "name"), "; cin >> ", rep(1), t { ";", "" },
    }),
}, { type = "autosnippets" })

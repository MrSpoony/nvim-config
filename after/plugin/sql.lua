local run_formatter = function(text)
	local split = vim.split(text, "\n")
	table.insert(split, "\n")
	local result = table.concat(vim.list_slice(split, 2, #split - 1), "\n")

	local j = require("plenary.job"):new({
		command = "pg_format",
		args = { "--tabs" },
		writer = { result },
	})
	return j:sync()
end

local embedded_sql = vim.treesitter.parse_query(
	"go",
	[[
(
  (raw_string_literal) @sql
  (#contains? @sql "-- sql" "--sql" "ADD" "ADD CONSTRAINT" "ALL" "ALTER" "AND" "ASC" "COLUMN" "CONSTRAINT" "CREATE" "DATABASE" "DELETE" "DESC" "DISTINCT" "DROP" "EXISTS" "FOREIGN KEY" "FROM" "JOIN" "GROUP BY" "HAVING" "IN" "INDEX" "INSERT INTO" "LIKE" "LIMIT" "NOT" "NOT NULL" "OR" "ORDER BY" "PRIMARY KEY" "SELECT" "SET" "TABLE" "TRUNCATE TABLE" "UNION" "UNIQUE" "UPDATE" "VALUES" "WHERE")
  (#offset! @sql 0 1 0 -1)
)
(
  (interpreted_string_literal) @sql
  (#contains? @sql "-- sql" "--sql" "ADD" "ADD CONSTRAINT" "ALL" "ALTER" "AND" "ASC" "COLUMN" "CONSTRAINT" "CREATE" "DATABASE" "DELETE" "DESC" "DISTINCT" "DROP" "EXISTS" "FOREIGN KEY" "FROM" "JOIN" "GROUP BY" "HAVING" "IN" "INDEX" "INSERT INTO" "LIKE" "LIMIT" "NOT" "NOT NULL" "OR" "ORDER BY" "PRIMARY KEY" "SELECT" "SET" "TABLE" "TRUNCATE TABLE" "UNION" "UNIQUE" "UPDATE" "VALUES" "WHERE")
  (#offset! @sql 0 1 0 -1)
)
(
  (const_spec
    name: (identifier) @_id
    value: (expression_list (raw_string_literal) @sql)
  )
  (#contains? @_id "Query")
  (#offset! @sql 0 1 0 -1)
)
]]
)

local get_root = function(bufnr)
	local parser = vim.treesitter.get_parser(bufnr, "go", {})
	local tree = parser:parse()[1]
	return tree:root()
end

local format_sql = function()
	local bufnr = vim.api.nvim_get_current_buf()

	local root = get_root(bufnr)

	local changes = {}
	for id, node in embedded_sql:iter_captures(root, bufnr, 0, -1) do
		local name = embedded_sql.captures[id]
		if name == "sql" then
			-- { start row, start col, end row, end col }
			local range = { node:range() }
			local text = vim.treesitter.get_node_text(node, bufnr)
			text = text:gsub("^`", ""):gsub("`$", "")
			text = text:gsub("^'", ""):gsub("'$", "")
			text = text:gsub('^"', ""):gsub('"$', "")

			-- local indentation = string.rep(" ", range[2])

			-- Run the formatter, based on the node text
			-- P(text)
			local formatted = run_formatter(text)
			-- P(formatted)

			-- Add some indentation (can be anything you like!)
			-- for idx, line in ipairs(formatted) do
			--   formatted[idx] = indentation .. line
			-- end

			-- Keep track of changes
			--    But insert them in reverse order of the file,
			--    so that when we make modifications, we don't have
			--    any out of date line numbers
			table.insert(changes, 1, {
				start = range[1] + 1,
				final = range[3],
				formatted = formatted,
			})
		end
	end

	-- Apply the changes
	for _, change in ipairs(changes) do
		if change.start < change.final then
			vim.api.nvim_buf_set_lines(bufnr, change.start, change.final, false, change.formatted)
		end
	end
end

vim.api.nvim_create_user_command("FormatSql", format_sql, {})

-- vim.api.nvim_create_autocmd("BufWritePre", {
--     pattern = "*.go",
--     callback = function()
--         format_sql()
--     end,
-- })
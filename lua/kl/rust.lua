local utils = require("kl.utils")

local embedded_sql = vim.treesitter.query.parse(
  "rust",
  [[
(macro_invocation
  macro: (identifier) @macro (#any-of? @macro "query" "query_as")
  (token_tree
    (raw_string_literal) @sql))
]]
)

local run_formatter = function(text)
  local bin = vim.api.nvim_get_runtime_file("scripts/format_sql.py", false)[1]

  local j = require("plenary.job"):new {
    command = "python3",
    args = { bin },
    writer = { text },
  }
  return j:sync()
end

local format_sql = function(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  if vim.bo[bufnr].filetype ~= "rust" then
    vim.notify "can only be used in rust"
    return
  end

  local root = utils.get_root(bufnr, "rust")

  local changes = {}
  for id, node in embedded_sql:iter_captures(root, bufnr, 0, -1) do
    local name = embedded_sql.captures[id]
    if name == "sql" then
      -- { start row, start col, end row, end col }
      local range = { node:range() }
      local indentation = string.rep(" ", range[2])

      -- Run the formatter, based on the node text
      local text = vim.treesitter.get_node_text(node, bufnr)
      local inner_text = string.sub(text, 4, -3)
      local formatted = run_formatter(inner_text)

      -- Add some indentation (can be anything you like!)
      for idx, line in ipairs(formatted) do
        formatted[idx] = indentation .. line
      end


      local lines = vim.api.nvim_buf_get_lines(bufnr, range[1], range[3] + 1, true);
      local start_line = string.sub(lines[1], 0, range[2] + 3);
      local end_line = indentation .. string.sub(lines[#lines], range[4]-1, -1);
      -- print(start_line, end_line);
      table.insert(formatted, 1, start_line)
      table.insert(formatted, end_line)

      -- Keep track of changes
      --    But insert them in reverse order of the file,
      --    so that when we make modifications, we don't have
      --    any out of date line numbers
      table.insert(changes, 1, {
        start = range[1],
        final = range[3]+1,
        formatted = formatted,
      })
    end
  end

  for _, change in ipairs(changes) do
    vim.api.nvim_buf_set_lines(bufnr, change.start, change.final, false, change.formatted)
  end
end

vim.api.nvim_create_user_command("SqlMagic", function()
  format_sql()
end, {})

local group = vim.api.nvim_create_augroup("rust-sql-magic", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  pattern = "*.rs",
  callback = function()
    format_sql()
  end,
})

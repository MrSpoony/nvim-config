local lspconfigs = require("kl.lspconfigs")
local utils = require("kl.utils")
local json = require("kl.utils.json")
local notify = require("notify")

local opts = lspconfigs.options

opts.highlight_hovered_item = nil

local test_funcs = vim.treesitter.query.parse(
	"go",
	[[
(function_declaration
  name: (identifier) @func_name (#match? @func_name "^Test.*$")
) @func
]]
)

local close_if_valid = function(win_id)
	vim.schedule(function()
		if vim.api.nvim_win_is_valid(win_id) then
			vim.api.nvim_win_close(win_id, true)
		end
	end)
end

local run_tests = function(func_name)
	local test_outputs = {}
	local test_results = {}
	local test_notification_window_ids = {}

	require("plenary.job"):new({
		command = "go",
		args = { "test", "-run", func_name, "./...", "-json" },
		on_stdout = function(_, data)
			if not data or data == "" then return end
			local line = data
			if not line or line == "" then return end
			local obj = json.parse(line)
			if not obj then return end

			local action = obj.Action
			local test = obj.Test
			if not test or test == "" then return end

			if action == "start" then
				return
			elseif action == "run" then
				local msg = "Running " .. test
				vim.schedule(function()
					notify(msg, "info", {
						on_open = function(id)
							test_notification_window_ids[test] = id
						end
					})
				end)
			elseif action == "output" then
				if test_outputs[test] == nil then
					test_outputs[test] = { obj.Output }
				else
					table.insert(test_outputs[test], obj.Output)
				end
			elseif action == "pause" then
				return
			elseif action == "cont" then
				return
			elseif action == "pass" then
				test_results[test] = "pass"
			elseif action == "fail" then
				test_results[test] = "fail"
			end
		end,
		on_exit = function()
			vim.schedule(function()
				for k, v in pairs(test_results) do
					if v == "pass" and k == func_name then
						if test_notification_window_ids[k] then
							vim.schedule(function()
								close_if_valid(test_notification_window_ids[k])
								local msg = func_name .. " passed!"
								notify(msg, "info", { timeout = 5000 })
							end)
						else
							vim.print("what the fuck: " .. k)
						end
					elseif v == "pass" then
						if test_notification_window_ids[k] then
							close_if_valid(test_notification_window_ids[k])
						else
							vim.print("what the fuck: " .. k)
						end
					elseif v == "fail" then
						local msg = "\nTest output:\n" .. table.concat(test_outputs[k], "")
						if test_notification_window_ids[k] then
							vim.schedule(function()
								close_if_valid(test_notification_window_ids[k])
								notify(msg, "error", { title = k .. " failed" })
							end)
						else
							vim.schedule(function()
								notify(msg, "error", { title = k .. " failed" })
							end)
						end
					end
				end
			end)
		end
	}):start()
end

local test_current_func = function(bufnr)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	if vim.bo[bufnr].filetype ~= "go" then
		notify("can only be used in go")
		return
	end

	local root = utils.get_root(bufnr, "go")

	for id, node in test_funcs:iter_captures(root, bufnr, 0, -1) do
		local name = test_funcs.captures[id]
		if name ~= "func" then goto continue end
		local range = { node:range() }
		if range[1] > vim.fn.line(".") or range[3] < vim.fn.line(".") then
			goto continue
		end

		local func_name = ""

		for child, child_name in node:iter_children() do
			if child_name == "name" then
				func_name = vim.treesitter.get_node_text(child, bufnr)
			end
		end

		if func_name ~= "" then
			run_tests(func_name)
		end

		::continue::
	end
end


vim.api.nvim_create_user_command("GoTest", function()
	test_current_func()
end, {})

Nnoremap("<leader>tf", function() test_current_func() end)

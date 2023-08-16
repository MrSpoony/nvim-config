local lspconfigs = require("kl.lspconfigs")
local opts = lspconfigs.options

opts.highlight_hovered_item = nil
opts.show_guides = nil

vim.api.nvim_create_autocmd({ "BufNewFile" }, {
	pattern = "*.go",
	callback = function()
		local dir = vim.fn.expand("%:p:h")
		dir = dir:gsub(".*/", "")
		dir = "package " .. dir
		vim.fn.append(0, dir)
	end,
})
local api = require("nvim-tree.api")
local Event = require("nvim-tree.api").events.Event
api.events.subscribe(Event.FileCreated, function(data)
	if not data.fname:find(".go") then
		return
	end
	local dir = data.fname
	dir = dir:gsub("/[^/]*$", "")
	dir = dir:gsub(".*/", "")
	dir = "package " .. dir .. "\n"
	vim.fn.system('echo "' .. dir .. '" > ' .. data.fname)
end)

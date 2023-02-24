vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*",
	callback = function(details)
		if vim.fn.filereadable(details.file) == 1 then
			return
		end
		if details.file == "" then
			return
		end
		if vim.fn.isdirectory(details.file) then
			return
		end
		local possibles = {}
		for _, v in ipairs(vim.split(vim.fn.glob(details.file .. "*"), "\n")) do
			if v ~= "" then
				table.insert(possibles, v)
			end
		end
		if #possibles > 0 then
			vim.ui.select(possibles, {
				prompt = "Do I really have to help you again?!",
				format_item = function(item)
					local parts = vim.split(item, "/")
					return parts[#parts]
				end,
			}, function(choice)
				if choice then
					local empty_bufnr = vim.api.nvim_win_get_buf(0)
					vim.cmd.edit(vim.fn.fnameescape(choice))
					vim.api.nvim_buf_delete(empty_bufnr, {})
				end
			end)
		end
	end,
})

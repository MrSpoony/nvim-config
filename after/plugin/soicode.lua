-- vim.g.soicode_auto_insert_template = true
vim.g.soicode_no_clangdfile = true
-- vim.g.soicode_enable_all_cpp_files = true
-- vim.g.soicode_use_predefined_keybindings = true

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = "*.stoml",
	callback = function()
		vim.opt_local.ft = "toml"
	end,
})

Nnoremap("<leader>r1", function()
	vim.ui.select(vim.fn["soicode#ListOfSamples"](), { prompt = "Which sample to run?", }, function(choice) vim.cmd("SOIRunOneSample " .. choice) end)
end)

Nnoremap("<leader>ra", "<cmd>SOIRunAllSamples<CR>")
Nnoremap("<leader>ro", "<cmd>SOIRunWithOwnInput<CR>")
Nnoremap("<leader>st", "<cmd>SOIInsertTemplate<CR>")
Nnoremap("<leader>ct", "<cmd>SOICreateStoml<CR>")
Nnoremap("<leader>et", "<cmd>SOIEditStoml<CR>")

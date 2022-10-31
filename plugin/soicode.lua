vim.g.soicode_auto_insert_template = true
vim.g.soicode_no_clangdfile = true
vim.g.soicode_enable_all_cpp_files = true
vim.g.soicode_use_predefined_keybindings = true

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = "*.stoml",
	callback = function()
		vim.opt_local.ft = "toml"
	end
})

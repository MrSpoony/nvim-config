local o = vim.opt

o.clipboard = {} -- { 'unnamed', 'unnamedplus' }

o.encoding = "utf-8"

o.shiftwidth = 4
o.tabstop = 4
o.expandtab = true
o.autoindent = true
o.number = true
o.relativenumber = true
o.signcolumn = "yes"

o.textwidth = 0
o.wrap = true
o.linebreak = true
o.formatoptions:remove("cro")

o.modifiable = true
o.wildmenu = true
o.wildmode = { "longest:full", "full" }

o.showmode = false
o.ruler = true
o.showcmd = true
o.laststatus = 3

o.cmdheight = 1
o.incsearch = true
o.ignorecase = false
o.path:append("**")

o.hidden = true
o.showmatch = true
o.autoread = true
o.swapfile = false
o.updatetime = 100
o.backup = false
o.history = 10000
o.undofile = true

o.scrolloff = 8
o.cursorline = true
if vim.env.IS_ONLINE == "1" then
	o.cursorcolumn = true
end
o.mouse = "nvc"

o.visualbell = true

o.splitright = true
o.splitbelow = true

o.modifiable = true

o.background = "dark"
o.termguicolors = true

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

vim.g.omni_sql_no_default_maps = 1

vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Q", "q", {})

vim.api.nvim_create_user_command("Pi", "PackerInstall", {})
vim.api.nvim_create_user_command("Ps", "PackerSync", {})

vim.cmd([[
filetype plugin on
syntax on
]])

vim.api.nvim_create_autocmd({ "BufEnter" }, {
	callback = function()
		if o.ft._value == "go" then
			o.colorcolumn = "99"
			return
		end
		o.colorcolumn = "80"
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.java", "*.rs", "*.cpp", "*.c", "*.md" },
	callback = function()
		vim.lsp.buf.format()
	end,
})
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = "*.go",
	callback = function()
		local params = vim.lsp.util.make_range_params()
		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
		for _, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if (r.title == "Organize Imports" or r.title:find("Add import:")) and r.edit then
					vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
				end
			end
		end

		vim.lsp.buf.format()
	end
})

o.foldmethod = "manual"
o.fillchars = "fold: "
o.foldtext = "v:lua.foldText()"

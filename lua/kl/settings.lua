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
	pattern = { "*.go", "*.java", "*.rs", "*.cpp", "*.c" },
	callback = function()
		vim.lsp.buf.format()
	end,
})

local function toTabstop(str)
	return string.gsub(str, "\t", string.rep(" ", o.tabstop._value))
end

local function isOneLineReturnStatement(lines)
	if #lines ~= 3 then
		return false
	end
	return string.find(lines[1], "%s*.*{$") ~= nil
		and string.find(lines[2], "%s*return%s*.*$")
		and string.find(lines[3], "%s*}$")
end

local function foldTextDefault(first, last, lines)
	if string.find(first, "{%s*$") ~= nil and string.find(last, "}%s*$") then
		local linesText = "line"
		if lines - 2 ~= 1 then
			linesText = linesText .. "s"
		end
		return first .. " " .. lines - 2 .. " " .. linesText .. " hidden }"
	end
	return first .. " " .. lines - 1 .. " more lines"
end

function _G.foldText()
	local v = vim.v
	local lines = v.foldend - v.foldstart + 1
	local first = toTabstop(vim.fn.getline(v.foldstart))
	local last = toTabstop(vim.fn.getline(v.foldend))
	if lines ~= 3 then
		return foldTextDefault(first, last, lines)
	end
	local second = toTabstop(vim.fn.getline(v.foldstart + 1))
	if not isOneLineReturnStatement({ first, second, last }) then
		return foldTextDefault(first, last, lines)
	end
	local statement = string.match(first, "(%s*.*){$")
	local value = string.match(second, "%s*return%s*(.*)%s*$")
	return statement .. ": " .. value .. " ⤴"
end

local function findOneLineReturnOccurences()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)
	local occurences = {}
	for k, v in ipairs(lines) do
		if
			lines[k + 1] ~= nil
			and lines[k + 2] ~= nil
			and string.find(v, "%s*.*{$") ~= nil
			and string.find(lines[k + 1], "%s*return%s*.*$")
			and string.find(lines[k + 2], "%s*}$")
		then
			local occurence = string.match(lines[k + 1], "%s*return%s*(.*)$")
			table.insert(occurences, { k, occurence })
		end
	end
	return occurences
end

local function foldOneLineReturnOccurences()
	local occurences = findOneLineReturnOccurences()
	for _, v in ipairs(occurences) do
		local line = v[1]
		vim.cmd(line .. "," .. line + 2 .. "fold")
	end
end

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
	pattern = { "*.go", "*.java", "*.rs", "*.cpp", "*.c" },
	callback = foldOneLineReturnOccurences,
})

o.foldmethod = "manual"
o.fillchars = "fold: "
o.foldtext = "v:lua.foldText()"

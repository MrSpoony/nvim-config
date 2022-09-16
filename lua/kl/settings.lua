local o = vim.opt

o.clipboard = { 'unnamed', 'unnamedplus' }

o.encoding = 'utf-8'

o.shiftwidth = 4
o.tabstop = 4
o.expandtab = true
o.autoindent = true
o.number = true
o.relativenumber = true
o.signcolumn = 'yes'

o.textwidth = 0
o.wrap = true
o.linebreak = true
o.formatoptions:remove("cro")

o.modifiable = true
o.wildmenu = true
o.wildmode = { 'longest:full', 'full' }

o.showmode = false
o.ruler = true
o.showcmd = true
o.laststatus = 3

o.cmdheight = 1
o.incsearch = true
o.hlsearch = true
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
o.mouse = "nvc"

o.visualbell = true

o.splitright = true
o.splitbelow = true

o.modifiable = true

o.background = "dark"
o.termguicolors = true

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

vim.api.nvim_create_user_command("WQ", "wq", {})
vim.api.nvim_create_user_command("Wq", "wq", {})
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Q", "q", {})

vim.api.nvim_create_user_command("Pi", "PackerInstall", {})
vim.api.nvim_create_user_command("Ps", "PackerSync", {})
vim.api.nvim_create_user_command("G", function(data)
    local args = data.args
    if args ~= nil then
        vim.cmd("!git " .. args)
    end
end, {
    nargs = "*",
})

vim.cmd([[
filetype plugin on
syntax on
]])

vim.cmd([[
function! TrimEndLines()
    if &ft =~ 'go'
        return
    endif
    let save_cursor = getpos(".")
    %s/\s\+$//e
    call setpos('.', save_cursor)
endfunction
autocmd BufWritePre * call TrimEndLines()
]])

vim.api.nvim_create_autocmd({ "BufEnter" }, {
    callback = function()
        if o.ft._value == "go" then
            o.colorcolumn = '99'
            return
        end
        o.colorcolumn = '80'
    end
})

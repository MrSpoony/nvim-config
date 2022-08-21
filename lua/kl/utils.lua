local M = {}

local function createNoremap(mode)
    return function(lhs, rhs, options)
        options = options or {}
        options.noremap = true
        vim.keymap.set(mode, lhs, rhs, options)
    end
end

local function createMap(mode)
    return function(lhs, rhs, options)
        if type(lhs) == type(function() end) then
            lhs = M.luaFn(lhs)
        end
        options = options or {}
        options.noremap = false
        vim.api.nvim_set_keymap(mode, lhs, rhs, options)
    end
end

M.nnoremap = createNoremap("n")
M.xnoremap = createNoremap("x")
M.inoremap = createNoremap("i")
M.vnoremap = createNoremap("v")
M.tnoremap = createNoremap("t")
M.snoremap = createNoremap("s")
M.onoremap = createNoremap("o")
M.lnoremap = createNoremap("l")
M.cnoremap = createNoremap("c")
M.noremap = createNoremap("")

M.nmap = createMap("n")
M.xmap = createMap("x")
M.imap = createMap("i")
M.vmap = createMap("v")
M.tmap = createMap("t")
M.smap = createMap("s")
M.omap = createMap("o")
M.lmap = createMap("l")
M.cmap = createMap("c")
M.map = createMap("")

function M.fn(callback, ...)
    local args = {...}
    return function() callback(args) end
end

function M.command(name, command, options)
    options = options or {}
    vim.api.nvim_create_user_command(name, command, options)
end

function M.set_contains(set, val)
    for _, value in pairs(set) do
        if value == val then return true end
    end
    return false
end


return M

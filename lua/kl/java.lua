vim.api.nvim_create_autocmd({ "BufNewFile" }, {
    pattern = "*.java",
    callback = function()
        local dir = vim.fn.expand("%:p:h")
        dir = dir:gsub("^.*/com/", "com/")
        dir = dir:gsub("^.*/ch/", "ch/")
        dir = dir:gsub("/", ".")
        dir = "package " .. dir .. ";"
        local file = vim.fn.expand("%:t")
        file = file:gsub("%.java$", "")
        vim.fn.append(0, dir)
        vim.fn.append(1, "")
        vim.fn.append(2, "class " .. file .. " {")
        vim.fn.append(3, "")
        vim.fn.append(4, "}")
    end
})
local api = require('nvim-tree.api')
local Event = require('nvim-tree.api').events.Event
api.events.subscribe(Event.FileCreated, function(data)
    local dir = data.fname
    dir = dir:gsub("^.*/com/", "com/")
    dir = dir:gsub("^.*/ch/", "ch/")
    dir = dir:gsub("%.java$", "")
    dir = dir:gsub("/[^/]*$", "")
    dir = dir:gsub("/", ".")
    dir = "package " .. dir .. ";"
    local file = data.fname
    file = file:gsub("/.*/", "");
    file = file:gsub("%.java$", "")
    local everything = dir .. "\n" .. "\nclass " .. file .. " {\n"
    everything = everything .. "\n}"
    vim.fn.system("echo \"" .. everything .. "\" > " .. data.fname)
end)

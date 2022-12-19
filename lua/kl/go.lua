local go = require("go")

local lspconfigs = require("kl.lspconfigs")
local opts = lspconfigs.options

opts.highlight_hovered_item = nil
opts.show_guides = nil

go.setup({
    go = 'go', -- go command, can be go[default] or go1.18beta1
    goimport = 'gopls', -- goimport command, can be gopls[default] or goimport
    fillstruct = 'gopls', -- can be nil (use fillstruct, slower) and gopls
    gofmt = 'gofmt', --gofmt cmd,
    max_line_len = 120, -- max line length in goline format
    tag_transform = false, -- can be transform option("snakecase", "camelcase", etc) check gomodifytags for details and more options
    test_template = '', -- g:go_nvim_tests_template  check gotests for details
    test_template_dir = '', -- default to nil if not set; g:go_nvim_tests_template_dir  check gotests for details
    comment_placeholder = 'ﳑ', -- comment_placeholder your cool placeholder e.g. ﳑ       
    verbose = false, -- output loginf in messages
    lsp_cfg = opts,
    lsp_gofumpt = true, -- true: set default gofmt in gopls format to gofumpt
    lsp_on_attach = lspconfigs.on_attach,
    lsp_keymaps = false,
    lsp_codelens = false, -- set to false to disable codelens, true by default, you can use a function
    gopls_cmd = nil, -- Add own golps command
    dap_debug_keymap = false,
    dap_debug_gui = true, -- set to true to enable dap gui, highly recommand
    dap_debug_vt = true, -- set to true to enable dap virtual text
    -- build_tags = "tag1,tag2",
    textobjects = true,
    -- verbose_tests = false, -- set to add verbose flag to tests
    run_in_floaterm = true,
    -- luasnip = true,
})

vim.api.nvim_create_autocmd({
    "BufWritePre",
}, {
    pattern = "*.go",
    callback = function()
        local fmt = require("go.format")
        fmt.goimport()
    end
})

vim.api.nvim_create_autocmd({ "BufNewFile" }, {
    pattern = "*.go",
    callback = function()
        local dir = vim.fn.expand("%:p:h")
        dir = dir:gsub(".*/", "")
        dir = "package " .. dir
        vim.fn.append(0, dir)
    end
})
local api = require('nvim-tree.api')
local Event = require('nvim-tree.api').events.Event
api.events.subscribe(Event.FileCreated, function(data)
    if not data.fname:find(".go") then return end
    local dir = data.fname
    dir = dir:gsub("/[^/]*$", "")
    dir = dir:gsub(".*/", "")
    dir = "package " .. dir .. "\n"
    vim.fn.system("echo \"" .. dir .. "\" > " .. data.fname)
end)

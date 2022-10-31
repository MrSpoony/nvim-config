local lsp_installer = require("nvim-lsp-installer")
local clangd_extensions = require("clangd_extensions")
local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local copilot_cmp = require("copilot_cmp")
local copilot_suggestion = require("copilot.suggestion")
local lspconfigs = require("kl.lspconfigs")
local trouble = require("trouble")
local nullls = require("null-ls")
local ls = require("luasnip")

local options = lspconfigs.options
local on_attach = lspconfigs.on_attach

local lspsnips = {}

local clang_options = vim.deepcopy(options)
clang_options.on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    local orig_rpc_request = client.rpc.request
    function client.rpc.request(method, params, handler, ...)
        local orig_handler = handler
        if method == "textDocument/completion" then
            handler = function(...)
                local err, result = ...
                if not err and result then
                    local items = result.items or result
                    for _, item in ipairs(items) do
                        if item.kind == vim.lsp.protocol.CompletionItemKind.Field
                            and item.textEdit.newText:match("^[%w_]+%(${%d+:[%w_]+}%)$")
                        then
                            local s = ls.snippet
                            local r = ls.restore_node
                            local i = ls.insert_node
                            local t = ls.text_node
                            local c = ls.choice_node
                            local snip_text = item.textEdit.newText
                            local name = snip_text:match("^[%w_]+")
                            local type = snip_text:match("%{%d+:([%w_]+)%}")
                            lspsnips[snip_text] = s("", {
                                t(name),
                                c(1, {
                                    -- use a restoreNode to remember the text typed here.
                                    { t("("), r(1, "type", i(1, type)), t(")") },
                                    { t("{"), r(1, "type"), t("}") },
                                }, { restore_cursor = true }),
                            })
                        end
                    end
                end
                return orig_handler(...)
            end
        end
        return orig_rpc_request(method, params, handler, ...)
    end
end

clang_options.cmd = {
    "clangd",
    "-j=4",
    "--std=c++11",
    "--query-driver=/usr/bin/g*",
    "--background-index",
    "--clang-tidy",
    "--fallback-style=llvm",
    "--all-scopes-completion",
    "--completion-style=detailed",
    "--header-insertion=iwyu",
    "--header-insertion-decorators",
    "--pch-storage=memory",
}

-- clangd_extensions.setup({
--     server = clang_options
-- })

lsp_installer.on_server_ready(function(server)
    local opts = options
    if server.name == "gopls" then
        return
    end
    if server.name == "eslint" then
        opts.on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            client.server_capabilities.document_formatting = true
        end
        opts.settings = {
            format = { enable = true },
        }
    end
    server:setup(opts)
end)

-- local compare = cmp.config.compare

-- local tcode = function(str)
--     return vim.api.nvim_replace_termcodes(str, true, true, true)
-- end

local has_words_before = function()
    if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
        return false
    end
---@diagnostic disable-next-line: deprecated
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

copilot_cmp.setup()

cmp.setup({
    snippet = {
        expand = function(args)
            if lspsnips[args.body] then
                ls.snip_expand(lspsnips[args.body])
            else
                ls.lsp_expand(args.body)
            end
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    completion = {
        get_trigger_characters = function(trigger_characters)
            return vim.tbl_filter(function(char)
                return char ~= " "
            end, trigger_characters)
        end,
    },
    mapping = {
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-q>"] = cmp.mapping.close(),
        ["<C-i>"] = cmp.mapping(function()
            ls.expand_or_jump()
        end),
        ["<c-y>"] = cmp.mapping(
            cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
            }),
            { "i", "c" }
        ),
        ["<c-f>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<CR>"] = cmp.mapping({
            i = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            }),
            c = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            }),
        }),
        ["<c-space>"] = cmp.mapping({
            i = cmp.mapping.complete(),
            c = function()
                if cmp.visible() then
                    if not cmp.confirm({ select = true }) then
                        return
                    end
                else
                    cmp.complete()
                end
            end,
        }),
        -- Yes no tab completion here...
        -- ["<Tab>"] = cmp.mapping(function(fallback)
            -- fallback()
            -- if cmp.visible() and has_words_before() then
            --     cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            -- else
            --     fallback()
            -- end
        -- end),
        -- ["<S-Tab>"] = vim.schedule_wrap(function(fallback)
            -- fallback()
            -- if cmp.visible() and has_words_before() then
            --     cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            -- else
            --     fallback()
            -- end
        -- end),
        ["<C-n>"] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            elseif copilot_suggestion.is_visible() then
                copilot_suggestion.next()
            else
                fallback()
            end
        end),
        ["<C-p>"] = vim.schedule_wrap(function(fallback)
            if cmp.visible() and has_words_before() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
            elseif copilot_suggestion.is_visible() then
                copilot_suggestion.prev()
            else
                fallback()
            end
        end),
    },
    sources = {
        { name = "luasnip" },
        { name = "copilot" },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "nvim_lua" },
        { name = "buffer" },
    },
    sorting = {
        priority_weight = 2,
        comparators = {
            require("copilot_cmp.comparators").prioritize,
            require("copilot_cmp.comparators").score,

            -- Below is the default comparitor list and order for nvim-cmp
            cmp.config.compare.offset,
            -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
})

cmp.event:on(
    "confirm_done",
    cmp_autopairs.on_confirm_done({
        map_char = { tex = "" },
    })
)

cmp.setup.filetype("gitcommit", {
    source = cmp.config.sources({
        { name = "cmp_git" },
    }, {
        { name = "buffer" },
    }),
})

cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

-- Use cmdline & path source for ":" (if you enabled `native_menu`, this won"t work anymore).
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline", keyword_pattern = [=[[^[:blank:]\!]*]=], keyword_length = 3 },
    }),
})

trouble.setup({
    position = "bottom", -- position of the list can be: bottom, top, left, right
    height = 10, -- height of the trouble list when position is top or bottom
    width = 50, -- width of the list when position is left or right
    icons = true, -- use devicons for filenames
    mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
    fold_open = "", -- icon used for open folds
    fold_closed = "", -- icon used for closed folds
    group = true, -- group results by file
    padding = true, -- add an extra new line on top of the list
    action_keys = { -- key mappings for actions in the trouble list
        close = "q", -- close the list
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r", -- manually refresh
        jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
        open_split = { "<c-x>" }, -- open buffer in new split
        open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
        open_tab = { "<c-t>" }, -- open buffer in new tab
        jump_close = { "o" }, -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = "P", -- toggle auto_preview
        hover = "K", -- opens a small popup with the full multiline message
        preview = "p", -- preview the diagnostic location
        close_folds = { "zM", "zm" }, -- close all folds
        open_folds = { "zR", "zr" }, -- open all folds
        toggle_fold = { "zA", "za" }, -- toggle fold of current file
        previous = "k", -- preview item
        next = "j", -- next item
    },
    indent_lines = true, -- add an indent guide below the fold icons
    auto_open = false, -- automatically open the list when you have diagnostics
    auto_close = false, -- automatically close the list when you have no diagnostics
    auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = false, -- automatically fold a file trouble list at creation
    auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
    signs = {
        -- icons / text used for a diagnostic
        error = "",
        warning = "",
        hint = "",
        information = "",
        other = "﫠",
    },
    use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
})

Nnoremap("<leader>xx", "<cmd>Trouble<cr>")
Nnoremap("<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>")
Nnoremap("<leader>xd", "<cmd>Trouble document_diagnostics<cr>")
Nnoremap("<leader>xl", "<cmd>Trouble loclist<cr>")
Nnoremap("<leader>xq", "<cmd>Trouble quickfix<cr>")
Nnoremap("gR", "<cmd>Trouble lsp_references<cr>")

nullls.setup({
    sources = {
        nullls.builtins.formatting.stylua,
        nullls.builtins.formatting.prettier,
        nullls.builtins.diagnostics.eslint,
        nullls.builtins.completion.spell,
        nullls.builtins.code_actions.gitsigns,
    },
})

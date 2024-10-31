local status, lspconfig = pcall(require, "lspconfig")
if not status then
    return
end
local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local copilot_suggestion = require("copilot.suggestion")
local ls = require("luasnip")

local options = require("kl.lspconfigs").options

local lsp_servers = {
    lua_ls = {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                    disable = { "different-requires" },
                },
            },
        },
    },
    rust_analyzer = {
        settings = {
            ["rust-analyzer"] = {
                rustfmt = {
                    overrideCommand = { "leptosfmt", "--stdin", "--rustfmt" },
                    overrideSave = true,
                },
                checkOnSave = {
                    command = "clippy",
                },
            },
            cargo = {
                features = { "all" },
            },
        },
    },
    -- htmx = {},
    eslint = {
        settings = {
            format = { enable = true },
        },
    },
    ts_ls = {},
    angularls = {},
    gopls = {
        settings = {
            gopls = {
                analyses = {
                    unusedparams = true,
                },
                staticcheck = true,
                gofumpt = true,
            },
        },
    },
    templ = {},
    pyright = {},
    -- html = {},
    yamlls = {},
    jsonls = {},
    -- tailwindcss = {
    --     filetypes = { "html", "javascript", "typescript", "rust" },
    -- },
    clangd = {
        capabilities = { offsetEncoding = { "utf-16" } },
        cmd = {
            "clangd",
            "--background-index",
            "--enable-config",
        },
    },
    hls = {
        root_dir = vim.loop.cwd,
        settings = {
            rootMarkers = { "./git/" },
        },
    },
}

for server, config in pairs(lsp_servers) do
    lspconfig[server].setup(vim.tbl_deep_extend("force", options, config))
end

local compare = cmp.config.compare
cmp.setup({
    snippet = {
        expand = function(args)
            ls.lsp_expand(args.body)
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
        ["<C-i>"] = cmp.mapping(ls.expand_or_jump),
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
        ["<C-n>"] = vim.schedule_wrap(function(fallback)
            if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            elseif copilot_suggestion.is_visible() then
                copilot_suggestion.next()
            else
                fallback()
            end
        end),
        ["<C-p>"] = vim.schedule_wrap(function(fallback)
            if cmp.visible() then
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
        { name = "codeium" },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "nvim_lua" },
        { name = "buffer" },
    },
    sorting = {
        priority_weight = 2,
        comparators = {
            compare.offset,
            compare.exact,
            compare.score,
            compare.recently_used,
            compare.locality,
            compare.kind,
            compare.sort_text,
            compare.length,
            compare.order,
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

Nnoremap("<leader>xx", vim.cmd.Trouble)

local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.pg_format,
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.diagnostics.golangci_lint,
        null_ls.builtins.code_actions.refactoring,
        null_ls.builtins.code_actions.gitsigns,
    },
})

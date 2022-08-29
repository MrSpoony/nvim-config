local dressing = require("dressing")

dressing.setup({
    input = {
        enabled = true,
        insert_only = false,
    },
    select = {
        enabled = true,
        backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
        trim_prompt = true,
    },
})

vim.notify = require("notify")

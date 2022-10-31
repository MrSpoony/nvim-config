local copilot = require("copilot")
local suggestion = require("copilot.suggestion")

vim.defer_fn(function()
    copilot.setup({
        panel = {
            enabled = true,
            auto_refresh = true,
        },
        suggestion = {
            enabled = true,
            auto_trigger = true,
            debounce = 75,
        },
    })
end, 100)

Inoremap("<Right>", function()
    if suggestion.is_visible() then
        suggestion.accept()
    else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Right>", true, true, true), "n", true)
    end
end)

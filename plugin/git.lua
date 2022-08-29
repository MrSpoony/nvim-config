local gs = require('gitsigns');
local gc = require('git-conflict');

gc.setup({});

gs.setup({
    watch_gitdir = {
        interval = 500,
    },
    attach_to_untracked = true,
    current_line_blame = true,
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 1000,
        ignore_whitespace = false,
    },
    current_line_blame_formatter = ' ﳑ <author>, <author_time:%Y-%m-%d> - <summary>',
})
Nnoremap("<leader>ga", "<cmd>!git fetch --all<CR>")

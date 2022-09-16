local ts = require('telescope')
local builtin = require('telescope.builtin')

ts.setup {
    defaults = {
        sorting_strategy = "ascending",
        layout_config = {
            prompt_position = "top",
        },
        history = {
            path = '~/.local/share/nvim/databases/telescope_history.sqlite3',
            limit = 1000,
        },
        prompt_prefix = "  ",
        file_ignore_patterns = { "node_modules" },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
        },
    },
}

local le = ts.load_extension
le('fzf')
le('zoxide')
le('smart_history')
le('git_worktree')
le('harpoon')

local ex = ts.extensions
Nnoremap("<leader>cd", ex.zoxide.list)
Nnoremap("<leader>tt", builtin.find_files)
Nnoremap("<leader>td", ex.git_worktree.git_worktrees)
Nnoremap("<leader>tw", ex.git_worktree.create_git_worktree)
Nnoremap("<C-p>", builtin.git_files)
Nnoremap("<leader>ts", "<cmd>Telescope symbols<CR>")
Nnoremap("<leader>tc", builtin.colorscheme)
Nnoremap("<leader>tm", builtin.keymaps)
Nnoremap("<leader>tg", builtin.live_grep)
Nnoremap("<leader>th", builtin.help_tags)

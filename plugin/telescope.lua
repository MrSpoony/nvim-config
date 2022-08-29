local ts = require('telescope')
local builtin = require('telescope.builtin')
local themes = require("telescope.themes")
ts.setup {
    defaults = {
        sorting_strategy = "ascending",
        layout_config = {
            prompt_position = "top",
        },
        mappings = {
        },
        history = {
            path = '~/.local/share/nvim/databases/telescope_history.sqlite3',
            limit = 1000,
        }
    },
    pickers = {
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
        },
        arecibo = {
            ["selected_engine"]   = 'google',
            ["url_open_command"]  = 'xdg-open',
            ["show_http_headers"] = false,
            ["show_domain_icons"] = false,
        },
    }
}

local le = ts.load_extension
le('fzf')
le('zoxide')
le('smart_history')
le('git_worktree')
le('harpoon')

local ex = ts.extensions
Nnoremap("<leader>cd", ex.zoxide.list)
Nnoremap("<leader>ff", builtin.find_files)
Nnoremap("<leader>fd", ex.git_worktree.git_worktrees)
Nnoremap("<leader>fw", ex.git_worktree.create_git_worktree)
Nnoremap("<C-p>", builtin.git_files)
Nnoremap("<leader>fs", "<cmd>Telescope symbols<CR>")
Nnoremap("<leader>fc", builtin.colorscheme)
Nnoremap("<leader>fm", builtin.keymaps)
Nnoremap("<leader>fg", builtin.live_grep)
Nnoremap("<leader>fh", builtin.help_tags)

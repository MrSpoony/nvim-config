local ts = require("telescope")
local builtin = require("telescope.builtin")

ts.setup({
	defaults = {
		sorting_strategy = "ascending",
		layout_config = {
			prompt_position = "top",
		},
		file_ignore_patterns = { "node_modules" },
		theme = "ivy",
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
		},
		file_browser = {
			hijack_netrw = true,
		},
	},
})

local le = ts.load_extension
le("harpoon")
le("file_browser")

local ex = ts.extensions

Nnoremap("<leader>tt", builtin.find_files)
Nnoremap("<leader>tb", ex.file_browser.file_browser)
Nnoremap("<C-p>", builtin.git_files)
Nnoremap("<leader>tc", builtin.colorscheme)
Nnoremap("<leader>tm", builtin.keymaps)
Nnoremap("<leader>tg", builtin.live_grep)
Nnoremap("<leader>th", builtin.help_tags)

Nnoremap("gr", builtin.lsp_references)
Nnoremap("gi", builtin.lsp_implementations)
Nnoremap("gd", builtin.lsp_definitions)

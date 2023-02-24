local nvim_tree = require("nvim-tree")

nvim_tree.setup({
	renderer = {
		group_empty = true,
		highlight_opened_files = "icon",
		icons = {},
	},
	open_on_tab = false,
	update_cwd = true,
	diagnostics = {
		enable = true,
		show_on_dirs = false,
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
		update_root = true,
		ignore_list = {},
	},
	view = {
		adaptive_size = true,
		width = 40,
		side = "left",
	},
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
})

Nnoremap("<C-f>", "<cmd>Telescope file_browser<cr>")

local nvim_tree = require("nvim-tree")

nvim_tree.setup({
	renderer = {
		group_empty = true,
		highlight_opened_files = "icon",
		icons = {
			glyphs = {
				default = "",
				symlink = "",
				git = {
					unstaged = "",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					deleted = "",
					untracked = "★",
					ignored = "◌",
				},
			}
		}
	},
	disable_netrw = true,
	ignore_ft_on_setup = {
		"startify",
		"dashboard",
		"alpha",
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
		width = 35,
		height = 30,
		side = "left",
	},
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
})

Nnoremap("<C-f>", "<cmd>NvimTreeToggle<cr>")

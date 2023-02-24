local gs = require("gitsigns")

gs.setup({
	watch_gitdir = {
		interval = 500,
	},
	attach_to_untracked = true,
	current_line_blame = false,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol",
		delay = 1000,
		ignore_whitespace = false,
	},
	current_line_blame_formatter = " ﳑ <author>, <author_time:%Y-%m-%d> - <summary>",
})

Nnoremap("<leader>ga", "<cmd>!git fetch --all<CR>")
Noremap("<leader>gt", "<cmd>FloatermNew lazygit<CR>")

Nnoremap("]g", gs.next_hunk)
Nnoremap("[g", gs.prev_hunk)

local tmux = require("tmux")

tmux.setup({
	copy_sync = {
		enable = true,
		redirect_to_clipboard = true,
		sync_clipboard = true,
		sync_unnamed = true,
	},
	navigation = {
		cycle_navigation = true,
		enable_default_keybindings = true,
	},
	resize = {
		enable_default_keybindings = true,
	},
})

Nnoremap("<Up>", tmux.resize_top)
Nnoremap("<Down>", tmux.resize_bottom)
Nnoremap("<Left>", tmux.resize_left)
Nnoremap("<Right>", tmux.resize_right)

Nnoremap("<M-j>", tmux.resize_top)
Nnoremap("<M-k>", tmux.resize_bottom)
Nnoremap("<M-h>", tmux.resize_left)
Nnoremap("<M-l>", tmux.resize_right)

Nnoremap("∆", tmux.resize_top)
Nnoremap("˚", tmux.resize_bottom)
Nnoremap("˙", tmux.resize_left)
Nnoremap("¬", tmux.resize_right)

local sub = require("substitute")

sub.setup({
	highlight_substituted_text = {
		enabled = false,
		timer = 500,
	},
})

Nnoremap("s", sub.operator)
Nnoremap("ss", sub.line)
Nnoremap("S", sub.eol)
Xnoremap("s", sub.visual)

Nnoremap("<leader>s", Fn(sub.operator), { register = "+" })
Nnoremap("<leader>ss", Fn(sub.line), { register = "+" })
Nnoremap("<leader>S", Fn(sub.eol), { register = "+" })
Xnoremap("<leader>s", Fn(sub.visual), { register = "+" })

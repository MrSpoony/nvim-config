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

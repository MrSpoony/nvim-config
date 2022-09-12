local sub = require("substitute")

Nnoremap("s", sub.operator)
Nnoremap("ss", sub.line)
Nnoremap("S", sub.eol)
Xnoremap("s", sub.visual)

Nnoremap("gr", "<cmd>echom 'use `sw`'<cr>")
Xnoremap("gr", "<cmd>echom 'use `sw`'<cr>")

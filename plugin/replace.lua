local sub = require("substitute")

Nnoremap("s", sub.operator)
Nnoremap("ss", sub.line)
Nnoremap("S", sub.eol)
Xnoremap("s", sub.visual)

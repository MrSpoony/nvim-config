vim.g.vimtex_view_general_viewer = 'qpdfview'
vim.g.vimtex_view_general_options = '--unique @pdf\\#src:@tex:@line:@col'
-- vim.g.vimtex_view_general_options_latexmk = '--unique'

vim.g.tex_flavor='latex'
-- vim.g.vimtex_view_method='zathura'
vim.g.vimtex_quickfix_mode=0
vim.g.tex_conceal='abdmg'
vim.g.tex_conceal=''
-- Reduce stuff like \int{}{} to ∫ if set to 1
vim.opt.conceallevel=0
vim.cmd[[let maplocalleader=","]]

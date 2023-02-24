Nnoremap(",lp", "<Plug>MarkdownPreviewToggle")

-- set to 1, echo preview page url in command line when open preview page
-- default is 0
vim.g.mkdp_echo_preview_url = 1

-- use a custom markdown style must be absolute path
-- like '/Users/username/markdown.css' or expand('~/markdown.css')
-- let g:mkdp_markdown_css = expand("~/markdown.css")
vim.g.mkdp_markdown_css = ""

-- use a custom highlight style must absolute path
-- like '/Users/username/highlight.css' or expand('~/highlight.css')
vim.g.mkdp_highlight_css = ""

-- preview page title
-- ${name} will be replace with the file name
vim.g.mkdp_page_title = "「${name}」"

-- recognized filetypes
-- these filetypes will have MarkdownPreview... commands
vim.g.mkdp_filetypes = { "markdown" }

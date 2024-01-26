-- Nnoremap("j", "gj")
-- Nnoremap("k", "gk")
-- Nnoremap("gj", "j")
-- Nnoremap("gk", "k")

-- Vnoremap("j", "gj")
-- Vnoremap("k", "gk")
-- Vnoremap("gj", "j")
-- Vnoremap("gk", "k")

-- LSP stuff
local opts = { silent = true }
Nnoremap("<leader>df", vim.diagnostic.open_float, opts)
Nnoremap("[d", vim.diagnostic.goto_prev, opts)
Nnoremap("]d", vim.diagnostic.goto_next, opts)
Nnoremap("<leader>q", vim.diagnostic.setloclist, opts)

Nnoremap("gD", vim.lsp.buf.declaration, opts)
Nnoremap("K", vim.lsp.buf.hover, opts)
-- Nnoremap("<C-M>", vim.lsp.buf.signature_help, opts)
Nnoremap("<leader>D", vim.lsp.buf.type_definition, opts)
Nnoremap("<leader>rn", vim.lsp.buf.rename, opts)
Nnoremap("<leader>ca", vim.lsp.buf.code_action, opts)
Vnoremap("<leader>ca", vim.lsp.buf.code_action, opts)
Nnoremap("<m-CR>", vim.lsp.buf.code_action, opts)
Nnoremap("<a-CR>", vim.lsp.buf.code_action, opts)
Nnoremap("<leader>fo", vim.lsp.buf.format, opts)

-- don't add curly brace jumps to my jump list
Nnoremap("}", '<cmd>execute "keepjumps norm! " . v:count1 . "}"<CR>', { silent = true })
Nnoremap("{", '<cmd>execute "keepjumps norm! " . v:count1 . "{"<CR>', { silent = true })

-- Nnoremap("<Up>", "<cmd>resize +2<cr>")
-- Nnoremap("<Down>", "<cmd>resize -2<cr>")
-- Nnoremap("<Left>", "<cmd>vertical resize +2<cr>")
-- Nnoremap("<Right>", "<cmd>vertical resize -2<cr>")

-- I just want tab, nothing else
Inoremap("<Tab>", function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
end)

local function removeQFItem()
  local curqfidx = vim.fn.line('.') - 1
  local qfall = vim.fn.getqflist()
  vim.fn.remove(qfall, curqfidx)
  vim.fn.setqflist(qfall, 'r')
  vim.cmd('execute ' .. curqfidx .. ' + 1 . \"cfirst\"')
  vim.cmd [[ :copen ]]
end
vim.api.nvim_create_autocmd({"FileType"}, {
	pattern = { "qf" },
	callback = function()
		Nnoremap("dd", removeQFItem, { buffer = true })
	end,
})

Nnoremap("<buffer> <CR>", "<CR>")
-- Center cursor on search or scroll
Nnoremap("n", "nzzzv")
Nnoremap("N", "Nzzzv")
Nnoremap("<C-d>", "<C-d>zz")
Nnoremap("<C-u>", "<C-u>zz")
Nnoremap("<C-o>", "<C-o>zz")
Nnoremap("<C-i>", "<C-i>zz")
Nnoremap("''", "''zz")

Nnoremap("J", "mzJ`z")

Nnoremap("<Esc>", vim.cmd.noh)

Vnoremap("<M-Up>", "<cmd>'<,'>m '<-2<CR>gv=gv")
Vnoremap("<M-Down>", "<cmd>'<,'>m '>+1<CR>gv=gv")
Nnoremap("<M-Up>", "<cmd>m .-2<CR>==")
Nnoremap("<M-Down>", "<cmd>m .+1<CR>==")

-- copy and paste from their own registers
Nnoremap("<leader>p", '"+p')
Nnoremap("<leader>P", '"+P')
Vnoremap("<leader>p", '"+p')

Nnoremap("<leader>y", '"+y')
Nnoremap("<leader>Y", '"+y$')
Vnoremap("<leader>y", '"+y')

Nnoremap("<leader>w", "<cmd>noautocmd w<CR>")
Vnoremap("<leader>w", "<cmd>noautocmd w<CR>")

Nnoremap("<leader>+", "<cmd>vertical resize +5<CR>")
Nnoremap("<leader>-", "<cmd>vertical resize -5<CR>")

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*.lua", "*.vim" },
	callback = function()
		Nnoremap("<leader>so", "<cmd>w<CR><cmd>so %<CR>")
	end,
})

Nnoremap("<C-C>", vim.cmd.vsplit)
Nnoremap("<C-B>", vim.cmd.split)

Nnoremap("<leader>q", "<cmd>bdelete!<CR>")
Nnoremap("<leader>bq", "<cmd>quit!<CR>")
Nnoremap("<leader>bd", vim.cmd.bdelete)
Nnoremap("<leader>ba", "<cmd>quitall!<CR>")

Nnoremap("<leader>sp", "<cmd>sp<CR>")
Nnoremap("<leader>vp", "<cmd>vsp<CR>")

Nnoremap(":", ";")
Nnoremap(";", ":")
Vnoremap(":", ";")
Vnoremap(";", ":")

-- For mac remap F25-36 to F1-12
for i = 25, 36 do
	Nmap("<F" .. i .. ">", "<F" .. (i - 24) .. ">")
	Imap("<F" .. i .. ">", "<F" .. (i - 24) .. ">")
	Xmap("<F" .. i .. ">", "<F" .. (i - 24) .. ">")
end

for i = 1, 12 do
	Nmap("<C-F" .. i .. ">", "<F" .. i .. ">")
	Imap("<C-F" .. i .. ">", "<F" .. i .. ">")
	Xmap("<C-F" .. i .. ">", "<F" .. i .. ">")
end

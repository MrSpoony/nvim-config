Nnoremap("j", "gj")
Nnoremap("k", "gk")
Nnoremap("gj", "j")
Nnoremap("gk", "k")

Vnoremap("j", "gj")
Vnoremap("k", "gk")
Vnoremap("gj", "j")
Vnoremap("gk", "k")


Nnoremap("}", '<cmd>execute "keepjumps norm! " . v:count1 . "}"<CR>', { silent = true })
Nnoremap("{", '<cmd>execute "keepjumps norm! " . v:count1 . "{"<CR>', { silent = true })

-- Nnoremap("<Up>", "<cmd>resize +2<cr>")
-- Nnoremap("<Down>", "<cmd>resize -2<cr>")
-- Nnoremap("<Left>", "<cmd>vertical resize +2<cr>")
-- Nnoremap("<Right>", "<cmd>vertical resize -2<cr>")

-- Vnoremap("<Up>", "<Nop>")
-- Vnoremap("<Down>", "<Nop>")
-- Vnoremap("<Right>", "<Nop>")
-- Vnoremap("<Left>", "<Nop>")

Inoremap("<Tab>", function()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true)
end)

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

Vnoremap("<leader><Up>",   "<cmd>'<,'>m '>+1<CR>gv=gv")
Vnoremap("<leader><Down>", "<cmd>'<,'>m '<-2<CR>gv=gv")
Nnoremap("<leader><Up>",   "<cmd>m .+1<CR>==")
Nnoremap("<leader><Down>", "<cmd>m .-2<CR>==")

Nnoremap("<leader>p", "\"+p")
Nnoremap("<leader>P", "\"+P")
Nnoremap("<leader>y", "\"+y")
Nnoremap("<leader>Y", "\"+y$")

Nnoremap("<leader>+", "<cmd>vertical resize +5<CR>")
Nnoremap("<leader>-", "<cmd>vertical resize -5<CR>")

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {"*.lua", "*.vim"},
    callback = function() Nnoremap("<leader>so", "<cmd>w<CR><cmd>so %<CR>") end
})

Nnoremap("<C-C>", vim.cmd.vsplit)
Nnoremap("<C-B>", vim.cmd.split)

Nnoremap("<leader>q", "<cmd>bdelete!<CR>")
Nnoremap("<leader>bq", "<cmd>quit!<CR>")
Nnoremap("<leader>bd", vim.cmd.bdelete)
Nnoremap("<leader>ba", "<cmd>quitall!<CR>")

Nnoremap(":", ";")
Nnoremap(";", ":")
Vnoremap(":", ";")
Vnoremap(";", ":")

-- For mac remap F25-36 to F1-12
for i = 25,36 do
    vim.cmd("nmap " .. "<F" .. i .. "> <F" .. (i-24) .. ">")
    vim.cmd("imap " .. "<F" .. i .. "> <F" .. (i-24) .. ">")
    vim.cmd("xmap " .. "<F" .. i .. "> <F" .. (i-24) .. ">")
end

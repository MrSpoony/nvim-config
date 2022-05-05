Nnoremap("j", "gj")
Nnoremap("k", "gk")
Nnoremap("gj", "j")
Nnoremap("gk", "k")

Vnoremap("j", "gj")
Vnoremap("k", "gk")
Vnoremap("gj", "j")
Vnoremap("gk", "k")

Nnoremap("<Up>", "<cmd>resize +2<cr>")
Nnoremap("<Down>", "<cmd>resize -2<cr>")
Nnoremap("<Left>", "<cmd>vertical resize +2<cr>")
Nnoremap("<Right>", "<cmd>vertical resize -2<cr>")

Vnoremap("<Up>", "<Nop>")
Vnoremap("<Down>", "<Nop>")
Vnoremap("<Right>", "<Nop>")
Vnoremap("<Left>", "<Nop>")

Nnoremap("n", "nzzzv")
Nnoremap("N", "Nzzzv")

Nnoremap("J", "mzJ`z")

Nnoremap("<Esc>", "<cmd>noh<CR>")

Nnoremap("oo", "o<Esc>")
Nnoremap("OO", "O<Esc>")

Vnoremap("<A-j>", "<cmd>'<,'>m '>+1<CR>gv=gv")
Vnoremap("<A-k>", "<cmd>'<,'>m '<-2<CR>gv=gv")
Inoremap("<A-j>", "<cmd>m .+1<CR><Esc>==a")
Inoremap("<A-k>", "<cmd>m .-2<CR><Esc>==a")
Nnoremap("<A-j>", "<cmd>m .+1<CR>==")
Nnoremap("<A-k>", "<cmd>m .-2<CR>==")

Nnoremap("<leader>sp", function() vim.wo.spell = not vim.wo.spell end)

Nnoremap("<leader>+", "<cmd>vertical resize +5<CR>")
Nnoremap("<leader>-", "<cmd>vertical resize -5<CR>")

local source = function()
    Nnoremap("<leader>so", "<cmd>w<CR><cmd>so %<CR>")
end

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {"*.lua", "*.vim"},
    callback = source
})


Nnoremap("<leader>b", "<cmd>bdelete<CR>")
Nnoremap("<leader>qq", "<cmd>quit!<CR>")
Nnoremap("<leader>qw", "<cmd>wq<CR>")
Nnoremap("<leader>qaw", "<cmd>quitall!<CR>")
Nnoremap("<leader>qaa", "<cmd>wqall<CR>")

Nnoremap(":", ";")
Nnoremap(";", ":")
Vnoremap(":", ";")
Vnoremap(";", ":")

Command("Pi", "PackerInstall")
Command("Pu", "PackerUpdate")

vim.api.nvim_create_autocmd({ "BufReadpost", "BufNewFile" }, {
    pattern = "*.asm",
    callback = function() vim.opt_local.ft = "nasm" end
})

vim.api.nvim_create_autocmd("Filetype", {
    pattern = "nasm",
    callback = function()
        vim.opt_local.commentstring= ";\\ %s";
    end
})

vim.api.nvim_create_autocmd({ "DirChanged", "VimEnter"    }, {
    pattern = "*",
    callback = function()
        if vim.fn.globpath('.,..,../..,../../..', 'node_modules/@angular') ~= '' then
            vim.fn["angular_cli#init"]();
        end
    end
})

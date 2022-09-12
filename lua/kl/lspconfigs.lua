local utils = require("kl.utils")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local lspsignature = require("lsp_signature");

lspsignature.setup({});

local M = {}

local function set_default_formatter_for_filetypes(language_server_name, filetypes)
    if not utils.set_contains(filetypes, vim.bo.filetype) then return end

    local active_servers = {}

    vim.lsp.for_each_buffer_client(0, function(client)
        table.insert(active_servers, client.config.name)
    end)

    if not utils.set_contains(active_servers, language_server_name) then return end

    vim.lsp.for_each_buffer_client(0, function(client)
        if client.name ~= language_server_name then
            client.server_capabilities.document_formatting = false
            client.server_capabilities.document_range_formatting = false
        end
    end)
end

M.on_attach = function(client, bufnr)
    lspsignature.on_attach({
        bind = true,
        handler_opts = {
            border = "rounded"
        }
    }, bufnr);
    set_default_formatter_for_filetypes("gopls", { "go" })
    -- set_default_formatter_for_filetypes("eslint", { "javascript", "javascriptreact" })

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { silent = true }
    -- Diagnostics mappings
    Nnoremap('<leader>df', vim.diagnostic.open_float, opts)
    Nnoremap('[d', vim.diagnostic.goto_prev, opts)
    Nnoremap(']d', vim.diagnostic.goto_next, opts)
    Nnoremap('<leader>q', vim.diagnostic.setloclist, opts)

    Nnoremap('gD', vim.lsp.buf.declaration, opts)
    Nnoremap('gd', vim.lsp.buf.definition, opts)
    Nnoremap('K', vim.lsp.buf.hover, opts)
    Nnoremap('gi', vim.lsp.buf.implementation, opts)
    Nnoremap('<leader>gr', vim.lsp.buf.references, opts)
    Nnoremap('<C-M>', vim.lsp.buf.signature_help, opts)
    Nnoremap('<leader>D', vim.lsp.buf.type_definition, opts)
    Nnoremap('<leader>rn', vim.lsp.buf.rename, opts)
    Nnoremap('<leader>ca', vim.lsp.buf.code_action, opts)
    Vnoremap('<leader>ca', vim.lsp.buf.range_code_action, opts)
    Nnoremap('<m-CR>', vim.lsp.buf.code_action, opts)
    Nnoremap('<a-CR>', vim.lsp.buf.code_action, opts)
    Nnoremap('<leader>fo', function() vim.lsp.buf.format({}) end, opts)
end

local capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())

M.options = {
    on_attach = M.on_attach,
    highlight_hovered_item = true,
    show_guides = true,
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = capabilities
}

return M

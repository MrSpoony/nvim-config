local utils = require("kl.utils")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local lspsignature = require("lsp_signature")

lspsignature.setup({})

local M = {}

local function set_default_formatter_for_filetypes(language_server_name, filetypes)
	if not utils.set_contains(filetypes, vim.bo.filetype) then
		return
	end

	local active_servers = {}

	vim.lsp.for_each_buffer_client(0, function(client)
		table.insert(active_servers, client.config.name)
	end)

	if not utils.set_contains(active_servers, language_server_name) then
		return
	end

	vim.lsp.for_each_buffer_client(0, function(client)
		if client.name ~= language_server_name then
			client.server_capabilities.document_formatting = false
			client.server_capabilities.document_range_formatting = false
		end
	end)
end

M.on_attach = function(
	_, -- client
	bufnr
)
	lspsignature.on_attach({
		bind = true,
		handler_opts = {
			border = "rounded",
		},
	}, bufnr)

	set_default_formatter_for_filetypes("gopls", { "go" })

	set_default_formatter_for_filetypes("eslint", {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"js",
		"ts",
		"jsx",
		"tsx",
	})

	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

M.options = {
	on_attach = M.on_attach,
	highlight_hovered_item = true,
	show_guides = true,
	flags = {
		debounce_text_changes = 150,
	},
	capabilities = capabilities,
}

return M

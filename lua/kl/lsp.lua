local lspconfig = require("lspconfig")
local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
local copilot_suggestion = require("copilot.suggestion")
local ls = require("luasnip")

local options = require("kl.lspconfigs").options

require("mason-lspconfig").setup_handlers({
	function(server_name)
		local opts = vim.deepcopy(options)
		if server_name == "eslint" then
			opts.settings = {
				format = { enable = true },
			}
		elseif server_name == "gopls" then
			opts.settings = {
				gopls = {
					gofumpt = true,
				},
			}

			vim.api.nvim_create_autocmd({ "BufWritePre" }, {
				pattern = "*.go",
				callback = function()
					local params = vim.lsp.util.make_range_params()
					local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
					for _, res in pairs(result or {}) do
						for _, r in pairs(res.result or {}) do
							if (r.title == "Organize Imports" or r.title:find("Add import:")) and r.edit then
								vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
							end
						end
					end

					vim.lsp.buf.format()
				end
			})
		elseif server_name == "rust_analyzer" then
			opts.settings = {
				["rust-analyzer"] = {
					rustfmt = {
						overrideCommand = { "leptosfmt", "--stdin", "--rustfmt" },
						overrideSave = true,
					},
					checkOnSave = {
						command = "clippy",
					},
				},
			}
		elseif server_name == "clangd" then
			opts.capabilities.offsetEncoding = { "utf-16" }
			opts.cmd = {
				"clangd",
				"--background-index",
				"--enable-config",
			}
		end

		lspconfig[server_name].setup(opts)
	end,
})

local compare = cmp.config.compare
cmp.setup({
	snippet = {
		expand = function(args)
			ls.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	completion = {
		get_trigger_characters = function(trigger_characters)
			return vim.tbl_filter(function(char)
				return char ~= " "
			end, trigger_characters)
		end,
	},
	mapping = {
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-q>"] = cmp.mapping.close(),
		["<C-i>"] = cmp.mapping(ls.expand_or_jump),
		["<c-y>"] = cmp.mapping(
			cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			}),
			{ "i", "c" }
		),
		["<c-f>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<CR>"] = cmp.mapping({
			i = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			}),
			c = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			}),
		}),
		["<c-space>"] = cmp.mapping({
			i = cmp.mapping.complete(),
			c = function()
				if cmp.visible() then
					if not cmp.confirm({ select = true }) then
						return
					end
				else
					cmp.complete()
				end
			end,
		}),
		["<C-n>"] = vim.schedule_wrap(function(fallback)
			if cmp.visible() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			elseif copilot_suggestion.is_visible() then
				copilot_suggestion.next()
			else
				fallback()
			end
		end),
		["<C-p>"] = vim.schedule_wrap(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
			elseif copilot_suggestion.is_visible() then
				copilot_suggestion.prev()
			else
				fallback()
			end
		end),
	},
	sources = {
		{ name = "luasnip" },
		{ name = "copilot" },
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "nvim_lua" },
		{ name = "buffer" },
	},
	sorting = {
		priority_weight = 2,
		comparators = {
			compare.offset,
			compare.exact,
			compare.score,
			compare.recently_used,
			compare.locality,
			compare.kind,
			compare.sort_text,
			compare.length,
			compare.order,
		},
	},
})

cmp.event:on(
	"confirm_done",
	cmp_autopairs.on_confirm_done({
		map_char = { tex = "" },
	})
)

cmp.setup.filetype("gitcommit", {
	source = cmp.config.sources({
		{ name = "cmp_git" },
	}, {
		{ name = "buffer" },
	}),
})

cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ":" (if you enabled `native_menu`, this won"t work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline", keyword_pattern = [=[[^[:blank:]\!]*]=], keyword_length = 3 },
	}),
})

require("trouble").setup({
	position = "bottom", -- position of the list can be: bottom, top, left, right
	height = 10, -- height of the trouble list when position is top or bottom
	width = 50, -- width of the list when position is left or right
	icons = true, -- use devicons for filenames
	mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
	fold_open = "", -- icon used for open folds
	fold_closed = "", -- icon used for closed folds
	group = true, -- group results by file
	padding = true, -- add an extra new line on top of the list
	action_keys = { -- key mappings for actions in the trouble list
		close = "q", -- close the list
		cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
		refresh = "r", -- manually refresh
		jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
		open_split = { "<c-x>" }, -- open buffer in new split
		open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
		open_tab = { "<c-t>" }, -- open buffer in new tab
		jump_close = { "o" }, -- jump to the diagnostic and close the list
		toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
		toggle_preview = "P", -- toggle auto_preview
		hover = "K", -- opens a small popup with the full multiline message
		preview = "p", -- preview the diagnostic location
		close_folds = { "zM", "zm" }, -- close all folds
		open_folds = { "zR", "zr" }, -- open all folds
		toggle_fold = { "zA", "za" }, -- toggle fold of current file
		previous = "k", -- preview item
		next = "j", -- next item
	},
	indent_lines = true, -- add an indent guide below the fold icons
	auto_open = false, -- automatically open the list when you have diagnostics
	auto_close = false, -- automatically close the list when you have no diagnostics
	auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
	auto_fold = false, -- automatically fold a file trouble list at creation
	auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
	signs = {
		-- icons / text used for a diagnostic
		error = "",
		warning = "",
		hint = "",
		information = "",
		other = "﫠",
	},
	use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
})

Nnoremap("<leader>xx", vim.cmd.Trouble)

local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.pg_format,
		null_ls.builtins.formatting.goimports,
		null_ls.builtins.diagnostics.golangci_lint,
		null_ls.builtins.code_actions.refactoring,
		null_ls.builtins.code_actions.gitsigns,
	},
})

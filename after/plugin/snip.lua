local ls = require("luasnip")
local types = require("luasnip.util.types")

ls.config.set_config({
	history = true,
	updateevents = "TextChanged,TextChangedI",
	enable_autosnippets = true,
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { " 🞄" } },
			},
		},
	},
})

-- Load friendly snippets
require("luasnip.loaders.from_vscode").load({
	paths = vim.fn.stdpath("data") .. "/lazy/friendly-snippets/",
})

-- Load vscode snippets
require("luasnip.loaders.from_vscode").load({
	paths = "~/.config/nvim/lua/snips/lsp/ft",
})

local files = vim.fn.glob(vim.fn.stdpath("config") .. "/lua/kl/snips/ft/*.lua", false, true)
for _, ft_path in ipairs(files) do
	loadfile(ft_path)()
end

-- <c-e> is my expansion key
vim.keymap.set({ "i", "s" }, "<C-e>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })

-- <c-t> is my jump backwards key.
vim.keymap.set({ "i", "s" }, "<c-t>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

-- <c-s-e> is selecting within a list of options.
vim.keymap.set({ "i", "s", "n" }, "<c-s-e>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)

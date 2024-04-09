local colors = "gruvbox"

local nonicons_extention = require("nvim-nonicons.extentions.lualine")

-- Neovide
vim.g.neovide_refresh_rate = 300
-- vim.g.neovide_transparency=0.5
vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.g.neovide_cursor_animation_length = 0.08
vim.g.neovide_cursor_trail_length = 29.8
vim.g.neovide_cursor_vfx_particle_density = 50.0
vim.opt.guifont = "JetBrainsMono_Nerd_Font_Mono:h12"
-- vim.opt.guifont="Monoid_Nerd_Font_Mono:h7"
-- vim.opt.guifont="VictorMono_Nerd_Font_Mono:h8"
-- vim.opt.guifont="Inconsolata_Nerd_Font_Mono:h10"
-- vim.opt.guifont="Hack:h7"
-- vim.opt.guifont="Hack_Nerd_Font_Mono:h7.5"


vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})


require("notify").setup({
	icons = nonicons_extention.icons,
})

vim.notify = require("notify")


require("dressing").setup({
	input = {
		enabled = true,
		insert_only = false,
	},
	select = {
		enabled = true,
		backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
		trim_prompt = true,
	},
})

-- Colorscheme
function ColorIt(colorscheme)
	if colorscheme == "catppuccin" then
		vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
		vim.cmd.highlight("Folded guibg=#212231")
		vim.cmd.colorscheme("catppuccin")
		vim.cmd.highlight("Folded guibg=#212231")
	elseif colorscheme == "onedark" then
		require("onedark").setup({
			theme = "deep",
		})
		vim.cmd.colorscheme("onedark")
	elseif colorscheme == "gruvbox" then
		vim.g.gruvbox_material_better_performance = 1
		vim.g.gruvbox_material_foreground = "mix" -- material, mix, original
		vim.g.gruvbox_material_background = "medium" -- hard, medium, soft
		vim.cmd.colorscheme("gruvbox-material")
	elseif colorscheme == "tokyonight" then
		vim.g.tokyonight_style = "night"
		vim.cmd.colorscheme("tokyonight")
	elseif colorscheme == "neon" then
		vim.g.neon_style = "doom"
		vim.cmd.colorscheme("neon")
	elseif colorscheme == "material" then
		vim.g.material_style = "deep ocean" -- Oceanic, Deep Ocean, Palenight, Lighter, Darker
		require("material").setup({
			lualine_style = "stealth",
			italics = { comments = true },
		})
		vim.cmd.colorscheme("material")
	elseif colorscheme == "github" then
		require("github-theme").setup({})
		vim.cmd.colorscheme("github-theme")
	end
end

ColorIt(colors)

require("lualine").setup({
	sections = {
		lualine_a = { nonicons_extention.mode },
		lualine_c = {
			{ "filename" },
		},
	},
})

require("nvim-nonicons").setup({})

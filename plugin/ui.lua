local colorscheme = "catppuccin"

local dressing = require("dressing")
local od = require("onedark")
local mat = require("material")
local gh = require("github-theme");

local ll = require("lualine")
local gps = require("nvim-gps")

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

vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})


vim.notify = require("notify")

dressing.setup({
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

-- Onedark
od.setup({
    theme = "deep"
})

-- Gruvbox
vim.g.gruvbox_material_foreground = "material" -- material, mix, original
vim.g.gruvbox_material_background = "hard" -- hard, medium, soft

-- Tokyo Night
vim.g.tokyonight_style = "night"

-- Neon
vim.g.neon_style = "doom"

-- Material
vim.g.material_style = "deep ocean" -- Oceanic, Deep Ocean, Palenight, Lighter, Darker
mat.setup({
    lualine_style = "stealth",
    italics = { comments = true },
})

-- Github
gh.setup({})

-- Catppuccin
vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

-- Lualine
gps.setup({
    separator = "  ",
})

ll.setup({
    sections = {
        lualine_c = {
            { "filename" },
            {
                gps.get_location,
                cond = gps.is_available
            },
        },
    }
})

vim.cmd("colorscheme " .. colorscheme)

vim.cmd("highlight Folded guibg=#212231")

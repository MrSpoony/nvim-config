local od = require("onedark")
local mat = require("material")
local gh = require("github-theme");

local ll = require("lualine")
local gps = require("nvim-gps")

-- Onedark
od.setup({
    theme = "deep"
})

-- Gruvbor
vim.g.gruvbox_material_background = "hard"

-- Tokyo Nicht
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
gh.setup({ })

-- Catppuccin
vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha

require("catppuccin").setup()

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
vim.cmd("colorscheme catppuccin")

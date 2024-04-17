if IsMac then
	vim.fn.setenv("MACOSX_DEPLOYMENT_TARGET", "10.15")
	vim.fn.setenv("OPENSSL_DIR", "/usr/local/opt/openssl")
end

-- install lazy.nvim if not installed yet
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"nvim-lua/plenary.nvim",
	{
		"rcarriga/nvim-notify",
		lazy = true,
		dependencies = { "yamatsum/nvim-web-nonicons" },
	},

	-- Really useful
	{
		"mbbill/undotree",
		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<CR>" },
		},
		lazy = true,
	},

	-- UI
	-- Themes:
	{ "Mofiqul/dracula.nvim", lazy = true },
	{ "folke/tokyonight.nvim", lazy = true },
	{ "marko-cerovac/material.nvim", lazy = true },
	{ "navarasu/onedark.nvim", lazy = true },
	{ "sainnhe/gruvbox-material", lazy = true },
	{ "ellisonleao/gruvbox.nvim", lazy = true },
	{ "shaunsingh/nord.nvim", lazy = true },
	{ "rafamadriz/neon", lazy = true },
	{ "projekt0n/github-nvim-theme", lazy = true },
	{ "catppuccin/nvim", name = "catppuccin", lazy = true },
	{ "EdenEast/nightfox.nvim", lazy = true },

	{ "nvim-lualine/lualine.nvim", lazy = true },
	"mhinz/vim-startify",
	{ "stevearc/dressing.nvim", lazy = true },
	"voldikss/vim-floaterm",
	"kyazdani42/nvim-web-devicons",
	{
		"yamatsum/nvim-web-nonicons",
		dependencies = { "kyazdani42/nvim-web-devicons" },
	},
	"neovide/neovide",

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
        dependencies = {
            { "nvim-treesitter/nvim-treesitter-context" },
            {
                "nvim-treesitter/playground",
                cmd = "TSPlaygroundToggle",
                lazy = true,
            },
            { "nvim-treesitter/nvim-treesitter-textobjects", },
            { "p00f/nvim-ts-rainbow", },
            { "windwp/nvim-ts-autotag", },
        },
	},


	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
	},

	-- Other stuff
	"tpope/vim-repeat",
	"tpope/vim-abolish",
	"tpope/vim-surround",
	{
		"windwp/nvim-autopairs",
		lazy = true,
		opts = {
			disable_in_macro = true,
			disable_in_visualblock = true,
			check_ts = true,
		},
	},
	"dhruvasagar/vim-table-mode",
	{
		"aserowy/tmux.nvim",
		opts = {
			copy_sync = {
				enable = true,
				redirect_to_clipboard = true,
				sync_clipboard = true,
				sync_unnamed = true,
			},
			navigation = {
				cycle_navigation = true,
				enable_default_keybindings = true,
			},
			resize = {
				enable_default_keybindings = true,
			},
		},
		keys = {
			{ "<Up>", function() require("tmux").resize_top() end, },
			{ "<Down>", function() require("tmux").resize_bottom() end, },
			{ "<Left>", function() require("tmux").resize_left() end, },
			{ "<Right>", function() require("tmux").resize_right() end, },
			{ "<M-j>", function() require("tmux").resize_top() end, },
			{ "<M-k>", function() require("tmux").resize_bottom() end, },
			{ "<M-h>", function() require("tmux").resize_left() end, },
			{ "<M-l>", function() require("tmux").resize_right() end, },
			{ "<C-j>", function() require("tmux").move_top() end, },
			{ "<C-k>", function() require("tmux").move_bottom() end, },
			{ "<C-h>", function() require("tmux").move_left() end, },
			{ "<C-l>", function() require("tmux").move_right() end, },
			{ "∆", function() require("tmux").resize_top() end, },
			{ "˚", function() require("tmux").resize_bottom() end, },
			{ "˙", function() require("tmux").resize_left() end, },
			{ "¬", function() require("tmux").resize_right() end, },
		},
        lazy = true,
	},
	{ "ckarnell/Antonys-macro-repeater", event = "RecordingEnter" },
	{
		"ThePrimeagen/harpoon",
		keys = {
			{ "<leader>a", function() require("harpoon.mark").add_file() end, },
			{ "<leader>h", function() require("harpoon.ui").toggle_quick_menu() end, },
			{ "<leader>n", function() require("harpoon.ui").nav_file(1) end, },
			{ "<leader>e", function() require("harpoon.ui").nav_file(2) end, },
			{ "<leader>i", function() require("harpoon.ui").nav_file(3) end, },
			{ "<leader>o", function() require("harpoon.ui").nav_file(4) end, },
			{ "<leader>k", function() require("harpoon.ui").nav_file(5) end, },
			{ "<leader>m", function() require("harpoon.ui").nav_file(6) end, },
			{ "<leader>,", function() require("harpoon.ui").nav_file(7) end, },
			{ "<leader>.", function() require("harpoon.ui").nav_file(8) end, },
			{ "<leader>/", function() require("harpoon.ui").nav_file(9) end, },
		},
		dependencies = { "nvim-lua/plenary.nvim" },
        lazy = true,
	},
	"gpanders/editorconfig.nvim",

	-- New "Verbs"
	{
		"numToStr/Comment.nvim",
		opts = {
			toggler = {
				line = "gcc",
				block = "gbc",
			},
			opleader = {
				line = "gc",
				block = "gb",
			},
			extra = {
				above = "gcO",
				below = "gco",
				eol = "gcA",
			},
			mappings = {
				basic = true,
				extra = true,
				extended = false,
			},
		},
        lazy = true,
        keys = {
            {"gcc"},
            {"gbc"},

            {"gc", mode="x"},
            {"gbc", mode="x"},

            {"gc0"},
            {"gco"},
            {"gcA"},
        }
	},
	{
		"gbprod/substitute.nvim",
		opts = {
            highlight_substituted_text = {
                enabled = false,
                timer = 500,
            },
        },
		lazy = true,
		keys = {
			{ "s", function() require("substitute").operator() end, noremap = false },
			{ "ss", function() require("substitute").line() end, noremap = false },
			{ "S", function() require("substitute").eol() end, noremap = false },
			{ "s", function() require("substitute").visual() end, mode = "x", noremap = false },

			{ "<leader>s", function() require("substitute").operator({ register = "+" }) end, noremap = false },
			{ "<leader>ss", function() require("substitute").line({ register = "+" }) end, noremap = false },
			{ "<leader>S", function() require("substitute").eol({ register = "+" }) end, noremap = false },
			{ "<leader>s",  function() require("substitute").visual({register="+"}) end, mode="x", noremap = false },
		},
	},

	-- New "Nouns"
	{
		"kana/vim-textobj-entire",
		dependencies = { "kana/vim-textobj-user" },
		event = "BufEnter",
	},
	"wellle/targets.vim",

	-- LSP stuff
	"neovim/nvim-lspconfig",
	{ "williamboman/mason.nvim", config = true , lazy = true , cmd = "Mason"},
	{ "ray-x/lsp_signature.nvim", lazy = true },
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lua",
			{
				"saadparwaiz1/cmp_luasnip",
				dependencies = { "L3MON4D3/LuaSnip" },
			},
			{
				"zbirenbaum/copilot-cmp",
				dependencies = { "zbirenbaum/copilot.lua" },
				config = true,
			},
		},
	},
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter",
	},

	"jose-elias-alvarez/null-ls.nvim",

	"lervag/vimtex",
	{
		"iamcco/markdown-preview.nvim",
		build = vim.fn["mkdp#util#install"],
	},

	"mfussenegger/nvim-dap",
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		lazy = true,
		config = true,
	},
	{ "theHamsta/nvim-dap-virtual-text", config = true },
	{ "leoluz/nvim-dap-go", config = true },

	-- Git
	{
		"lewis6991/gitsigns.nvim",
		cmd = "Gitsigns",
		opts = {
			watch_gitdir = {
				interval = 500,
			},
			attach_to_untracked = true,
			current_line_blame = false,
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol",
				delay = 1000,
				ignore_whitespace = false,
			},
			-- current_line_blame_formatter = " ﳑ <author>, <author_time:%Y-%m-%d> - <summary>",
		},
		keys = {
			{ "<leader>ga", "<cmd>!git fetch --all<CR>" },
			{ "<leader>gt", "<cmd>FloatermNew lazygit<CR>" },
			{
				"]g",
				function()
					require("gitsigns").next_hunk()
				end,
			},
			{
				"[g",
				function()
					require("gitsigns").prev_hunk()
				end,
			},
		},
	},
	"rhysd/committia.vim",

	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
		version = "v2.*",
		build = "make install_jsregexp",
	},
	{
		"rafamadriz/friendly-snippets",
		lazy = true,
	},

	-- Own plugin
	{ dir = "~/code/vim/plugins/soicode.vim" },
	{
		dir = "~/code/lua/soicode.nvim",
		opts = {
			-- debug = true,
		},
	},
})

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

local lazy = require("lazy")
lazy.setup({
	"lewis6991/impatient.nvim", -- Speed up startup times

	-- Dependencies for others
	"nvim-lua/plenary.nvim", -- Some helpful lua functions other plugins (telecope) need
	{ "rcarriga/nvim-notify", lazy = true }, -- Notifcations
	"tami5/sqlite.lua", -- Store stuff in sqlite database for more speed
	{ "junegunn/fzf", build = "./install -- all" }, -- FZF
	"junegunn/fzf.vim", -- FZF in vim
	"mbbill/undotree", -- Undo representation

	-- UI
	-- Themes:
	{ "Mofiqul/dracula.nvim", lazy = true }, -- Dracula
	{ "folke/tokyonight.nvim", lazy = true }, -- Tokyo night
	{ "marko-cerovac/material.nvim", lazy = true }, -- Material
	{ "navarasu/onedark.nvim", lazy = true }, -- Onedark
	{ "sainnhe/gruvbox-material", lazy = true }, -- Gruvbox
	{ "ellisonleao/gruvbox.nvim", lazy = true }, -- another Gruvbox
	{ "shaunsingh/nord.nvim", lazy = true }, -- Nord
	{ "rafamadriz/neon", lazy = true }, -- Neon
	{ "projekt0n/github-nvim-theme", lazy = true }, -- Github
	{ "catppuccin/nvim", name = "catppuccin", lazy = true }, -- Catppuccin
	{ "EdenEast/nightfox.nvim", lazy = true }, -- Nightfox

	{ "nvim-lualine/lualine.nvim", lazy = true }, -- Line at the bottom
	"mhinz/vim-startify", -- Fancy startup screen
	"stevearc/dressing.nvim", -- Better standard vim ui's
	{ "ray-x/guihua.lua", build = "cd lua/fzy && make" }, -- UI for lua plugins
	"voldikss/vim-floaterm", -- Floating terminal
	"kyazdani42/nvim-web-devicons", -- Icons
	{
		"yamatsum/nvim-web-nonicons", -- Nonicons
		dependencies = {
			"kyazdani42/nvim-web-devicons",
		},
	},
	"neovide/neovide", -- Neovide support
	"kyazdani42/nvim-tree.lua", -- File structure

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter", -- TreeSitter for syntax highlighting and code `understanding`
		build = ":TSUpdate",
		lazy = true,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"nvim-treesitter/playground",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-refactor",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"p00f/nvim-ts-rainbow",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"windwp/nvim-ts-autotag",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"jvgrootveld/telescope-zoxide",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
	},
	{
		"nvim-telescope/telescope-symbols.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
	},
	{
		"nvim-telescope/telescope-smart-history.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
	},

	-- Other stuff
	"tpope/vim-repeat", -- Repeat commands
	"tpope/vim-abolish", -- search for, substitute, and abbreviate multiple variants of a word
	"tpope/vim-surround", -- Surround your stuff easier with brackets or quotes
	{ "windwp/nvim-autopairs", lazy = true }, -- Auto pairing brackets
	"dhruvasagar/vim-table-mode", -- Awesome automatic tables
	"aserowy/tmux.nvim", -- Tmux Integration
	{
		"mizlan/iswap.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	}, -- Swap function arguments etc.
	"ckarnell/Antonys-macro-repeater", -- Repeat macros with `.`
	"AndrewRadev/splitjoin.vim", -- Split up oneliners `gS` or oneline multiliners `gJ`
	"folke/todo-comments.nvim", -- Highlight comments
	{
		"ThePrimeagen/harpoon",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	}, -- Move around
	"sheerun/vim-polyglot", -- Collection of language packs
	{ "norcalli/nvim-colorizer.lua", lazy = true }, -- Color highlighting
	"gpanders/editorconfig.nvim", -- Editorconfig

	-- New "Verbs"
	{ "numToStr/Comment.nvim", lazy = true }, -- Comments from treesitter `gc`
	"junegunn/vim-easy-align", -- Algin `ga`
	{ "gbprod/substitute.nvim", lazy = true }, -- Replace without going into visual mode

	-- New "Nouns"
	"kana/vim-textobj-user", -- For own "Nouns"
	"michaeljsmith/vim-indent-object", -- Indent object with ii, ai, aI, and iI etc.
	{
		"kana/vim-textobj-entire",
		dependencies = {
			"kana/vim-textobj-user",
		},
	}, -- Whole document ae, ie
	"wellle/targets.vim", -- Many helpful targets

	-- LSP stuff
	"neovim/nvim-lspconfig", -- Nvim lsp support
	{ "williamboman/mason.nvim", lazy = true }, -- Easy installation for lsp's
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
	}, -- Easy configuration for lsp's
	{ "ray-x/lsp_signature.nvim", lazy = true }, -- LSP signatures as overlay
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- Nvim-cmp source for neovim"s built-in ls client
			"hrsh7th/cmp-buffer", -- Nvim-cmp source for buffer words
			"hrsh7th/cmp-path", -- Nvim-cmp source for filesystem paths
			"hrsh7th/cmp-cmdline", -- Nvim-cmp source for vim`s commandline
			"hrsh7th/cmp-nvim-lua", -- Nvim lua completion
			{
				"saadparwaiz1/cmp_luasnip",
				dependencies = {
					"L3MON4D3/LuaSnip",
				},
			}, -- luasnip support
			{
				"zbirenbaum/copilot-cmp",
				dependencies = {
					"zbirenbaum/copilot.lua", -- gitub copilot
				},
			}, -- github copilot completion
		},
	}, -- Autocompletion engine
	{ "zbirenbaum/copilot.lua", event = "InsertEnter" }, -- gitub copilot

	"rafamadriz/friendly-snippets", -- Helpful snippets for popular languages
	{ "folke/trouble.nvim", lazy = true }, -- Pretty diagnostics etc.
	"jose-elias-alvarez/null-ls.nvim", -- Easier access to nvim lsp api for other plugins

	-- Language specific stuff
	{
		"ray-x/go.nvim",
		requires = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		lazy = true,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
	},
	--  "hdiniz/vim-gradle",                      -- Java Gradle
	"neoclide/vim-jsx-improve", -- JSX
	"lervag/vimtex", -- LaTeX
	{
		"iamcco/markdown-preview.nvim",
		build = vim.fn["mkdp#util#install"],
	}, -- Markdown

	-- Debugging
	"mfussenegger/nvim-dap", -- Debugger Adapter Protocol
	"rcarriga/nvim-dap-ui", -- UI for DAP
	"theHamsta/nvim-dap-virtual-text", -- Virtual Text support for DAP
	"leoluz/nvim-dap-go", -- Go debugging
	"andrewferrier/debugprint.nvim", -- Debug printing

	-- Git
	"lewis6991/gitsigns.nvim", -- Git signs (gitgutter, Line blame etc.)
	"rhysd/committia.vim", -- Better commit buffers

	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		build = "make install_jsregexp",
	}, -- Snippet engine with really nice functionalities

	-- Own plugin
	-- "~/code/vim/plugins/soicode.vim", -- For soi stuff with the .stoml support
})

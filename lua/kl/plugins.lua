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
	{ "rcarriga/nvim-notify", lazy = true },
	"tami5/sqlite.lua",
	{ "junegunn/fzf", build = "./install --all" },
	"junegunn/fzf.vim",

	-- Really useful
	"mbbill/undotree",

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
	{ "ray-x/guihua.lua", build = "cd lua/fzy && make" },
	"voldikss/vim-floaterm",
	"kyazdani42/nvim-web-devicons",
	{
		"yamatsum/nvim-web-nonicons",
		dependencies = {
			"kyazdani42/nvim-web-devicons",
		},
	},
	"neovide/neovide",
	"kyazdani42/nvim-tree.lua",

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
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
	"tpope/vim-repeat",
	"tpope/vim-abolish",
	"tpope/vim-surround",
	{ "windwp/nvim-autopairs", lazy = true },
	"dhruvasagar/vim-table-mode",
	{ "aserowy/tmux.nvim", lazy = true },
	{
		"mizlan/iswap.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{ "ckarnell/Antonys-macro-repeater", event = "RecordingEnter" },
	"AndrewRadev/splitjoin.vim",
	{ "folke/todo-comments.nvim", lazy = true },
	{
		"ThePrimeagen/harpoon",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	"sheerun/vim-polyglot",
	{ "norcalli/nvim-colorizer.lua", lazy = true },
	"gpanders/editorconfig.nvim",

	-- New "Verbs"
	{ "numToStr/Comment.nvim", lazy = true },
	"junegunn/vim-easy-align",
	{ "gbprod/substitute.nvim", lazy = true },

	-- New "Nouns"
	"kana/vim-textobj-user",
	"michaeljsmith/vim-indent-object",
	{
		"kana/vim-textobj-entire",
		dependencies = {
			"kana/vim-textobj-user",
		},
	},
	"wellle/targets.vim",

	-- LSP stuff
	"neovim/nvim-lspconfig",
	{ "williamboman/mason.nvim", lazy = true },
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
	},
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
				dependencies = {
					"L3MON4D3/LuaSnip",
				},
			},
			{
				"zbirenbaum/copilot-cmp",
				dependencies = {
					"zbirenbaum/copilot.lua",
				},
			},
		},
	},
	{ "zbirenbaum/copilot.lua", event = "InsertEnter" },

	"rafamadriz/friendly-snippets",
	{ "folke/trouble.nvim", lazy = true },
	"jose-elias-alvarez/null-ls.nvim",

	-- Language specific stuff
	{
		"ray-x/go.nvim",
		requires = {
			{ "ray-x/guihua.lua", build = "cd lua/fzy && make" },
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		lazy = true,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = '<cmd>lua require("go.install").update_all_sync()<CR>',
	},
	--  "hdiniz/vim-gradle",                     
	"neoclide/vim-jsx-improve",
	"lervag/vimtex",
	{
		"iamcco/markdown-preview.nvim",
		build = vim.fn["mkdp#util#install"],
	},


	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",
	"theHamsta/nvim-dap-virtual-text",
	"leoluz/nvim-dap-go",
	"andrewferrier/debugprint.nvim",

	-- Git
	"lewis6991/gitsigns.nvim",
	"rhysd/committia.vim",

	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		lazy = true,
		build = "make install_jsregexp",
	},

	-- Own plugin
	-- "~/code/vim/plugins/soicode.vim",
})

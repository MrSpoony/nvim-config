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
		dependencies = { "yamatsum/nvim-web-nonicons" }
	},
	"tami5/sqlite.lua",
	{ "junegunn/fzf",                build = "./install --all" },
	"junegunn/fzf.vim",

	-- Really useful
	{
		"mbbill/undotree",
		keys = {
			{ "<leader>u", "<cmd>UndotreeToggle<CR>" },
		},
	},

	-- UI
	-- Themes:
	{ "Mofiqul/dracula.nvim",        lazy = true },
	{ "folke/tokyonight.nvim",       lazy = true },
	{ "marko-cerovac/material.nvim", lazy = true },
	{ "navarasu/onedark.nvim",       lazy = true },
	{ "sainnhe/gruvbox-material",    lazy = true },
	{ "ellisonleao/gruvbox.nvim",    lazy = true },
	{ "shaunsingh/nord.nvim",        lazy = true },
	{ "rafamadriz/neon",             lazy = true },
	{ "projekt0n/github-nvim-theme", lazy = true },
	{ "catppuccin/nvim",             name = "catppuccin",      lazy = true },
	{ "EdenEast/nightfox.nvim",      lazy = true },

	{ "nvim-lualine/lualine.nvim",   lazy = true },
	"mhinz/vim-startify",
	{ "stevearc/dressing.nvim", lazy = true },
	{ "ray-x/guihua.lua",       build = "cd lua/fzy && make" },
	"voldikss/vim-floaterm",
	"kyazdani42/nvim-web-devicons",
	{
		"yamatsum/nvim-web-nonicons",
		dependencies = { "kyazdani42/nvim-web-devicons", },
	},
	"neovide/neovide",
	{
		"kyazdani42/nvim-tree.lua",
		opts = {
			renderer = {
				group_empty = true,
				highlight_opened_files = "icon",
				icons = {},
			},
			open_on_tab = false,
			update_cwd = true,
			diagnostics = {
				enable = true,
				show_on_dirs = false,
			},
			update_focused_file = {
				enable = true,
				update_cwd = true,
				update_root = true,
				ignore_list = {},
			},
			view = {
				adaptive_size = true,
				width = 40,
				side = "left",
			},
			trash = {
				cmd = "trash",
				require_confirm = true,
			},
		},
		keys = {
			{ "<C-f>", "<cmd>Telescope file_browser<cr>" }
		}
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter", },
	},
	{
		"nvim-treesitter/playground",
		dependencies = { "nvim-treesitter/nvim-treesitter", },
	},
	{
		"nvim-treesitter/nvim-treesitter-refactor",
		dependencies = { "nvim-treesitter/nvim-treesitter", },
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter", },
	},
	{
		"p00f/nvim-ts-rainbow",
		dependencies = { "nvim-treesitter/nvim-treesitter", },
	},
	{
		"windwp/nvim-ts-autotag",
		dependencies = { "nvim-treesitter/nvim-treesitter", },
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter", },
	},
	{
		"jvgrootveld/telescope-zoxide",
		dependencies = { "nvim-telescope/telescope.nvim", },
	},
	{
		"nvim-telescope/telescope-symbols.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", },
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", },
	},
	{
		"nvim-telescope/telescope-smart-history.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", },
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		dependencies = { "nvim-telescope/telescope.nvim", },
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
		}
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
			{ "<Up>", function() require("tmux").resize_top() end },
			{ "<Down>", function() require("tmux").resize_bottom() end },
			{ "<Left>", function() require("tmux").resize_left() end },
			{ "<Right>", function() require("tmux").resize_right() end },
			{ "<M-j>", function() require("tmux").resize_top() end },
			{ "<M-k>", function() require("tmux").resize_bottom() end },
			{ "<M-h>", function() require("tmux").resize_left() end },
			{ "<M-l>", function() require("tmux").resize_right() end },
			{ "∆", function() require("tmux").resize_top() end },
			{ "˚", function() require("tmux").resize_bottom() end },
			{ "˙", function() require("tmux").resize_left() end },
			{ "¬", function() require("tmux").resize_right() end },
		},
		-- lazy = true
	},
	{ "ckarnell/Antonys-macro-repeater", event = "RecordingEnter" },
	"AndrewRadev/splitjoin.vim",
	{
		"folke/todo-comments.nvim",
		lazy = true,
		config = true
	},
	{
		"ThePrimeagen/harpoon",
		keys = {
			{ "<leader>a", function() require("harpoon.mark").add_file() end },
			{ "<leader>h", function() require("harpoon.ui").toggle_quick_menu() end },
			{ "<leader>n", function() require("harpoon.ui").nav_file(1) end },
			{ "<leader>e", function() require("harpoon.ui").nav_file(2) end },
			{ "<leader>i", function() require("harpoon.ui").nav_file(3) end },
			{ "<leader>o", function() require("harpoon.ui").nav_file(4) end },
			{ "<leader>k", function() require("harpoon.ui").nav_file(5) end },
			{ "<leader>m", function() require("harpoon.ui").nav_file(6) end },
			{ "<leader>,", function() require("harpoon.ui").nav_file(7) end },
			{ "<leader>.", function() require("harpoon.ui").nav_file(8) end },
			{ "<leader>/", function() require("harpoon.ui").nav_file(9) end },
		},
		dependencies = { "nvim-lua/plenary.nvim", },
	},
	"sheerun/vim-polyglot",
	{ "norcalli/nvim-colorizer.lua",     lazy = true },
	"gpanders/editorconfig.nvim",

	-- New "Verbs"
	{
		"numToStr/Comment.nvim",
		lazy = true,
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
	},
	{
		"junegunn/vim-easy-align",
		keys = {
			{ "ga", "<Plug>(EasyAlign)" },
			{ "ga", "<Plug>(EasyAlign)", "x" },
		}
	},
	{
		"gbprod/substitute.nvim",
		lazy = true,
		opts = {
			highlight_substituted_text = {
				enabled = false,
				timer = 500,
			},
		},
		keys = {
			{ "s",          function() require("substitute").operator() end,                   "x" },
			{ "ss",         function() require("substitute").line() end },
			{ "S",          function() require("substitute").eol() end },
			{ "s",          function() require("substitute").visual() end,                     "v" },
			{ "<leader>s",  function() require("substitute").operator({ register = "+" }) end, "x" },
			{ "<leader>ss", function() require("substitute").line({ register = "+" }) end },
			{ "<leader>S",  function() require("substitute").eol({ register = "+" }) end },
			{ "<leader>s",  function() require("substitute").visual({ register = "+" }) end,   "v" },
		}
	},

	-- New "Nouns"
	"kana/vim-textobj-user",
	"michaeljsmith/vim-indent-object",
	{
		"kana/vim-textobj-entire",
		dependencies = { "kana/vim-textobj-user", },
	},
	"wellle/targets.vim",

	-- LSP stuff
	"neovim/nvim-lspconfig",
	{ "williamboman/mason.nvim",  lazy = true, config = true },
	{
		"williamboman/mason-lspconfig.nvim",

		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig", },
		opts = {
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"clangd",
				"eslint",
				"tsserver",
				"gopls",
			},
		}
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
				dependencies = { "L3MON4D3/LuaSnip", },
			},
			{
				"zbirenbaum/copilot-cmp",
				dependencies = { "zbirenbaum/copilot.lua", },
				config = true,
			},
		},
	},
	{
		"zbirenbaum/copilot.lua",
		event = "InsertEnter"
	},

	"rafamadriz/friendly-snippets",
	{ "folke/trouble.nvim",              lazy = true },
	"jose-elias-alvarez/null-ls.nvim",

	"neoclide/vim-jsx-improve",
	"lervag/vimtex",
	{
		"iamcco/markdown-preview.nvim",
		build = vim.fn["mkdp#util#install"],
	},

	"mfussenegger/nvim-dap",
	{ "rcarriga/nvim-dap-ui",            config = true },
	{ "theHamsta/nvim-dap-virtual-text", config = true },
	{ "leoluz/nvim-dap-go",              config = true },

	-- Git
	{
		"lewis6991/gitsigns.nvim",
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
			current_line_blame_formatter = " ﳑ <author>, <author_time:%Y-%m-%d> - <summary>",
		},
		keys = {
			{ "<leader>ga", "<cmd>!git fetch --all<CR>" },
			{ "<leader>gt", "<cmd>FloatermNew lazygit<CR>" },
			{ "]g",         function() require("gitsigns").next_hunk() end },
			{ "[g",         function() require("gitsigns").prev_hunk() end },
		}
	},
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

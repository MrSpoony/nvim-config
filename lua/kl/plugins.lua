vim.fn.setenv("MACOSX_DEPLOYMENT_TARGET", "10.15")
vim.fn.setenv("OPENSSL_DIR", "/usr/local/opt/openssl")
vim.cmd([[packadd packer.nvim]])

local packer = require("packer")

local has = function(x)
  return vim.fn.has(x) == 1
end

local is_mac = has "macunix"

local max_jobs = nil
if is_mac then
  max_jobs = 32
end

return packer.startup({
    function(use)
        use { "wbthomason/packer.nvim" } -- Let packer manage itself

        use { "lewis6991/impatient.nvim" } -- Speed up startup times

        -- Dependencies for others
        use { "nvim-lua/plenary.nvim" }                  -- Some helpful lua functions other plugins (telecope) need
        use { "nvim-lua/popup.nvim" }                    -- Popups
        use { "rcarriga/nvim-notify" }                   -- Notifcations
        use { "tami5/sqlite.lua" }                       -- Store stuff in sqlite database for more speed
        use { "junegunn/fzf", run = "./install -- all" } -- FZF
        use { "junegunn/fzf.vim" }                       -- FZF in vim
        use { "mbbill/undotree" }                        -- Undo representation


        -- UI
        -- Themes:
        use { "Mofiqul/dracula.nvim" }                        -- Dracula
        use { "folke/tokyonight.nvim" }                       -- Tokyo night
        use { "marko-cerovac/material.nvim" }                 -- Material
        use { "navarasu/onedark.nvim" }                       -- Onedark
        use { "sainnhe/gruvbox-material" }                    -- Gruvbox
        use { "luisiacc/gruvbox-baby" }                       -- Gruvbox
        use { "shaunsingh/nord.nvim" }                        -- Nord
        use { "rafamadriz/neon" }                             -- Neon
        use { "projekt0n/github-nvim-theme" }                 -- Github
        use { "catppuccin/nvim", as = "catppuccin" }          -- Catppuccin

        use { "nvim-lualine/lualine.nvim" }                    -- Line at the bottom
        use { "SmiteshP/nvim-gps" }                            -- Location widget in lualine
        use { "mhinz/vim-startify" }                           -- Fancy startup screen
        use { "stevearc/dressing.nvim" }                       -- Better standard vim ui's
        use { "ray-x/guihua.lua", run = 'cd lua/fzy && make' } -- UI for lua plugins
        use { "voldikss/vim-floaterm" }                         -- Floating terminal
        use { "karb94/neoscroll.nvim" }                        -- Smooth scroll
        use { "kyazdani42/nvim-web-devicons" }                 -- Icons like the name implies
        use { "neovide/neovide" }                              -- Neovide support
        use { "kyazdani42/nvim-tree.lua" }                     -- File structure


        -- Treesitter
        use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" } -- TreeSitter for syntax highlighting and code `understanding`
        use { "nvim-treesitter/playground" }                         -- TreeSitter playground :TSPlaygroundToggle
        use { "nvim-treesitter/nvim-treesitter-refactor" }           -- Refactoring tools
        use { "nvim-treesitter/nvim-treesitter-textobjects" }        -- Treesitter textobjects f (functions), etc
        use { "p00f/nvim-ts-rainbow" }                               -- Rainbow brackets from treesitter
        use { "windwp/nvim-ts-autotag" }                             -- Close tags


        -- Telescope
        use { "nvim-telescope/telescope.nvim" }                      -- Telescope search etc.
        use { "jvgrootveld/telescope-zoxide" }                       -- Like z command
        use { "nvim-telescope/telescope-symbols.nvim" }              -- Symbols
        use {
            "nvim-telescope/telescope-fzf-native.nvim", run = "make"
        }                                                            -- FZF Performance and syntax
        use { "nvim-telescope/telescope-smart-history.nvim" }        -- Store search history in sqlite database

        -- Other stuff
        use { "tpope/vim-repeat" }                              -- Repeat commands
        use { "windwp/nvim-autopairs" }                         -- Auto pairing brackets
        use { "tpope/vim-surround" }                            -- Surround your stuff easier with brackets or quotes
        use { "andweeb/presence.nvim" }                         -- Discord precense
        use { "wakatime/vim-wakatime" }                         -- Time counting and stuff
        use { "dhruvasagar/vim-table-mode" }                    -- Awesome automatic tables
        use { "aserowy/tmux.nvim" }                             -- Tmux Integration
        use { "mizlan/iswap.nvim" }                             -- Swap function arguments etc.
        use { "ckarnell/Antonys-macro-repeater" }               -- Repeat macros with `.`
        use { "AndrewRadev/splitjoin.vim" }                     -- Split up oneliners `gS` or oneline multiliners `gJ`
        use { "folke/todo-comments.nvim" }                      -- Highlight comments
        use { "tpope/vim-dadbod" }                              -- Database integration
        use { "kristijanhusak/vim-dadbod-ui" }                  -- Pretty database integration
        use { "ThePrimeagen/harpoon" }                          -- Move around
        use { "sheerun/vim-polyglot" }                          -- Collection of language packs
        use { "norcalli/nvim-colorizer.lua" }                   -- Color highlighting
        use { "shift-d/scratch.nvim" }                          -- Scratch buffer



        -- New "Verbs"
        use { "numToStr/Comment.nvim" }           -- Comments from treesitter `gc`
        use { "junegunn/vim-easy-align" }         -- Algin `ga`
        use { "vim-scripts/regreplop.vim" }       -- Replace without goin into visual mode `gr`
        use { "christoomey/vim-sort-motion" }     -- Sort with `gs`


        -- New "Nouns"
        use { "kana/vim-textobj-user" }           -- For own "Nouns"
        use { "michaeljsmith/vim-indent-object" } -- Indent object with ii, ai, aI, and iI etc.
        use { "kana/vim-textobj-entire" }         -- Whole document ae, ie
        use { "wellle/targets.vim" }              -- Many helpful targets


        -- LSP stuff
        use { "neovim/nvim-lspconfig" }                -- Nvim lsp support
        use { "williamboman/nvim-lsp-installer" }      -- Easy installation for lsp`s
        use { "ray-x/lsp_signature.nvim" }             -- LSP signatures as overlay
        use { "p00f/clangd_extensions.nvim" }          -- Clang extension for nvim-lsp
        use { "hrsh7th/nvim-cmp" }                     -- Autocompletion engine
        use { "hrsh7th/cmp-nvim-lsp" }                 -- Nvim-cmp source for neovim"s built-in ls client
        use { "hrsh7th/cmp-buffer" }                   -- Nvim-cmp source for buffer words
        use { "hrsh7th/cmp-path" }                     -- Nvim-cmp source for filesystem paths
        use { "hrsh7th/cmp-cmdline" }                  -- Nvim-cmp source for vim`s commandline
        use { "hrsh7th/cmp-nvim-lua" }                 -- Nvim lua completion
        use { "kristijanhusak/vim-dadbod-completion" } -- Nvim-cmp soursce for database query language
        use { "saadparwaiz1/cmp_luasnip" }             -- luasnip support
        use { "rafamadriz/friendly-snippets" }         -- Helpful snippets for popular languages
        use { "folke/trouble.nvim" }                   -- Pretty diagnostics etc.
        use { "jose-elias-alvarez/null-ls.nvim" }      -- Easier access to nvim lsp api for other plugins

        -- Language specific stuff
        use { "ray-x/go.nvim" }                          -- Go
        use { "hdiniz/vim-gradle" }                      -- Java Gradle
        use { "neoclide/vim-jsx-improve" }               -- JSX
        use { "bdauria/angular-cli.vim" }                -- Angular
        use { "lervag/vimtex" }                          -- LaTeX
        use {
            "iamcco/markdown-preview.nvim",
            run = vim.fn["mkdp#util#install"],
        }                                                -- Markdown


        -- Debugging
        use { "mfussenegger/nvim-dap" }           -- Debugger Adapter Protocol
        use { "rcarriga/nvim-dap-ui" }            -- UI for DAP
        use { "theHamsta/nvim-dap-virtual-text" } -- Virtual Text support for DAP
        use { "leoluz/nvim-dap-go" }              -- Go debugging


        -- Git
        use { "ThePrimeagen/git-worktree.nvim" } -- Worktrees with vim
        use { "lewis6991/gitsigns.nvim" }        -- Git signs (gitgutter, Line blame etc.)
        use { "akinsho/git-conflict.nvim" }      -- Resolve Git merge conflicts in vim
        use { "rhysd/committia.vim" }            -- Better commit buffers


        -- Snippets
        use { "L3MON4D3/LuaSnip" } -- Snippet engine with really nice functionalities


        -- Own plugin
        -- use { "~/code/vim/plugins/soicode.vim" } -- For soi stuff with the .stoml support

    end,
    config = {
        max_jobs = max_jobs,
        luarocks = {
            python_cmd = "python3",
        },
        display = {
            open_cmd = 'leftabove 75vnew \\[packer\\]',
        },
    },
})

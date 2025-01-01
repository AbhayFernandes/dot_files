require("custom")

-- Setup lazy.nvim
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
	'mbbill/undotree',
	'nvim-lua/plenary.nvim',
	'nvim-treesitter/nvim-treesitter',
	'tpope/vim-fugitive',
    'ahmedkhalf/project.nvim',
    'ggandor/leap.nvim',
    'j-hui/fidget.nvim',
    'numToStr/Comment.nvim',
    'numToStr/FTerm.nvim',
    'nvim-lualine/lualine.nvim',
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    'onsails/lspkind.nvim',

    -- ssh setup
    'ojroques/nvim-osc52',

    -- inlay hints
    {
        "MysticalDevil/inlay-hints.nvim",
        event = "LspAttach",
        dependencies = { "neovim/nvim-lspconfig" },
        config = function()
            require("inlay-hints").setup()
        end
    },

    {"sindrets/diffview.nvim"},
    -- Alpha nvim setup
    {
        'goolord/alpha-nvim',
        config = function ()
            require'alpha'.setup(require'alpha.themes.startify'.config)
        end
    },

    -- Nvim-Navbuddy Setup
    {"neovim/nvim-lspconfig",
    dependencies = {
        {
            "SmiteshP/nvim-navbuddy",
            dependencies = {
                "SmiteshP/nvim-navic",
                "MunifTanjim/nui.nvim"
            },
            opts = { lsp = { auto_attach = true } }
        }
    }},

	-- LSP-zero setup
	{'williamboman/mason.nvim'},
	{'williamboman/mason-lspconfig.nvim'},
	{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/nvim-cmp'},
	{'L3MON4D3/LuaSnip', dependencies = {"rafamadriz/friendly-snippets"},},
    {'SmiteshP/nvim-navic', requires = "neovim/nvim-lspconfig"},
    {'saadparwaiz1/cmp_luasnip'},
    {"rafamadriz/friendly-snippets" },
    {'mrcjkb/rustaceanvim', version = '^5', lazy = false,},

    -- oil.nvim
    {
        'stevearc/oil.nvim',
        opts = {},
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    -- neovim theme
    { 'mellow-theme/mellow.nvim', priority = 1000 },

    { "folke/lazydev.nvim", opts = {} },

})

vim.loader.enable()

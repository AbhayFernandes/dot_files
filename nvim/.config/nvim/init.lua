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
    { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
	'nvim-lua/plenary.nvim',
    'dylanaraps/wal.vim',
	'nvim-treesitter/nvim-treesitter',
	'mbbill/undotree',
	'tpope/vim-fugitive',
    'ggandor/leap.nvim',
    'nvim-lualine/lualine.nvim',

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
	{'neovim/nvim-lspconfig'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/nvim-cmp'},
	{'L3MON4D3/LuaSnip', dependencies = {"rafamadriz/friendly-snippets"},},
    {'SmiteshP/nvim-navic', requires = "neovim/nvim-lspconfig"},
    {'saadparwaiz1/cmp_luasnip'},
    {"rafamadriz/friendly-snippets" },
    {'mrcjkb/rustaceanvim', version = '^4', ft = { 'rust' }},

    -- Nerd-Tree 
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            "3rd/image.nvim",
        }
    },

    -- Copilot extensions
    "zbirenbaum/copilot.lua",
    {
        "zbirenbaum/copilot-cmp",
        config = function ()
            require("copilot_cmp").setup()
        end
    },
    'AndreM222/copilot-lualine'

}, opts)

vim.loader.enable()

require("custom")
local is_code, vscode = pcall(require, "vscode")

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
	{
        'mbbill/undotree',
        cond = not is_code,
    },
    {'nvim-lua/plenary.nvim', cond = not is_code},
    {'nvim-treesitter/nvim-treesitter', cond = not is_code},
    {'tpope/vim-fugitive', cond = not is_code},
    {'ahmedkhalf/project.nvim', cond = not is_code},
    {'ggandor/leap.nvim'},
    {'j-hui/fidget.nvim', cond = not is_code},
    {'numToStr/Comment.nvim'},
    {'numToStr/FTerm.nvim', cond = not is_code},
    { 'nvim-lualine/lualine.nvim', cond = not is_code},
    {'nvim-telescope/telescope.nvim', tag = '0.1.5', cond = not is_code},
    {'onsails/lspkind.nvim', cond = not is_code},

    -- harpoon
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        cond = not is_code,
    },

    -- inlay hints
    {
        "MysticalDevil/inlay-hints.nvim",
        event = "LspAttach",
        dependencies = { "neovim/nvim-lspconfig" },
        cond = not is_code,
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
        end,
        cond = not is_code,
    },

    -- Nvim-Navbuddy Setup
    {"neovim/nvim-lspconfig",
        cond = not is_code,
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
	{'williamboman/mason.nvim', cond = not is_code},
	{'williamboman/mason-lspconfig.nvim', cond = not is_code},
	{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x', cond = not is_code},
	{'hrsh7th/cmp-nvim-lsp', cond = not is_code},
	{'hrsh7th/nvim-cmp', cond = not is_code},
	{'L3MON4D3/LuaSnip', dependencies = {"rafamadriz/friendly-snippets"}, cond = not is_code},
    {'SmiteshP/nvim-navic', requires = "neovim/nvim-lspconfig", cond = not is_code},
    {'saadparwaiz1/cmp_luasnip', cond = not is_code},
    {"rafamadriz/friendly-snippets", cond = not is_code},
    {'mrcjkb/rustaceanvim', version = '^5', lazy = false, cond = not is_code},
    {'mfussenegger/nvim-jdtls', cond = not is_code},

    -- oil.nvim
    {
        'stevearc/oil.nvim',
        opts = {},
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cond = not is_code,
    },

    -- neovim theme
    { 'ellisonleao/gruvbox.nvim', priority = 1000 },

    { "folke/neodev.nvim", opts = {}, cond = not is_code },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        cond = not is_code,
        opts = {
            preset = "helix",
            plugins = {
                presets = {
                    operators = true, -- adds help for operators like d, y, ...
                    motions = true, -- adds help for motions
                    text_objects = true, -- help for text objects triggered after entering an operator
                    windows = true, -- default bindings on <c-w>
                    nav = true, -- misc bindings to work with windows
                    z = true, -- bindings for folds, spelling and others prefixed with z
                    g = true, -- bindings for prefixed with g
                }
            }
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },

    { 'wakatime/vim-wakatime', lazy = false, cond = not is_code },

    {
        'christoomey/vim-tmux-navigator',
        lazy=false,
        cond = not is_code,
    },


    -- supermaven/AI
    {
      "supermaven-inc/supermaven-nvim",
      cond = not is_code,
    },

    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
          { "zbirenbaum/copilot.lua" }, -- or zbirenbaum/copilot.lua
          { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken", -- Only on MacOS or Linux
    },
})

vim.loader.enable()

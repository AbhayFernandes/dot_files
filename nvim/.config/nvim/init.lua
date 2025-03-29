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
    {'nvim-treesitter/nvim-treesitter', cond = not is_code},
    {'ahmedkhalf/project.nvim', cond = not is_code},
    {'ggandor/leap.nvim'},
    {'j-hui/fidget.nvim', cond = not is_code},
    {'numToStr/Comment.nvim'},
    {'numToStr/FTerm.nvim', cond = not is_code},
    {'nvim-lualine/lualine.nvim', cond = not is_code},
    {'nvim-telescope/telescope.nvim', tag = '0.1.5', cond = not is_code},

    -- Alpha nvim setup
    {
        'goolord/alpha-nvim',
        config = function ()
            require'alpha'.setup(require'alpha.themes.startify'.config)
        end,
        cond = not is_code,
    },

	-- mason.nvim
	{'williamboman/mason.nvim', cond = not is_code},
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },

        version = '1.*',
        opts = {
            keymap = { preset = 'super-tab' },

            appearance = {
                nerd_font_variant = 'mono'
            },
            completion = { documentation = { auto_show = true } },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" }
        },
        opts_extend = { "sources.default" }
    },

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

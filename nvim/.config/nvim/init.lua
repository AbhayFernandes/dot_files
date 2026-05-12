require("custom")

-- Run :TSUpdate on treesitter install/update. Must be registered BEFORE vim.pack.add().
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        if ev.data.spec.name == "nvim-treesitter"
            and (ev.data.kind == "install" or ev.data.kind == "update") then
            vim.cmd("TSUpdate")
        end
    end,
})

-- All plugins.
vim.pack.add({
    { src = "https://codeberg.org/andyg/leap.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
    { src = "https://github.com/numToStr/Comment.nvim" },
    { src = "https://github.com/LunarVim/bigfile.nvim" },
    { src = "https://github.com/chrisgrieser/nvim-spider" },
    { src = "https://github.com/j-hui/fidget.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },
    { src = "https://github.com/christoomey/vim-tmux-navigator" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/goolord/alpha-nvim" },
    { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
    { src = "https://github.com/hrsh7th/nvim-cmp" },
    { src = "https://github.com/mfussenegger/nvim-jdtls" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/ellisonleao/gruvbox.nvim" },
    { src = "https://github.com/folke/neodev.nvim" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/sindrets/diffview.nvim" },
    { src = "https://github.com/error311/wayfinder.nvim" },
    { src = "https://github.com/stevearc/quicker.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/mfussenegger/nvim-dap" },
    { src = "https://github.com/rcarriga/nvim-dap-ui" },
    { src = "https://github.com/theHamsta/nvim-dap-virtual-text" },
    { src = "https://github.com/nvim-neotest/nvim-nio" },
    { src = "https://github.com/L3MON4D3/LuaSnip" },
    { src = "https://github.com/saadparwaiz1/cmp_luasnip" },
    { src = "https://github.com/rafamadriz/friendly-snippets" },
    { src = "https://github.com/ThePrimeagen/harpoon", branch = "harpoon2" },
}, { load = true })

-- Plugin setup.
require("nvim-treesitter").install({ "lua", "typescript", "javascript", "rust", "python", "java" })
vim.api.nvim_create_autocmd("FileType", {
    callback = function() pcall(vim.treesitter.start) end,
})
require("alpha").setup(require("alpha.themes.startify").config)
require("quicker").setup()
require("oil").setup({})
require("which-key").setup({})
require('Comment').setup()
require('fidget').setup {}
vim.keymap.set("n", "<leader>dv", "<cmd>DiffviewOpen origin/main<cr>", { desc = "Diff against origin/main" })
vim.keymap.set("n", "<leader>dq", "<cmd>DiffviewClose<cr>", { desc = "Close diffview" })

vim.keymap.set({ "n", "o", "x" }, "w", "<cmd>lua require('spider').motion('w')<CR>")
vim.keymap.set({ "n", "o", "x" }, "e", "<cmd>lua require('spider').motion('e')<CR>")
vim.keymap.set({ "n", "o", "x" }, "b", "<cmd>lua require('spider').motion('b')<CR>")

vim.loader.enable()

vim.api.nvim_create_user_command("UpdatePackages", function() vim.pack.update() end, {})

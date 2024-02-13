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
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
	'nvim-lua/plenary.nvim',
    'dylanaraps/wal.vim',
	'nvim-treesitter/nvim-treesitter',
	'theprimeagen/harpoon',
	'mbbill/undotree',
    'github/copilot.vim',
	'tpope/vim-fugitive',
    'ggandor/leap.nvim',
    {"nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/neotest-python",
            "nvim-neotest/neotest-plenary",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter"
        }
    },
	-- LSP-zero setup
	{'williamboman/mason.nvim'},
	{'williamboman/mason-lspconfig.nvim'},
	{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
	{'neovim/nvim-lspconfig'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/nvim-cmp'},
	{'L3MON4D3/LuaSnip'},

    -- nvim-dap setup
    {'mfussenegger/nvim-dap'},
    {'mfussenegger/nvim-dap-python',
        ft = {'python'},
        dependencies = {
            'mfussenegger/nvim-dap',
            'mfussenegger/nvim-dap-ui',
        },
        config = function()
            local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
            require('dap-python').setup(path)
            require("dap-python").test_runner = 'unittest'
        end
    },
    { "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap" },
        config = function()
            local dap = require('dap')
            local dapui = require('dapui')
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function ()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function ()
                dapui.close()
            end
        end
    },
    { "nvim-telescope/telescope-dap.nvim", requires = { "mfussenegger/nvim-dap" } },

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
    }
}, opts)


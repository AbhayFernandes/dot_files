local is_code, _ = pcall(require, "vscode")
if is_code then
    return
end

local lsp_zero = require('lsp-zero')
local navic = require('nvim-navic')
local navbuddy = require('nvim-navbuddy')

lsp_zero.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
        navbuddy.attach(client, bufnr)
    end

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gs", function() navbuddy.open() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

vim.g.rustaceanvim = {
    server = {
        capabilties = lsp_zero.get_capabilities()
    }
}

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {"jdtls", "clangd"},
    automatic_installation = true,
    handlers = {
        lsp_zero.default_setup,
        jdtls = function() end,
        clangd = function()
            require("lspconfig").clangd.setup {
                cmd = {"/opt/spe/opencilk/bin/clangd" },
            }
        end,
    }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },
    sources = {
        {name = 'nvim_lsp', priority_weight = 7},
        {name = 'nvim_lua'},
        {name = 'path'},
        {name = 'luasnip', priority_weight = 5},
    },
    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
        ['<Return>'] = cmp.mapping.confirm({ select = false }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
    sorting = {
        priority_weight = 1,
        comparators = {
            -- Below is the default comparator list and order for nvim-cmp
            -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
            cmp.config.compare.locality,
            cmp.config.compare.recently_used,
            cmp.config.compare.score,
            cmp.config.compare.offset,
            cmp.config.compare.order,
            -- cmp.config.compare.exact,
            -- cmp.config.compare.kind,
            -- cmp.config.compare.sort_text,
            -- cmp.config.compare.length,
        },
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    }
})

local lspconfig = require 'lspconfig'
local configs = require 'lspconfig.configs'

-- Check if the config is already defined (useful when reloading this file)
if not configs.barium then
    configs.barium = {
        default_config = {
            cmd = {'barium'};
            filetypes = {'brazil-config'};
            root_dir = function(fname)
                return lspconfig.util.find_git_ancestor(fname)
            end;
            settings = {};
        };
    }
end

lspconfig.barium.setup {}

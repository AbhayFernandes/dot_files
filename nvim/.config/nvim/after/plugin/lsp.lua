local lsp_zero = require('lsp-zero')
local navic = require('nvim-navic')
local navbuddy = require('nvim-navbuddy')
local mason = require('mason-registry')

local home = os.getenv("HOME")
local workspace_dir = home .. '/.local/share/nvim/' .. vim.fn.fnamemodify(root_dir, ":p:h:t")

function bemol()
    local bemol_dir = vim.fs.find({ '.bemol' }, { upward = true, type = 'directory'})[1]
    local ws_folders_lsp = {}
    if bemol_dir then
        local file = io.open(bemol_dir .. '/ws_root_folders', 'r')
        if file then
            for line in file:lines() do
                table.insert(ws_folders_lsp, line)
            end
            file:close()
        end
    end

    for _, line in ipairs(ws_folders_lsp) do
        vim.lsp.buf.add_workspace_folder(line)
    end
end

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
local jdtls_install_dir = mason.get_package("jdtls"):get_install_path()

require('mason-lspconfig').setup({
    handlers = {
        lsp_zero.default_setup,
        jdtls = function ()
            require('lspconfig').jdtls.setup({
                on_attach = function(client, bufnr)
                    bemol()
                end,
                cmd = {
                    "jdtls",
                    "--jvm-arg=-javaagent:"
                    .. jdtls_install_dir .. "/lombok.jar",
                    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
                    '-Dosgi.bundles.defaultStartLevel=4',
                    '-Declipse.product=org.eclipse.jdt.ls.core.product',
                    '-Dlog.protocol=true',
                    '-Dlog.level=ALL',
                    '-Xms1g',
                    '--add-modules=ALL-SYSTEM',
                    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
                    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
                    '-data', workspace_dir,
                },
            })
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

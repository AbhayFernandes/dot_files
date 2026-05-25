vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local opts = {buffer = ev.buf}
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
        vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>vf", vim.lsp.buf.format, opts)
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

        if client and client.name == "rust_analyzer" then
            vim.keymap.set("n", "<leader>rm", "<cmd>RustLsp expandMacro<cr>", opts)
            vim.keymap.set("n", "<leader>rr", "<cmd>RustLsp runnables<cr>", opts)
            vim.keymap.set("n", "<leader>rt", "<cmd>RustLsp testables<cr>", opts)

            if vim.lsp.inlay_hint then
                vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
            end
        end
    end
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config('tsserver', {
    cmd = { 'typescript-language-server', '--stdio' },
    filetypes = { 'typescript', 'typescriptreact' },
    root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
    capabilities = capabilities,
})
vim.lsp.enable('tsserver')

vim.g.rustaceanvim = {
    server = {
        capabilities = capabilities,
        default_settings = {
            ["rust-analyzer"] = {
                cargo = {
                    allFeatures = true,
                },
                check = {
                    command = "clippy",
                },
                procMacro = {
                    enable = true,
                },
            },
        },
    },
}

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
    sources = {
        {name = 'nvim_lsp', priority_weight = 7},
        {name = 'nvim_lua'},
        {name = 'path'},
    },
    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
        ['<Return>'] = cmp.mapping.confirm({ select = false }),
        ['<C-Space>'] = cmp.mapping.complete()
    }),
    sorting = {
        priority_weight = 1,
        comparators = {
            cmp.config.compare.locality,
            cmp.config.compare.recently_used,
            cmp.config.compare.score,
            cmp.config.compare.offset,
            cmp.config.compare.order,
        },
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    }
})

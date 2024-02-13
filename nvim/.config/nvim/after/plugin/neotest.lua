require("neotest").setup({
    library = { plugins = { "neotest" }, types = true },
    adapters = {
        require("neotest-python")({
            dap = { justMyCode = false },
            runner = "python-unittest",
        }),
        require("neotest-plenary"),
    },
})

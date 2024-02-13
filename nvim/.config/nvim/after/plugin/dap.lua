-- set mappings for dap


vim.keymap.set("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<leader>dt", "<cmd>lua require'dap-python'.test_method()<CR>")



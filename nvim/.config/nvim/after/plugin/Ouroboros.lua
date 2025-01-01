vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "h", "hpp" },
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "<C-e>", ":Ouroboros<CR>", { noremap = true, silent = true })
    end
})



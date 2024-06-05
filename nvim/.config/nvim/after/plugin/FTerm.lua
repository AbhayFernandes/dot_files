require'FTerm'.setup({
    border = 'double',
    dimensions  = {
    },
})

vim.keymap.set('n', '<C-J>', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<C-J>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')



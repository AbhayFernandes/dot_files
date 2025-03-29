local is_code, vscode = pcall(require, "vscode")
if is_code then
    return
end

require'FTerm'.setup({
    border = 'double',
})

vim.keymap.set('n', '<C-J>', '<CMD>lua require("FTerm").toggle()<CR>')
vim.keymap.set('t', '<C-J>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')


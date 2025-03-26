local is_code, _ = pcall(require, "vscode")
if is_code then
    return
end

local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end, {})
require('telescope').load_extension('projects')

vim.api.nvim_set_keymap('n', '<leader>ph', ':lua require"telescope.builtin".find_files({ hidden = true })<CR>', {noremap = true, silent = true})


local telescope = require("telescope")

require("project_nvim").setup {
    manual_mode = false,
    detection_methods = { "lsp", "pattern" },
    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json" },
    silent_chdir = false,
    datapath = vim.fn.stdpath("data"),
}
telescope.load_extension('projects')

vim.keymap.set('n', '<leader>pp', function() require'telescope'.extensions.projects.projects{} end,{})


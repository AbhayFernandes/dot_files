require("supermaven-nvim").setup({
  keymaps = {
    accept_suggestion = "<A-l>",
    clear_suggestion = "<C-]>",
    accept_word = "<C-j>",
  },
  ignore_filetypes = { cpp = true }, -- or { "cpp", }
  disable_inline_completion = false, -- disables inline completion for use with cmp
})

require('copilot').setup({
  panel = {
    enabled = false,
  },
  suggestion = {
    enabled = false,
  },
})

require("CopilotChat").setup {
    -- See Configuration section for options
    model = "claude-3.7-sonnet",
    agent = "copilot",
    window = {
        width = 0.33,
    }
}

-- set keymaps
vim.keymap.set("n", "<leader>cc", ":CopilotChatToggle<CR>")
vim.keymap.set("n", "<leader>ce", ":CopilotChatExplain<CR>")
vim.keymap.set("n", "<leader>cf", ":CopilotChatFix<CR>")
vim.keymap.set("n", "<leader>co", ":CopilotChatOptimize<CR>")
vim.keymap.set("n", "<leader>ct", ":CopilotChatTests<CR>")


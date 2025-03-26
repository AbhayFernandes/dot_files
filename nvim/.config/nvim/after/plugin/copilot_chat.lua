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
}

-- set keymaps
vim.keymap.set("n", "<leader>cc", ":CopilotChatToggle<CR>")

local is_code, _ = pcall(require, "vscode")
if is_code then
    return
end

vim.keymap.set("n", "<leader>gs", vim.cmd.Git);

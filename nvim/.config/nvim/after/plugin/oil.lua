local is_code, _ = pcall(require, "vscode")
if is_code then
    return
end

local oil = require("oil")

oil.setup({
    default_file_explorer = true,
    buf_options = {
        buflisted = false,
        bufhidden = "hide",
    },
    keymaps = {
        ["g?"] = "actions.show_help",
        ["g."] = "actions.toggle_hidden",
        ["_"] = "actions.open_cwd"
    }
})

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

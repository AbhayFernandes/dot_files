local is_code, _ = pcall(require, "vscode")
if is_code then
    return
end

local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

local keymap = function(keys, func)
    vim.keymap.set("n", keys, func)
end

local list_select_keymap = function(index)
    keymap(
        "<leader>" .. tostring(index),
        function() harpoon:list():select(index) end
    )
end

vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>hn", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

for i = 1, 9 do
    list_select_keymap(i)
end

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-a>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-g>", function() harpoon:list():next() end)


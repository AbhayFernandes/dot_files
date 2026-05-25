require("nvim-treesitter-textobjects").setup({
    select = {
        lookahead = true,
    },
    move = {
        set_jumps = true,
    },
})

local select = require("nvim-treesitter-textobjects.select")
local move = require("nvim-treesitter-textobjects.move")
local swap = require("nvim-treesitter-textobjects.swap")

local function select_textobject(query)
    return function()
        select.select_textobject(query, "textobjects")
    end
end

vim.keymap.set({ "x", "o" }, "af", select_textobject("@function.outer"))
vim.keymap.set({ "x", "o" }, "if", select_textobject("@function.inner"))
vim.keymap.set({ "x", "o" }, "ac", select_textobject("@class.outer"))
vim.keymap.set({ "x", "o" }, "ic", select_textobject("@class.inner"))
vim.keymap.set({ "x", "o" }, "aa", select_textobject("@parameter.outer"))
vim.keymap.set({ "x", "o" }, "ia", select_textobject("@parameter.inner"))

vim.keymap.set({ "n", "x", "o" }, "]m", function()
    move.goto_next_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "]c", function()
    move.goto_next_start("@class.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[m", function()
    move.goto_previous_start("@function.outer", "textobjects")
end)
vim.keymap.set({ "n", "x", "o" }, "[c", function()
    move.goto_previous_start("@class.outer", "textobjects")
end)

vim.keymap.set("n", "<leader>sn", function()
    swap.swap_next("@parameter.inner")
end)
vim.keymap.set("n", "<leader>sp", function()
    swap.swap_previous("@parameter.inner")
end)

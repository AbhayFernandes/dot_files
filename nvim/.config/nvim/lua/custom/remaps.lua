vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", ":Oil<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>p", "\"+p")
vim.keymap.set("v", "<leader>p", "\"+p")
vim.keymap.set("n", "<leader>P", "\"+P")

vim.keymap.set("n", "<leader>f", function()
	vim.lsp.format()
end)

-- quickfix stuff
local toggle_qf =  function()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end
  if qf_exists == true then
    vim.cmd "cclose"
    return
  end
  if not vim.tbl_isempty(vim.fn.getqflist()) then
    vim.cmd "copen"
  end
end

vim.keymap.set("n", "<leader>qq", toggle_qf)
vim.keymap.set("n", "<leader>qn", "<CMD>cnext<CR>")
vim.keymap.set("n", "<leader>qp", "<CMD>cprev<CR>")

-- Unimpaired-style quickfix nav.
vim.keymap.set("n", "]q", "<CMD>cnext<CR>", { desc = "Next quickfix item" })
vim.keymap.set("n", "[q", "<CMD>cprev<CR>", { desc = "Previous quickfix item" })
vim.keymap.set("n", "]Q", "<CMD>clast<CR>", { desc = "Last quickfix item" })
vim.keymap.set("n", "[Q", "<CMD>cfirst<CR>", { desc = "First quickfix item" })

-- Auto-open quickfix when a command populates it.
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
    pattern = { "[^l]*" },
    command = "cwindow",
})

-- Close the quickfix window with `q` when inside it.
vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function(ev)
        vim.keymap.set("n", "q", "<CMD>cclose<CR>", { buffer = ev.buf, silent = true })
    end,
})

-- Terminal split at project root.
vim.keymap.set("n", "<leader>tg", function()
    local root = vim.fs.root(0, { ".git", "build.gradle", "settings.gradle" }) or vim.loop.cwd()
    vim.cmd("botright split | terminal")
    vim.api.nvim_chan_send(vim.b.terminal_job_id, "cd " .. root .. "\n")
end, { desc = "Terminal at project root" })

if vim.g.neovide == true then
  vim.api.nvim_set_keymap("n", "<C-+>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>", { silent = true })
  vim.api.nvim_set_keymap("n", "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>", { silent = true })
end

require("mason").setup()

local lsp_configs = {}
for _, file in ipairs(vim.fn.glob(vim.fn.stdpath('config') .. '/lsp/*.lua', true, true)) do
  local server_name = vim.fn.fnamemodify(file, ':t:r')
  lsp_configs[server_name] = dofile(file)
end

vim.lsp.enable(vim.tbl_keys(lsp_configs))

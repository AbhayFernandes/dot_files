-- get the path to the lua-language-server binary from mason
local path = vim.fn.stdpath("data") .. "/mason/packages/lua-language-server/lua-language-server"

return {
    cmd = { path },
    root_markers = { ".git/", ".hg/", ".svn/", "compile_commands.json" },
    filetypes = { "lua" },
}

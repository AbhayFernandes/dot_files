return {
    cmd = { "/opt/spe/opencilk/bin/clangd", "--background-index", "--pch-storage=memory" },
    root_markers = { ".git/", ".hg/", ".svn/", "compile_commands.json" },
    filetypes = { "c", "h", "hpp", "cpp", "objc", "objcpp" },
}

local is_code, _ = pcall(require, "vscode")
if is_code then
    return
end

require('fidget').setup {}

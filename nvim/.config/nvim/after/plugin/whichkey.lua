local wk = require("which-key")

wk.setup({
    preset = "modern",
})

wk.add({
    -- LSP group
    { "<leader>v", group = "LSP" },
    { "<leader>vws", desc = "Workspace Symbol" },
    { "<leader>vd", desc = "Diagnostic Float" },
    { "<leader>vca", desc = "Code Action" },
    { "<leader>vrr", desc = "References" },
    { "<leader>vrn", desc = "Rename" },
    { "<leader>vf", desc = "Format" },

    -- Telescope/Project group
    { "<leader>pf", desc = "Find Files" },
    { "<leader>ps", desc = "Live Grep" },
    { "<leader>ph", desc = "Find Hidden Files" },
    { "<leader>pv", desc = "Oil File Explorer" },

    -- Quickfix group
    { "<leader>q", group = "Quickfix" },
    { "<leader>qq", desc = "Toggle Quickfix" },
    { "<leader>qn", desc = "Next Item" },
    { "<leader>qp", desc = "Previous Item" },
    { "]q", desc = "Next Quickfix" },
    { "[q", desc = "Prev Quickfix" },
    { "]Q", desc = "Last Quickfix" },
    { "[Q", desc = "First Quickfix" },

    -- Clipboard group
    { "<leader>y", desc = "Yank to Clipboard" },
    { "<leader>Y", desc = "Yank Line to Clipboard" },
    { "<leader>p", desc = "Paste from Clipboard" },
    { "<leader>P", desc = "Paste Before from Clipboard" },

    -- Format
    { "<leader>f", desc = "Format Buffer" },

    -- Type definition
    { "<leader>D", desc = "Type Definition" },

    -- Diffview
    { "<leader>d", group = "Diffview" },
    { "<leader>dv", desc = "Diff against origin/main" },
    { "<leader>dq", desc = "Close Diffview" },

    -- Go to commands
    { "gd", desc = "Go to Definition" },
    { "gD", desc = "Go to Declaration" },
    { "gi", desc = "Go to Implementation" },
    { "gr", desc = "Go to References" },
    { "gu", desc = "LSP References (Telescope)" },

    -- Diagnostics
    { "]d", desc = "Next Diagnostic" },
    { "[d", desc = "Previous Diagnostic" },

    -- Oil file explorer
    { "-", desc = "Open Parent Directory" },

    -- Movement (visual mode)
    { "J", desc = "Move Line Down", mode = "v" },
    { "K", desc = "Move Line Up", mode = "v" },

    -- Leap motion
    { "s", desc = "Leap Forward", mode = { "n", "x", "o" } },
    { "S", desc = "Leap Backward", mode = { "n", "x", "o" } },
    { "gs", desc = "Leap From Window", mode = { "n", "x", "o" } },

    -- Spider motion (enhanced word motions)
    { "w", desc = "Spider Word Forward", mode = { "n", "o", "x" } },
    { "e", desc = "Spider Word End", mode = { "n", "o", "x" } },
    { "b", desc = "Spider Word Backward", mode = { "n", "o", "x" } },

    -- Neovide zoom (conditional)
    { "<C-+>", desc = "Zoom In (Neovide)", mode = "n" },
    { "<C-->", desc = "Zoom Out (Neovide)", mode = "n" },
    { "<C-0>", desc = "Reset Zoom (Neovide)", mode = "n" },

    -- Centered scrolling
    { "J", desc = "Join Lines (Centered)", mode = "n" },
    { "<C-d>", desc = "Scroll Down (Centered)", mode = "n" },
    { "<C-u>", desc = "Scroll Up (Centered)", mode = "n" },
    { "n", desc = "Next Search (Centered)", mode = "n" },
    { "N", desc = "Previous Search (Centered)", mode = "n" },
})

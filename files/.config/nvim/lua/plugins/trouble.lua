return {
    "folke/trouble.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    keys = {
        {
            "<leader>xx",
            function()
                vim.cmd("Trouble diagnostics toggle")
                vim.cmd("Trouble diagnostics focus")
            end,
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>xq",
            function()
                vim.cmd("Trouble qflist toggle")
                vim.cmd("Trouble qflist focus")
            end,
            desc = "Quickfix List (Trouble)",
        },
        {
            "gr",
            function()
                vim.cmd("Trouble lsp_references toggle")
                vim.cmd("Trouble lsp_references focus")
            end,
            desc = "Quickfix List (Trouble)",
        },
        {
            "<leader>xi",
            function()
                vim.cmd("Trouble lsp_implementations toggle")
                vim.cmd("Trouble lsp_implementations focus")
            end,
            desc = "Quickfix List (Trouble)",
        }
    },
    opts = {},
}

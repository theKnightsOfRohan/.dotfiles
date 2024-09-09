return {
    "theKnightsOfRohan/onedark.nvim",
    config = function()
        vim.cmd("colorscheme onedark")
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
    end,
}

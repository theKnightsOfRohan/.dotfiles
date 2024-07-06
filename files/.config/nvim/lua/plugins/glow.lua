return {
    "ellisonleao/glow.nvim",
    config = function()
        require("glow").setup({
            glow_path = "/opt/homebrew/bin/glow",
            border = "rounded", -- floating window border config
            pager = false,
            width_ratio = 0.7,  -- maximum width of the Glow window compared to the nvim window size
            height_ratio = 0.7,
        })
    end,
}

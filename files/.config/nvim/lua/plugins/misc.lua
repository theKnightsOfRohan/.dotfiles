return {
    {
        "mhinz/vim-signify",
    },
    {
        dir = "~/Documents/GitHub/personal/hexer.nvim",
        config = function()
            require("hexer").setup()
        end
    }
}

return {
    -- "theKnightsOfRohan/hexer.nvim",
    dir = "~/Documents/GitHub/personal/hexer.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("hexer").setup()
    end,
}

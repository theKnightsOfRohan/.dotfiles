return {
    "theKnightsOfRohan/csvlens.nvim",
    config = function()
        require("csvlens").setup({
            direction = "float",
            exec_path = "/opt/homebrew/bin/csvlens",
            exec_install_path = vim.fn.stdpath("data") .. "/csvlens.nvim/",
        })
    end,
}

return {
    -- "CWood-sdf/banana.nvim",
    dir = "~/Documents/GitHub/personal/banana.nvim/",
    config = function()
        local Banana = require("banana")
        Banana.initTsParsers()

        -- vim.filetype.add({ extension = { nml = "nml" } })
        -- vim.filetype.add({ extension = { ncss = "ncss" } })
    end,
}

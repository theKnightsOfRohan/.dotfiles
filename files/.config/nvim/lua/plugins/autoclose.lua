return {
    "m4xshen/autoclose.nvim",
    config = function()
        -- AUTOCLOSE
        require("autoclose").setup({
            options = {
                disable_command_mode = true,
            },
        })
    end,
}

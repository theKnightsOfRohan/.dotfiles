return {
    "tamton-aquib/keys.nvim",
    config = function()
        require("keys").setup({
            enable_on_startup = false,
            win_opts = {
                width = 20,
                height = 3,
            },
        })
    end,
}

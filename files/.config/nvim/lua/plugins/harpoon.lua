return {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("harpoon"):setup({
            settings = {
                save_on_toggle = true,
                sync_on_ui_close = true,
                key = function()
                    return vim.loop.cwd()
                end,
            },
        })

        vim.keymap.set("n", "<leader>h", function()
            require("harpoon"):list():add()
        end)
        vim.keymap.set("n", "<leader>ht", function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end)

        -- TODO: Figure out how to turn this into numbers
        for i = 1, 4 do
            vim.keymap.set({ "n", "i" }, "<C-" .. tostring(i) .. ">", function()
                require("harpoon"):list():select(i)
            end)
        end
    end,
}

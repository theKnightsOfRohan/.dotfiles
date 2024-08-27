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
        vim.keymap.set("n", "<C-a>", function()
            require("harpoon"):list():select(1)
        end)
        vim.keymap.set("n", "<C-s>", function()
            require("harpoon"):list():select(2)
        end)
        vim.keymap.set("n", "<C-d>", function()
            require("harpoon"):list():select(3)
        end)
        vim.keymap.set("n", "<C-f>", function()
            require("harpoon"):list():select(4)
        end)
    end,
}

return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "folke/trouble.nvim"
    },
    config = function()
        require("telescope").setup({
            defaults = {
                mappings = {
                    i = {
                        ["<C-q>"] = function(prompt_bufnr)
                            require("telescope.actions").send_to_qflist(prompt_bufnr)
                            vim.cmd("Trouble qflist toggle")
                            vim.cmd("Trouble qflist focus")
                        end
                    },
                    n = {
                        ["<C-q>"] = function(prompt_bufnr)
                            require("telescope.actions").send_to_qflist(prompt_bufnr)
                            vim.cmd("Trouble qflist toggle")
                            vim.cmd("Trouble qflist focus")
                        end
                    },
                },
            },
        })

        local telescope_builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>pf", telescope_builtin.find_files, {})
        vim.keymap.set("n", "<leader>ps", telescope_builtin.live_grep, {})
        vim.keymap.set("n", "<leader>H", telescope_builtin.help_tags, {})
    end,
}

return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "folke/trouble.nvim"
    },
    config = function()
        require("telescope").setup({
            defaults = {
                layout_strategy = "horizontal",
                layout_config = { height = { padding = 0 }, width = { padding = 0 } },
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
                        end,
                        ["q"] = function(prompt_bufnr)
                            require("telescope.actions").close(prompt_bufnr)
                        end,
                        ["<Esc>"] = function(prompt_bufnr)
                            require("telescope.actions").close(prompt_bufnr)
                        end,
                        ["l"] = require("telescope.actions").select_default
                    },
                },
            },
        })

        local telescope_builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>pf", telescope_builtin.find_files, {})
        vim.keymap.set("n", "<leader>ps", telescope_builtin.live_grep, {})
        vim.keymap.set("n", "<leader>pl", telescope_builtin.lsp_dynamic_workspace_symbols, {})
        vim.keymap.set("n", "<leader>M", telescope_builtin.man_pages, {})
        vim.keymap.set("n", "<leader>H", telescope_builtin.help_tags, {})
    end,
}

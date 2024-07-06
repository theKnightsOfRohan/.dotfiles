return {
    "akinsho/toggleterm.nvim",
    config = function()
        require("toggleterm").setup({
            size = 20,
            open_mapping = [[<leader>t]],
            hide_numbers = true,
            shade_filetypes = {},
            shade_terminals = true,
            shading_factor = 2,
            start_in_insert = true,
            persist_size = true,
            direction = "float",
            ---@param t Terminal
            on_open = function(t)
                vim.keymap.set("t", "<C-Esc>", [[<C-\><C-n>]])
                vim.keymap.set("n", "q", function()
                    t:close()
                end);
            end,
            close_on_exit = true,
            shell = vim.o.shell,
            float_opts = {
                border = "curved",
                winblend = 0,
                highlights = {
                    border = "Normal",
                    background = "Normal",
                },
                width = vim.fn.ceil(vim.fn.winwidth(0) * 0.9),
                height = vim.fn.ceil(vim.fn.winheight(0) * 0.9),
            },
        })

        vim.keymap.set("t", "<C-Esc>", [[<C-\><C-n>]])
    end,
}

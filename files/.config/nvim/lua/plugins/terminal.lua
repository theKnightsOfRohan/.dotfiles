return {
    "jaimecgomezz/here.term",
    config = function()
        require("here-term").setup({
            -- The command we run when exiting the terminal and no other buffers are listed. An empty
            -- buffer is shown by default.
            startup_command = "", -- Startify, Dashboard, etc. Make sure it has been loaded before `here.term`.

            -- Mappings
            -- Every mapping bellow can be customized by providing your preferred combo, or disabled
            -- entirely by setting them to `nil`.
            --
            -- The minimal mappings used to toggle and kill the terminal. Available in
            -- `normal` and `terminal` mode.
            mappings = {
                toggle = "<leader>t",
                kill = "<leader>T",
            },
            -- Additional mappings that I consider useful since you won't have to escape (<C-\><C-n>)
            -- the terminal each time. Available in `terminal` mode.
            extra_mappings = {
                enable = false,   -- Disable them entirely
                escape = "<C-x>", -- Escape terminal mode
                left = "<C-w>h",  -- Move to the left window
                down = "<C-w>j",  -- Move to the window down
                up = "<C-w>k",    -- Move to the window up
                right = "<C-w>l", -- Move to right window
            },
        })

        vim.keymap.set({ "n", "t" }, "<leader>t", function() require("here-term").toggle_terminal() end)
        vim.keymap.set("t", "<C-Esc>", [[<C-\><C-n>]])
        vim.keymap.set("n", "<leader>g", function()
            local id

            id = vim.api.nvim_create_autocmd("TermEnter", {
                callback = function()
                    local cmd = vim.api.nvim_replace_termcodes("lazygit<CR>", true, false, true)
                    vim.api.nvim_feedkeys(cmd, "t", true)

                    vim.api.nvim_del_autocmd(id);
                end
            })

            require("here-term").toggle_terminal()
        end)
    end,
}

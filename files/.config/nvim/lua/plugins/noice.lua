return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("noice").setup({
            -- cmdline = {
            --     menu = "popup",
            -- },
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                },
            },
            popupmenu = {
                backend = "nui",
            },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = false,        -- use a classic bottom cmdline for search
                command_palette = true,       -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = true,        -- add a border to hover docs and signature help
            },
        })

        -- See https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428
        local notify = vim.notify

        ---@param msg string
        ---@param ... any
        vim.notify = function(msg, ...)
            if
                msg:match(
                    "warning: multiple different client offset_encodings detected for buffer, this is not supported yet"
                )
            then
                return
            end

            notify(msg, ...)
        end
    end,
}

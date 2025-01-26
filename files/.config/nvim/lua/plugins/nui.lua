return {
    "MunifTanjim/nui.nvim",
    event = "VeryLazy",
    dependencies = {
        {
            "MeanderingProgrammer/render-markdown.nvim",
            dependencies = {
                'nvim-treesitter/nvim-treesitter',
                'nvim-tree/nvim-web-devicons'
            },
            opts = {},
        }
    },
    config = function()
        ---@param items Array
        ---@param format_item function
        ---@param prompt string
        ---@return integer
        local function get_max_length(items, format_item, prompt)
            local max_length = 0
            for _, item in ipairs(items) do
                local length = #(format_item(item))
                if length > max_length then
                    max_length = length
                end
            end

            if #prompt > max_length then
                max_length = #prompt
            end

            return max_length
        end

        vim.ui.select = function(items, opts, on_choice)
            vim.validate({
                items = { items, 'table', false },
                opts = { opts, 'table', true },
                on_choice = { on_choice, 'function', false },
            })
            opts = opts or {}
            local format_item = opts.format_item or tostring

            local Menu = require("nui.menu")

            Menu({
                relative = "cursor",
                position = {
                    row = 2,
                    col = 0,
                },
                size = {
                    width = get_max_length(items, format_item, opts.prompt or "Select an item"),
                },
                zindex = 1000,
                border = {
                    style = "rounded",
                    text = {
                        top = opts.prompt or "Select an item",
                        top_align = "center",
                    },
                },
            }, {
                lines = (function()
                    ---@type NuiTree.Node[]
                    local selections = {}

                    for _, item in ipairs(items) do
                        table.insert(selections, Menu.item(format_item(item), { data = item }))
                    end

                    return selections
                end)(),

                on_close = function()
                    print("Closed")
                end,
                on_submit = function(selected)
                    on_choice(selected.data)
                end,
            }):mount()
        end

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

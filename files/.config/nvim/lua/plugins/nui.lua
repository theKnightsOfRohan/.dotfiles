return {
    "MunifTanjim/nui.nvim",
    config = function()
        local Menu = require("nui.menu")

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
    end,
}

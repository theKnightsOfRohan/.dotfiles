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
            if msg:match("warning: multiple different client offset_encodings detected for buffer, this is not supported yet") then
                return
            end

            notify(msg, ...)
        end

        --- Prompts the user for input, allowing arbitrary (potentially asynchronous) work until
        --- `on_confirm`.
        ---
        --- Example:
        ---
        --- ```lua
        --- vim.ui.input({ prompt = 'Enter value for shiftwidth: ' }, function(input)
        ---     vim.o.shiftwidth = tonumber(input)
        --- end)
        --- ```
        ---
        ---@param opts table? Additional options. See |input()|
        ---     - prompt (string|nil)
        ---               Text of the prompt
        ---     - default (string|nil)
        ---               Default reply to the input
        ---     - completion (string|nil)
        ---               Specifies type of completion supported
        ---               for input. Supported types are the same
        ---               that can be supplied to a user-defined
        ---               command using the "-complete=" argument.
        ---               See |:command-completion|
        ---     - highlight (function)
        ---               Function that will be used for highlighting
        ---               user inputs.
        ---@param on_confirm function ((input|nil) -> ())
        ---               Called once the user confirms or abort the input.
        ---               `input` is what the user typed (it might be
        ---               an empty string if nothing was entered), or
        ---               `nil` if the user aborted the dialog.
        --[[ vim.ui.input = function(opts, on_confirm)
            vim.validate({
                opts = { opts, 'table', true },
                on_confirm = { on_confirm, 'function', false },
            })

            opts = (opts and not vim.tbl_isempty(opts)) and opts or vim.empty_dict()

            -- Note that vim.fn.input({}) returns an empty string when cancelled.
            -- vim.ui.input() should distinguish aborting from entering an empty string.
            local _canceled = vim.NIL
            opts = vim.tbl_extend('keep', opts, { cancelreturn = _canceled })

            local input = require("nui.input")({
                relative = "cursor",
                position = {
                    row = 1,
                    col = 0,
                },
                size = 20,
                border = {
                    style = "rounded",
                },
                win_options = {
                    winhighlight = "Normal:Normal",
                },
            }, {
                prompt = opts.prompt,
                default_value = opts.default,
                on_close = function()
                    on_confirm(nil)
                end,
                on_submit = function(value)
                    on_confirm(value)
                end,
            })

            input:mount()

            input:on(require("nui.utils.autocmd").BufLeave, function()
                input:unmount()
            end)
        end ]]
    end,
}

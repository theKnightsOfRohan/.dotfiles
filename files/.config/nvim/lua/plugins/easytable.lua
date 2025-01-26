return {
    "Myzel394/easytables.nvim",
    config = function()
        require("easytables").setup {
            table = {
                -- Whether to enable the header by default
                header_enabled_by_default = true,
                window = {
                    preview_title = "Table Preview",
                    prompt_title = "Cell content",
                    -- Either "auto" to automatically size the window, or a string
                    -- in the format of "<width>x<height>" (e.g. "20x10")
                    size = "auto"
                },
                cell = {
                    -- Min width of a cell (excluding padding)
                    min_width = 3,
                    -- Filler character for empty cells
                    filler = " ",
                    align = "left",
                },
                -- Characters used to draw the table
                -- Do not worry about multibyte characters, they are handled correctly
                border = {
                    top_left = "┌",
                    top_right = "┐",
                    bottom_left = "└",
                    bottom_right = "┘",
                    horizontal = "─",
                    vertical = "│",
                    left_t = "├",
                    right_t = "┤",
                    top_t = "┬",
                    bottom_t = "┴",
                    cross = "┼",
                    header_left_t = "╞",
                    header_right_t = "╡",
                    header_bottom_t = "╧",
                    header_cross = "╪",
                    header_horizontal = "═",
                }
            },
            export = {
                markdown = {
                    -- Padding around the cell content, applied BOTH left AND right
                    -- E.g: padding = 1, content = "foo" -> " foo "
                    padding = 1,
                    -- What markdown characters are used for the export, you probably
                    -- don't want to change these
                    characters = {
                        horizontal = "-",
                        vertical = "|",
                        -- Filler for padding
                        filler = " "
                    }
                }
            },
            set_mappings = function(buf)
                vim.keymap.set(
                    "n",
                    "h",
                    function() vim.cmd("silent! JumpLeft") end,
                    { buffer = buf, }
                )
                vim.keymap.set(
                    "n",
                    "H",
                    function() vim.cmd("silent! SwapWithLeftCell") end,
                    { buffer = buf, }
                )

                vim.keymap.set(
                    "n",
                    "l",
                    function() vim.cmd("silent! JumpRight") end,
                    { buffer = buf, }
                )
                vim.keymap.set(
                    "n",
                    "L",
                    function() vim.cmd("silent! SwapWithRightCell") end,
                    { buffer = buf, }
                )

                vim.keymap.set(
                    "n",
                    "k",
                    function() vim.cmd("silent! JumpUp") end,
                    { buffer = buf, }
                )
                vim.keymap.set(
                    "n",
                    "K",
                    function() vim.cmd("silent! SwapWithUpperCell") end,
                    { buffer = buf, }
                )

                vim.keymap.set(
                    "n",
                    "j",
                    function() vim.cmd("silent! JumpDown") end,
                    { buffer = buf, }
                )
                vim.keymap.set(
                    "n",
                    "J",
                    function() vim.cmd("silent! SwapWithLowerCell") end,
                    { buffer = buf, }
                )

                vim.keymap.set(
                    "i",
                    "<CR>",
                    function() vim.cmd("silent! JumpDown") end,
                    { buffer = buf, }
                )
                vim.keymap.set(
                    "i",
                    "<S-CR>",
                    function() vim.cmd("silent! JumpUp") end,
                    { buffer = buf, }
                )

                vim.keymap.set(
                    "n",
                    "<Tab>",
                    function() vim.cmd("silent! JumpToNextCell") end,
                    { buffer = buf, }
                )
                vim.keymap.set(
                    "i",
                    "<Tab>",
                    function() vim.cmd("silent! JumpToNextCell") end,
                    { buffer = buf, }
                )
                vim.keymap.set(
                    "n",
                    "<S-Tab>",
                    function() vim.cmd("silent! JumpToPreviousCell") end,
                    { buffer = buf, }
                )
                vim.keymap.set(
                    "i",
                    "<S-Tab>",
                    function() vim.cmd("silent! JumpToPreviousCell") end,
                    { buffer = buf, }
                )

                vim.keymap.set(
                    "n",
                    "<C-l>",
                    function() vim.cmd("silent! SwapWithRightColumn") end,
                    { buffer = buf, }
                )
                vim.keymap.set(
                    "n",
                    "<C-k>",
                    function() vim.cmd("silent! SwapWithUpperRow") end,
                    { buffer = buf, }
                )
                vim.keymap.set(
                    "n",
                    "<C-j>",
                    function() vim.cmd("silent! SwapWithLowerRow") end,
                    { buffer = buf, }
                )
            end

        }
    end
}

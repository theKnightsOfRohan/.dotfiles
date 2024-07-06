return {
    "numToStr/Comment.nvim",
    config = function()
        require("Comment").setup({
            -- Add a space b/w comment and the line
            padding = true,
            -- Whether the cursor should stay at its position
            sticky = true,
            -- Lines to be ignored while (un)comment
            ignore = nil,
            -- LHS of toggle mappings in NORMAL mode
            toggler = {
                line = "<C-/>",
                block = "<C-\\>",
            },
            -- LHS of operator-pending mappings in NORMAL and VISUAL mode
            opleader = {
                line = "<C-/>",
                block = "<C-\\>",
            },
            -- LHS of extra mappings
            extra = {
                above = "gcO",
                below = "gco",
                eol = "gcA",
            },
            -- Enable keybindings
            mappings = {
                basic = true,
                extra = false,
            },
            pre_hook = nil,
            post_hook = nil,
        })
    end,
}

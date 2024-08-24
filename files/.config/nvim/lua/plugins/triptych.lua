return {
    "simonmclean/triptych.nvim",
    -- dir = "~/Documents/Github/personal/triptych.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "mhinz/vim-signify",
    },
    config = function()
        require("triptych").setup({
            mappings = {
                -- Everything below is buffer-local, meaning it will only apply to Triptych windows
                show_help = 'g?',
                jump_to_cwd = '.', -- Pressing again will toggle back
                nav_left = 'h',
                nav_right = 'l',   -- If target is a file, opens the file in-place
                open_hsplit = { '-' },
                open_vsplit = { '|' },
                open_tab = { '<C-t>' },
                cd = '<leader>cd',
                delete = 'd',
                add = 'a',
                copy = 'c',
                rename = 'r',
                cut = 'x',
                paste = 'p',
                quit = 'q',
                toggle_hidden = '<leader>.',
            },
            extension_mappings = {},
            options = {
                dirs_first = true,
                show_hidden = false,
                line_numbers = {
                    enabled = true,
                    relative = false,
                },
                file_icons = {
                    enabled = true,
                    directory_icon = '',
                    fallback_file_icon = ''
                },
                responsive_column_widths = {
                    -- Keys are breakpoints, values are column widths
                    -- A breakpoint means "when vim.o.columns >= x, use these column widths"
                    -- Columns widths must add up to 1 after rounding to 2 decimal places
                    -- Parent or child windows can be hidden by setting a width of 0
                    ['0'] = { 0, 0.5, 0.5 },
                    ['120'] = { 0.2, 0.3, 0.5 },
                    ['200'] = { 0.25, 0.25, 0.5 },
                },
                highlights = { -- Highlight groups to use. See `:highlight` or `:h highlight`
                    file_names = 'NONE',
                    directory_names = 'NONE',
                },
                syntax_highlighting = { -- Applies to file previews
                    enabled = true,
                    debounce_ms = 100,
                },
                backdrop = 60 -- Backdrop opacity. 0 is fully opaque, 100 is fully transparent (disables the feature)
            },
            git_signs = {
                enabled = true,
                signs = {
                    -- The value can be either a string or a table.
                    -- If a string, will be basic text. If a table, will be passed as the {dict} argument to vim.fn.sign_define
                    -- If you want to add color, you can specify a highlight group in the table.
                    add = { text = "+", texthl = "SignifySignAdd" },
                    modify = { text = "~", texthl = "SignifySignChange" },
                    rename = { text = "r", texthl = "SignifySignChange" },
                    untracked = { text = "?", texthl = "SignifySignDelete" },
                },
            },
            diagnostic_signs = {
                enabled = true,
            }
        })

        vim.keymap.set("n", "<leader>pv", vim.cmd.Triptych, { silent = true })
    end,
}

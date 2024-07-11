return {
    "L3MON4D3/LuaSnip",
    dependencies = {
        "chrisgrieser/nvim-scissors",
        "nvim-telescope/telescope.nvim",
        "garymjr/nvim-snippets",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "saadparwaiz1/cmp_luasnip",
    },
    config = function()
        -- default settings
        require("scissors").setup {
            snippetDir = vim.fn.stdpath("config") .. "/snippets",
            editSnippetPopup = {
                height = 0.4, -- relative to the editor, number between 0 and 1
                width = 0.6,
                border = "rounded",
                keymaps = {
                    cancel = "q",
                    saveChanges = "<CR>", -- alternatively, can also use `:w`
                    goBackToSearch = "<BS>",
                    deleteSnippet = "<C-BS>",
                    duplicateSnippet = "<C-d>",
                    openInFile = "<C-o>",
                    insertNextPlaceholder = "<C-p>", -- insert & normal mode
                },
            },
            backdrop = {
                enabled = true,
                blend = 50, -- between 0-100
            },
            telescope = {
                -- By default, the query only searches snippet prefixes. Set this to
                -- `true` to also search the body of the snippets.
                alsoSearchSnippetBody = false,
            },
            -- `none` writes as a minified json file using `vim.encode.json`.
            -- `yq`/`jq` ensure formatted & sorted json files, which is relevant when
            -- you version control your snippets.
            jsonFormatter = "jq", -- "yq"|"jq"|"none"
        }

        local ls = require("luasnip")
        require("luasnip.loaders.from_vscode").lazy_load({
            paths = {
                vim.fn.stdpath("config") .. "/snippets",
            }
        })

        vim.keymap.set({ "i", "s" }, "<C-l>", function()
            if ls.expand_or_jumpable() then
                ls.expand_or_jump()
            end
        end, { silent = true })

        vim.keymap.set({ "i", "s" }, "<C-h>", function()
            if ls.expand_or_jumpable(-1) then
                ls.expand_or_jump(-1)
            end
        end, { silent = true })

        local cmp = require("cmp")

        cmp.setup({
            window = {
                documentation = cmp.config.window.bordered(),
                completion = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<C-CR>"] = cmp.mapping.confirm({ select = true }),
            }),
            sources = {
                { name = "nvim_lua" },
                { name = "nvim_lsp" },
                { name = "path" },
                { name = "luasnip" },
            },
            snippet = {
                expand = function(args)
                    ls.lsp_expand(args.body)
                end,
            }
        })
    end,
}
